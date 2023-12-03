use IO;
use Regex;
use Sort;

proc check(x)
{
    var y = sorted(x.bytes());
    return y[0] != 46 || y[y.size - 1] != 46;
}

proc symbols(lines, i, match) {
    if i > 0
    {
        if check(lines[i-1](match)) then
            return true;
    }
    if i < lines.size - 1
    {
        if check(lines[i+1](match)) then
            return true;
    }
    return false;
}

proc extend(match, line) {
    return new regexMatch(true, match.byteOffset - 1, match.numBytes + 2);
}

iter task1(lines) {
    var re = new regex("[[:digit:]]+");
    for i in lines.indices
    {
        var line = lines[i];
        for match in re.matches(line)
        {
            var extended = extend(match[0], line);
            var s = line(extended);
            if s[0] != '.' || s[s.size - 1] != '.' || symbols(lines, i, extended) then
                yield line(match[0]):int;
        }
    }
}

var lines = for line in stdin.lines(true) do "." + line + ".";
writeln(+ reduce task1(lines));