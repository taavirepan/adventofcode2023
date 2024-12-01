use IO;
use Heap;

proc read_input() {
    var data: [1..150,1..150] uint(8);
    var max_i = 0;
    var max_j = 0;
    for (line, i) in zip(stdin.lines(true), 1..) {
        for (val, j) in zip(line.bytes(), 1..) {
            data[i,j] = val - "0".byte(0);
            max_j = j;
        }
        max_i = i;
    }
    return data[1..max_i,1..max_j];
}

record Node {
    var heat_loss: int = 0;
    var straight_steps: int = 0;
    var i: int = 1;
    var j: int = 1;
    var direction: int = 0;

    proc di {
        var ret = [0, 1, 0, -1];
        return ret[direction];
    }
    proc dj {
        var ret = [1, 0, -1, 0];
        return ret[direction];
    }

    proc straight {
        return new Node(heat_loss, straight_steps + 1, i + di, j + dj, direction);
    }

    proc left {
        var ret = new Node(heat_loss, 0, i, j, (direction - 1 + 4) % 4);
        ret.i += ret.di;
        ret.j += ret.dj;
        return ret;
    }

    proc right {
        var ret = new Node(heat_loss, 0, i, j, (direction + 1) % 4);
        ret.i += ret.di;
        ret.j += ret.dj;
        return ret; 
    }
}

proc shortest_path(data, direction, min_steps, max_steps) {
    var visited: [data.dim(0), data.dim(1), 0..3, 0..10] bool = false;
    var nodes = new Heap.heap(Node, comparator=reverseComparator);
    nodes.push(new Node(direction=direction));

    while (nodes.size > 0) {
        var node = nodes.pop();
        if !data.domain.contains(node.i, node.j) || visited[node.i, node.j, node.direction, node.straight_steps] {
            continue;
        }
        visited[node.i, node.j, node.direction, node.straight_steps] = true;
        node.heat_loss += data[node.i, node.j];

        if node.i == data.dim(0).high && node.j == data.dim(1).high && node.straight_steps >= min_steps {
            return node.heat_loss - data[1, 1];
        }

        if (node.straight_steps < max_steps) {
            nodes.push(node.straight);
        }
        if (node.straight_steps >= min_steps) {
            nodes.push(node.left);
            nodes.push(node.right);
        }
    }
    return -1;
}

var data = read_input();
writeln(shortest_path(data, 1, 0, 2));
for direction in 0..3 {
    writeln(shortest_path(data, direction, 3, 9));
}
