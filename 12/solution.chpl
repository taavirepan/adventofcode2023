use IO;
use List;

proc parse(line: string, count: int) {
    var s0 = line.split();
    var s = (s0[0], s0[1]);
    for i in 2..count
    {
        s[0] += "?" + s0[0];
        s[1] += "," + s0[1];
    }
    var numbers = for x in s[1].split(",") do x:int;
    return ("." + s[0], new list(numbers));
}

proc is_legit(s, n)
{
    const lead = s[0..s.size-1-n];
    const group = s[s.size-n..s.size-1];
    return lead.count("#") == 0 && group.count(".") == 0;
}

proc solve(data: (string, list(int))): int {
    if data[1].size == 0
    {
        return if data[0].count("#") > 0 then 0 else 1;
    }
    var rest = data[1];
    const group = rest.getAndRemove(0);
    var ret: int;
    for i in group+1..data[0].size
    {
        const first = data[0][0..i-1];
        if is_legit(first, group) then
            ret += solve((data[0][i..data[0].size-1], rest));
    }
    return ret;
}

var lines = stdin.lines(true);
writeln(+ reduce solve(parse(lines, 1)));
writeln(+ reduce solve(parse(lines, 5)));
