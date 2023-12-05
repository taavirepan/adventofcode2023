use Regex;
use IO;
use List;

proc task1(blocks) {
    var re = new regex("[[:digit:]]+");
    var seeds = for match in re.matches(blocks[0]) do blocks[0][match[0]]:int;
    for block in blocks[1..]
    {
        var seeds2 = seeds;
        for line in block.split("\n")
        {
            if line.size == 0 || line[line.size - 1] == ":" then
                continue;
            var parsed = for s in line.split() do s:int;
            for i in seeds.indices
            {
                var seed = seeds[i];
                if (parsed[1] <= seed && seed < parsed[1] + parsed[2]) then
                    seeds2[i] = parsed[0] + seed - parsed[1];
            }
        }
        seeds = seeds2;
    }
    return min reduce seeds;
}

iter parse_block(block) {
    for line in block.split("\n")
    {
        if line.size == 0 || line[line.size - 1] == ":" then
            continue;
        var parsed = for s in line.split() do s:int;
        yield parsed;
    }
}

proc task2(blocks) {
    var re = new regex("([[:digit:]]+) ([[:digit:]]+)");
    var seeds = new list(for match in re.matches(blocks[0], 2) do (blocks[0][match[1]]:int, blocks[0][match[1]]:int+blocks[0][match[2]]:int));
    for block in blocks[1..]
    {
        for parsed in parse_block(block)
        {
            var split: list(2*int);
            for seed in seeds
            {
                var p1 = max(min(seed[1], parsed[1]), seed[0]);
                var p2 = max(min(seed[1], parsed[1] + parsed[2]), seed[0]);
                if seed[0] != p1 then split.pushBack((seed[0], p1));
                if p1 != p2 then split.pushBack((p1, p2));
                if p2 != seed[1] then split.pushBack((p2, seed[1]));
            }
            seeds = split;
        }
        var seeds2: list(2*int);
        for parsed in parse_block(block)
        {
            for i in seeds.indices
            {
                var seed = seeds[i];
                if (seed[0] >= parsed[1] && seed[1] <= parsed[1] + parsed[2])
                {
                    var ofs = parsed[0] - parsed[1];
                    seeds2.pushBack(seed + ofs);
                    seeds[i] = (-1, -1);
                }
            }
        }
        seeds.remove((-1,-1), 0);
        seeds2.pushBack(seeds);
        seeds = seeds2;
    }
    return min reduce (for seed in seeds do seed[0]);
}
var input = stdin.readString(1024*1024).split("\n\n");
writeln(task1(input));
writeln(task2(input));