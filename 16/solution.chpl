use IO;

proc read_map() {
    var ret: [0..1000, 0..1000] uint(8);
    var max_i = 0;
    var max_j = 0;
    for (line, i) in zip(stdin.lines(true), 0..) {
        for (c, j) in zip(line, 0..) {
            assert(c.numBytes == 1);
            ret[i, j] = c.byte(0);
            max_j = j;
        }
        max_i = i;
    }
    return ret[0..max_i, 0..max_j];
}

proc travel(data, ref travelled, i0, j0, di, dj) {
    var i = i0;
    var j = j0;
    var dirs: [-1..1, -1..1] uint(8) = 0;
    dirs[0, 1] = 1;
    dirs[0, -1] = 2;
    dirs[1, 0] = 4;
    dirs[-1, 0] = 8;
    while data.domain.contains((i, j)) {
        if travelled[i, j] & dirs[di, dj] != 0 {
            break;
        }
        travelled[i, j] |= dirs[di, dj];
        if data[i, j] == "\\".byte(0) {
            (di, dj) = (dj, di);
        } else if data[i, j] == "/".byte(0) {
            (di, dj) = (-dj, -di);
        } else if di == 0 && data[i, j] == "|".byte(0) {
            travel(data, travelled, i + 1, j, 1, 0);
            (di, dj) = (-1, 0);
        } else if dj == 0 && data[i, j] == "-".byte(0) {
            travel(data, travelled, i, j + 1, 0, 1);
            (di, dj) = (0, -1);
        }
        i += di;
        j += dj;
    }
}

proc energized(t: uint(8)) {
    if t == 0 {
        return 0;
    } else {
        return 1;
    }
}

var data = read_map();
var travelled: [data.dim(0), data.dim(1)] uint(8) = 0;
travel(data, travelled, 0, 0, 0, 1);
writeln(+ reduce energized(travelled));
// writeln(travelled);
