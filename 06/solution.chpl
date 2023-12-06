use IO;
use Regex;

iter numbers(line) {
    var re = new regex("[[:digit:]]+");
    for m in re.matches(line)
    {
        yield line(m[0]);
    }
}

proc part1(time, distance) {
    var ret:int;
    for i in 0..time
    {
        if (time - i) * i > distance then
            ret += 1;
    }
    return ret;
}

var time = numbers(stdin.readLine());
var distance = numbers(stdin.readLine());

writeln(* reduce for (t,d) in zip(time, distance) do part1(t:int, d:int));

serial {
var t = (+ reduce time):int;
var d = (+ reduce distance):int;
writeln(part1(t, d));
}
