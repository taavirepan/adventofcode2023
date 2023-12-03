use IO;
use Regex;
use Sort;

proc check(x)
{
    var y = sorted(x.bytes());
    return y[0] != 46 || y[y.size - 1] != 46;
}

proc has_symbol(lines, i, match) {
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

iter task1(lines) {
    var re = new regex("[[:digit:]]+");
    for i in lines.indices
    {
        var line = lines[i];
        for match in re.matches(line)
        {
            var extended = new regexMatch(true, match[0].byteOffset - 1, match[0].numBytes + 2);
            var s = line(extended);
            if s[0] != '.' || s[s.size - 1] != '.' || has_symbol(lines, i, extended) then
                yield line(match[0]):int;
        }
    }
}

iter find_numbers(lines) {
    var re = new regex("[[:digit:]]+");
    for i in lines.indices
    {
        var line = lines[i];
        for match in re.matches(line)
        {
            yield (i, match[0].byteOffset, match[0].byteOffset + match[0].numBytes, line(match[0]):int);
        }
    }
}

iter find_nbors(numbers, i, j) {
    for (row, start, end, value) in numbers
    {
        if row == i && (end == j || start == j+1) then
            yield value;
        if (row == i - 1 || row == i + 1) && j >= start - 1 && j <= end then
            yield value;
    }
}

iter task2(lines) {
    var numbers = find_numbers(lines);
    for i in lines.indices
    {
        for j in lines[i].indices
        {
            if lines[i][j] != '*' then
                continue;
            var nbors = find_nbors(numbers, i, j);
            if nbors.size == 2 then
                yield * reduce nbors;
        }
    }
}

var lines = for line in stdin.lines(true) do "." + line + ".";
writeln(+ reduce task1(lines));
writeln(+ reduce task2(lines));
