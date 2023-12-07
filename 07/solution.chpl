use IO;
use Sort;

proc parse(line: string) {
    var s = line.split();
    return (s[0], s[1]:int);
}

record Poker {
    proc key(hand) {
        var cards = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"];
        var hand_key: 5*int;
        for i in 0..4
        {
            for j in cards.indices
            {
                if hand[0][i] == cards[j] then
                    hand_key[i] = j;
            }
        }
        for card in cards
        {
            if (hand[0].count(card) == 5) then
                return (1, hand_key);
            if (hand[0].count(card) == 4) then
                return (2, hand_key);
        }
        for card in cards
        {
            if hand[0].count(card) == 3
            {
                for card2 in cards
                {
                    if card == card2 then
                        continue;
                    if (hand[0].count(card2) == 2) then
                        return (3, hand_key);
                }
                return (4, hand_key);
            }
        }
        for card in cards
        {
            if (hand[0].count(card) == 2)
            {
                for card2 in cards
                {
                    if card == card2 then
                        continue;
                    if (hand[0].count(card2) == 2) then
                        return (5, hand_key);
                }
                return (6, hand_key);
            }
        }
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
writeln(ret < 247254076);
// 248222640 too high
// 247324450 too high
// 247254076 too high