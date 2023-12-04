use IO;
use List;
use Set;
use Regex;

record Card {
    var lhs: set(string);
    var rhs: list(string);
}

proc parse(line: string) {
    var s = line.split("|");
    var s2 = s[0].split(": ");
    var re = new regex("[[:digit:]]+");
    var x = for m in re.matches(s2[1]) do s2[1](m[0]);
    var y = new list (for m in re.matches(s[1]) do s[1](m[0]));
    return new Card(new set(string, x), y);
}

proc count_matching(line: string) {
    var ret:int;
    var card = parse(line);
    for n in card.rhs {
        if card.lhs.contains(n) then
            ret += 1;
    }
    return ret;
}

proc task2(lines) {
    var counts: [0..lines.size-1] int = 1;
    for i in lines.indices {
        var matching = count_matching(lines[i]);
        for j in i+1..i+matching {
            counts[j] += counts[i];
        }
    }
    return + reduce counts;
}


var lines = stdin.lines(true);
writeln(+ reduce 2**(count_matching(lines) - 1));
writeln(task2(lines));