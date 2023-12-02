use IO;
use Regex;

proc part1(line: string)
{
    var re = new regex("[a-z]");
    var digits = line.replace(re, "");
    return (digits[0] + digits[digits.size - 1]):int;
}

proc translate(s: string): int
{
    select s {
        when "one" do return 1;
        when "two" do return 2;
        when "three" do return 3;
        when "four" do return 4;
        when "five" do return 5;
        when "six" do return 6;
        when "seven" do return 7;
        when "eight" do return 8;
        when "nine" do return 9;
        otherwise return s:int;
    }
}

iter string.match_on_all_positions(re:regex(string)): string
{
    for i in this.indices {
        var m = re.match(this[i..]);
        if m then yield this[i..](m);
    }
}

proc part2(line: string)
{
    var re = new regex("one|two|three|four|five|six|seven|eight|nine|[0-9]");
    var digits = translate(line.match_on_all_positions(re));
    return (digits[0]*10 + digits[digits.size - 1]);
}


var lines = stdin.lines(true);
writeln(+ reduce part1(lines));
writeln(+ reduce part2(lines));
