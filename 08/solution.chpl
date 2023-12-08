use IO;
use Map;
use List;
use Math;

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

iter map.keys_ending_with(s) {
    for key in this.keys()
    {
        if key[2] == s then
            yield key;
    }
}

proc task2(navigate, network) {
    var step:int;
    var nodes = network.keys_ending_with("A");
    var steps: [0..nodes.size-1] int;
    var zcount: int;
    while zcount != nodes.size
    {
        var i = step % navigate.size;
        step += 1;
        for j in nodes.indices {
            if navigate[i] == "L" then
                nodes[j] = network[nodes[j]][0];
            else
                nodes[j] = network[nodes[j]][1];
            if nodes[j][2] == "Z" && steps[j] == 0
            {
                steps[j] = step;
                zcount += 1;
            }
        }
    }
    var ret = 1;
    for loop in steps {
        ret = ret * loop / gcd(loop, ret);
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
writeln(task2(navigate, network));
