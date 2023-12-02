use IO;
use Regex;
use Map;

proc task1(line: string): int
{
    var game_and_cubes = line.split(": ");
    var s = game_and_cubes[0].split(" ");
    var id = s[1]:int;
    for subset in game_and_cubes[1].split("; ") {
        var counts: map(string, int);
        for cubes in subset.split(", ") {
            s = cubes.split(" ");
            counts[s[1]] += s[0]:int;
        }
        if counts.get("red",0) > 12 || counts.get("green",0) > 13 || counts.get("blue",0) > 14 then
            return 0;
    }
    return id;
}

var lines = stdin.lines(true);
writeln(+ reduce task1(lines)); 
