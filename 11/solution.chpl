use IO;
use Set;

iter read_input() {
    for (line, i) in zip(stdin.lines(true), 0..)
    {
        for j in line.indices
        {
            if line[j] == '#' then
                yield (i, j);
        }
    }
}

iter expand(data) {
    var rows: set(int);
    var cols: set(int);
    var bounds: 2*int;
    for (i,j) in data
    {
        rows.add(i);
        cols.add(j);
        bounds = (max(bounds[0], i), max(bounds[1], j));
    }

    var emptyrows: set(int);
    var emptycols: set(int);
    for i in 0..bounds[0]
    {
        if !rows.contains(i) then
            emptyrows.add(i);
    }
    for i in 0..bounds[1]
    {
        if !cols.contains(i) then
            emptycols.add(i);
    }


    for (i,j) in data
    {
        const di = + reduce (for k in 0..i-1 do if emptyrows.contains(k) then 1 else 0);
        const dj = + reduce (for k in 0..j-1 do if emptycols.contains(k) then 1 else 0);
        yield (i+di, j+dj);
    }
}

iter task1(data) {
    for i in 0..data.size-2
    {
        const p1 = data[i];
        for j in i+1..data.size-1
        {
            const dp = data[j] - p1;
            yield abs(dp[0]) + abs(dp[1]);
        }
    }
}

var data0 = read_input();
var data = expand(data0);
writeln(+ reduce task1(data));