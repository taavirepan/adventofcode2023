use IO;

proc parse(s: string) {
    return for x in s.split() do x:int;
}

proc task1(line: string) {
    var data = parse(line);
    var diff: [0..data.size,0..data.size] int;
    diff[0,0..data.size-1] = data;
    for i in 1..data.size-1
    {
        var allzero = true;
        for j in 0..data.size-i-1
        {
            diff[i,j] = diff[i-1, j+1] - diff[i-1, j];
            if diff[i,j] != 0 then
                allzero = false;
        }
        if allzero
        {
            // writeln(diff);
            // writeln();
            for k_ in 1..i
            {
                var k = i - k_;
                diff[k,data.size - k] = diff[k, data.size - k - 1] + diff[k+1, data.size - k - 1];
            }
            // writeln(diff);
            // writeln();
            // writeln();
            return diff[0,data.size];
        }
    }
    writeln(diff);
    assert(false);
    return 0;
}

var lines = stdin.lines(true);
// serial do task1(lines);
writeln(+ reduce task1(lines));