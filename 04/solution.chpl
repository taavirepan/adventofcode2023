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

var lines = stdin.lines(true);
writeln(+ reduce task1(lines));
