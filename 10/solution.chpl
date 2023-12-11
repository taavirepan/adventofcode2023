use IO;
use List;
use Set;

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

iter candidate_steps(data, pos) {
    if data[pos] & 0b0100 then
        yield pos + (0, 1);
    if data[pos] & 0b1000 then
        yield pos + (0, -1);
    if data[pos] & 0b0001 then
        yield pos + (1, 0);
    if data[pos] & 0b0010 then
        yield pos + (-1, 0);
}

iter directions(data, pos) {
    for p in candidate_steps(data, pos)
    {
        if !data.domain.contains(p) then
            continue;
        for p0 in candidate_steps(data, p)
        {
            if p0 == pos then
                yield p;
        }
    }
}

proc find_loop(data: [?d] int(8)) {
    var visited: [d] bool;
    var path: list(2*int);
    var best: list(2*int);
    var start = data.find(-1);
    path.pushBack(start);
    label outer while (path.size)
    {
        var loops: bool;
        visited[path.last] = true;
        for next in directions(data, path.last)
        {
            loops |= next == start;
            if !visited[next]
            {

                path.pushBack(next);
                continue outer;
            }
        }

        // fallback, found no good candidate
        if loops && path.size > best.size then
            best = path;
        path.popBack();
    }
    best.pushBack(start);
    return best;
}

proc mark_edges(data: [?d] int(8), loop) {
    var ret: [d] int;
    for i in 1..loop.size-1
    {
        const p1 = loop[i-1];
        const p2 = loop[i];
        if p1[1] == p2[1]
        {
            const d = p1[0] - p2[0];
            ret[p1] += d;
            ret[p2] += d;
        }
    }
    return ret;
}

proc inside(p, edges, loop) {
    var count: int;
    if loop.contains(p) then
        return false;
    for i in 0..p[1]
    {
        count += edges[p[0], i];
    }
    return count != 0;
}

var data = read_input();
var loop = find_loop(data);

writeln(loop.size / 2);

var edges = mark_edges(data, loop);
var loopset = new set(2*int, loop);
writeln(+ reduce (for p in edges.indices do inside(p, edges, loopset)));
