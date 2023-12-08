use IO;
use Map;
use List;

proc task1(navigate, network) {
    var ret:int;
    var node = "AAA";
    while node != "ZZZ"
    {
        var i = ret % navigate.size;
        if navigate[i] == "L" then
            node = network[node][0];
        else
            node = network[node][1];
        ret += 1;
    }
    return ret;
}

var navigate = stdin.readLine().strip();
stdin.readLine();
var network: map(string, 2*string);
for line in stdin.lines(true)
{
    network[line[0..2]] = (line[7..9], line[12..14]);
}

writeln(task1(navigate, network));