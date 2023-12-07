use IO;
use Sort;

proc parse(line: string) {
    var s = line.split();
    return (s[0], s[1]:int);
}

record Poker {
    proc key(hand) {
        var cards = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"];
        // var jokers = hand[0].count("J");
        var hand_key: 5*int;
        for i in 0..4
        {
            hand_key[i] = 12;
            for j in cards.indices
            {
                if hand[0][i] == cards[j] then
                    hand_key[i] = j;
            }
        }
        var counts = sorted(for card in cards do -hand[0].count(card));
        if counts[0] == -5 then
            return (1, hand_key);
        if counts[0] == -4 then
            return (2, hand_key);
        if counts[0] == -3 && counts[1] == -2 then
            return (3, hand_key);
        if counts[0] == -3 then
            return (4, hand_key);
        if counts[0] == -2 && counts[1] == -2 then
            return (5, hand_key);
        if counts[0] == -2 then
            return (6, hand_key);
        return (7, hand_key);
    }
}
var poker: Poker;

var data = sorted(parse(stdin.lines(true)), poker);
var ret: int;
for i in 1..data.size
{
    ret += i * data[data.size-i][1];
}
writeln(ret);
