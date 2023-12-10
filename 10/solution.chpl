use IO;
use List;

proc translate(sym): int(8) {
    select sym {
        //                   WENS
        when '|' do return 0b0011;
        when '-' do return 0b1100;
        when 'L' do return 0b0110;
        when 'J' do return 0b1010;
        when '7' do return 0b1001;
        when 'F' do return 0b0101;
        when 'S' do return -1;
        otherwise return 0;
    }
}

proc read_input() {
    var input = stdin.lines(true);
    var ret: [0..input.size-1, 0..input[0].size-1] int(8);
    for i in input.indices
    {
        ret[i,..] = for s in input[i].items() do translate(s);
    }
    return ret;
}

iter directions(pipes, pos) {
    if pipes & 0b0100 then
        yield pos + (0, 1);
    if pipes & 0b1000 then
        yield pos + (0, -1);
    if pipes & 0b0001 then
        yield pos + (1, 0);
    if pipes & 0b0010 then
        yield pos + (-1, 0);
}

record Node {
    var pos: 2*int;
    var distance: int;
}

proc task1(data: [?d] int(8)) {
    var ret: int;
    var distance: [d] int = -1;
    var queue: list(Node);
    queue.pushBack(new Node(data.find(-1), 0));
    while queue.size
    {
        var node = queue.getAndRemove(0);
        // if distance[node.pos] != -1 then
        //     continue;
        distance[node.pos] = node.distance;
        if node.distance > ret
        {
            // var nbors = + reduce (for p in directions(data[node.pos], node.pos) do if distance[p] == node.distance - 1 then 1 else 0);
            // if nbors >= 2 then
                ret = node.distance;
        }
        for p in directions(data[node.pos], node.pos)
        {
            if distance.domain.contains(p) && distance[p] == -1 && data[p] != 0
            {
                for pp in directions(data[p], p)
                {
                    if pp == node.pos then
                        queue.pushBack(new Node(p, node.distance + 1));
                }
            }
        }
    }
    return ret;
}

var data = read_input();
writeln(task1(data));
// 6563 too low