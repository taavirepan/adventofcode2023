use IO;
use Set;
use Regex;

proc task1(line: string) {
    var s = line.split("|");
    var s2 = s[0].split(": ");
    var re = new regex("[[:digit:]]+");
    var x = for m in re.matches(s2[1]) do s2[1](m[0]);
    var digits = new set(string, x);
    var ret:int;
    for m in re.matches(s[1]) {
        if digits.contains(s[1](m[0])) then
            ret += 1;
    }
    if ret == 0 then return 0;
    return 2**(ret - 1);
}

proc task2_parse(line: string) {
    var s = line.split("|");
    var s2 = s[0].split(": ");
    var re = new regex("[[:digit:]]+");
    var x = for m in re.matches(s2[1]) do s2[1](m[0]);
    var digits = new set(string, x);
    var ret:int;
    for m in re.matches(s[1]) {
        if digits.contains(s[1](m[0])) then
            ret += 1;
    }
    return ret;
}

proc task2_reduce(lines) {
    var counts: [0..lines.size-1] int = 1;
    for i in lines.indices {
        var line = lines[i];
        var matching = task2_parse(line);
        for j in i+1..i+matching {
            counts[j] += counts[i];
        }
    }
    return + reduce counts;
}


var lines = stdin.lines(true);
writeln(+ reduce task1(lines));
writeln(task2_reduce(lines));