use IO;
use Regex;

iter numbers(line: string)
{
    var re = new regex("[a-z]");
    var digits = line.replace(re, "");
    yield (digits[0] + digits[digits.size - 1]):int;
}

var data = numbers(stdin.lines(true));
writeln(+ reduce data);