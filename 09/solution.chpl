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
            for k_ in 1..i
            {
                var k = i - k_;
                diff[k,data.size - k] = diff[k, data.size - k - 1] + diff[k+1, data.size - k - 1];
            }
            return diff[0,data.size];
        }
    }
    assert(false);
    return 0;
}

proc task2(line: string) {
    var data = parse(line);
    var diff: [0..data.size,0..data.size] int;
    diff[0,1..data.size] = data;
    for i in 1..data.size-1
    {
        var allzero = true;
        for j in 1..data.size-i
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
                diff[k,0] = diff[k, 1] - diff[k+1, 0];
            }
            return diff[0,0];
        }
    }
    assert(false);
    return 0;
}

var lines = stdin.lines(true);
writeln(+ reduce task1(lines));
writeln(+ reduce task2(lines));