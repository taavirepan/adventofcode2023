use IO;
use List;
use Regex;
use Sort;

record Data
{
    const size: int;
    var data: string;
    var cum_counts: [0..2, 0..size] int;

    proc init(s: string)
    {
        size = s.size;
        data = s;
        init this;

        for i in 1..size
        {
            const ch = this.translate(s[i-1]);
            for j in 0..2 do
                cum_counts[j,i] = cum_counts[j,i-1];
            cum_counts[ch,i] += 1;
        }
    }

    proc translate(s: string)
    {
        select s
        {
            when "#" do return 0;
            when "." do return 1;
            otherwise return 2;
        }
    }

    proc query(s: string)
    {
        return cum_counts[this.translate(s), size];
    }

    proc query(s: string, start: int)
    {
        return cum_counts[this.translate(s), size] - cum_counts[this.translate(s), start];
    }

    proc query(s: string, start: int, count: int)
    {
        return cum_counts[this.translate(s), start + count] - cum_counts[this.translate(s), start];
    }

    proc this(i: int)
    {
        return data[i];
    }
}

proc parse(line: string, count: int) {
    var s0 = line.split();
    var s = (s0[0], s0[1]);
    for i in 2..count
    {
        s[0] += "?" + s0[0];
        s[1] += "," + s0[1];
    }
    var numbers = for x in s[1].split(",") do x:int;
    return (new Data(s[0] + "."), new list(numbers));
}

proc solve(data: (Data, list(int)), ref cache, offset:int=0, gidx:int=0): int {
    if !data[1].size then
        return if data[0].query("#", offset) == 0 then 1 else 0;
    var groups = data[1];
    const group = groups.getAndRemove(0);
    const remaining = + reduce groups;

    if cache[offset, gidx] then
        return cache[offset, gidx] - 1;

    var upper_bound: int;
    for i in offset..data[0].size - group - 1
    {
        if data[0].query("#", offset, i - offset) == 0 then
            upper_bound = i;
        else
            break;
    }

    var ret:int;
    for i in 0..upper_bound - offset
    {
        const start = upper_bound - i;
        if data[0].query(".", start, group) == 0 && data[0][start+group] != "#" then
        {
            const sol = solve((data[0], groups), cache, start + group + 1, gidx +1);
            ret += sol;
        }
    }
    cache[offset, gidx] = ret + 1;
    return ret;
}

var lines = stdin.lines(true);

var task1: int;
for item in parse(lines, 1)
{
    var cache: [0..100, 0..20] int;
    task1 += solve(item, cache);
}
writeln(task1);
var task2: int;
for item in parse(lines, 5)
{
    var cache: [0..item[0].size, 0..item[1].size] int;
    task2 += solve(item, cache);
}
writeln(task2);
