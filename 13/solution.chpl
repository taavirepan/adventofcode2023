use IO;

proc check_horizontal(map, col)
{
    for line in map
    {
        for i in 0..999
        {
            if col - i < 0 || col + 1 + i >= line.size then
                break;
            if line[col-i] != line[col+1+i] then
                return false;
        }
    }
    return true;
}

proc check_vertical(map, row)
{
    for j in 0..map[0].size-1
    {
        for i in 0..999
        {
            if row - i < 0 || row + 1 + i >= map.size then
                break;
            if map[row-i][j] != map[row+1+i][j] then
                return false;
        }
    }
    return true;
}

proc task1(s: string) {
    var map = s.split("\n");
    var row: int;
    var col: int;
    for i in 0..map.size-2
    {
        if (check_vertical(map, i)) then
            row = 1 + i;

    }
    for i in 0..map[0].size-2
    {
        if (check_horizontal(map, i)) then
            col = 1 + i;

    }
    return col + 100 * row;
}

var maps = stdin.readString(1024*32).split("\n\n");
writeln(+ reduce task1(maps)); 
