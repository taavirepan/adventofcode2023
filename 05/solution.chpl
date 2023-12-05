use Regex;
use IO;

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

var input = stdin.readString(1024*1024).split("\n\n");
writeln(task1(input));