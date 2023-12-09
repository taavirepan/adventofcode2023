use IO;

proc parse(s: string) {
    return for x in s.split() do x:int;
}

proc solve(line: string, n: int) {
    var data = parse(line);
    var diff: [0..data.size,-1..data.size] int;
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
            for k_ in 1..i
            {
                var k = i - k_;
                diff[k,data.size - k] = diff[k, data.size - k - 1] + diff[k+1, data.size - k - 1];
                diff[k,-1] = diff[k, 0] - diff[k+1, -1];
            }
            return diff[0,if n == 1 then data.size else -1];
        }
    }
    assert(false);
    return 0;
}


var lines = stdin.lines(true);
writeln(+ reduce solve(lines, 1));
writeln(+ reduce solve(lines, 2));