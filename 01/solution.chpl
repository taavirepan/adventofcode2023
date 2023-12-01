use IO;
use Regex;
use Map;

iter part1(line: string)
{
    var re = new regex("[a-z]");
    var digits = line.replace(re, "");
    yield (digits[0] + digits[digits.size - 1]):int;
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

iter match_on_all_positions(re:regex(string), line: string): string
{
    for i in line.indices {
        var m = re.match(line[i..]);
        if m then yield line[i..].this(m);
    }
}

iter part2(line: string)
{
    var re = new regex("one|two|three|four|five|six|seven|eight|nine|[0-9]");
    //var digits = for m in re.matches(line) do translate(line.this(m[0]));
    var digits = for m in match_on_all_positions(re, line) do translate(m);
    yield (digits[0]*10 + digits[digits.size - 1]);
    // var re = new regex("[a-z]");
    // var line2 = line.replace("one", "1").replace("two", "2").replace("three", "3").replace("four", "4")
    //     .replace("five", "5").replace("six", "6").replace("seven", "7").replace("eight", "8").replace("nine", "9");
    // var digits = line2.replace(re, "");
    // yield (digits[0] + digits[digits.size - 1]):int;
}


var data = part2(stdin.lines(true));
// writeln(data);
writeln(+ reduce data);
// 54978 too low

// for line in stdin.lines(true)
// {
//     writeln(line);
//     writeln(part2(line));
// }