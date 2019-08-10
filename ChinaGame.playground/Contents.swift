import Cocoa

var Board = [String]()

enum Step {
    case left, right
}

Board = [".........................",
         "......O...O..............",
         "........O................",
         "......O...O..............",
         ".........................",
         "......O..................",
         ".........................",
         "......O..................",
         ".........................",
         "........O................",
         ".........................",
         "......O.O................",
         ".........................",
         "....O.O..................",
         ".........................",
         "......O..................",
         ".........................",
         "........O...O............",
         ".........................",
         "..........O.O............",
         ".........................",
         "............O.O..........",
         ".........................",
         "..........O.O............",
         "...........X............."]

func Solution(for Board : [String]) -> ([Step], Int) {
    var workableBoard = [[Character]]()
    var CurrentPawnLocation = (0, 0)
    for row in Board {
        workableBoard.append(Array(row))
    }
    
    var y = 0
    for row in workableBoard {
        if let x = row.firstIndex(of: "X") {
            CurrentPawnLocation = (x, y)
        }
        y += 1
    }
    
    let Killstreak = [Step]()
    let maxKillCombo = Traverse(through: workableBoard, at: CurrentPawnLocation, killStreak: Killstreak)
    return (maxKillCombo, maxKillCombo.count)
}

func Traverse(through Board : [[Character]], at pawnLocation : (Int, Int), killStreak : [Step]) -> [Step] {
    print("Traverse called at (\(pawnLocation.0), \(pawnLocation.1))")
    var tempLeft = killStreak
    var tempRight = killStreak
    if pawnLocation.0 > 1 && pawnLocation.0 < 22 && pawnLocation.1 > 1 {
        if Board[pawnLocation.1 - 1][pawnLocation.0 - 1] == "O" {
            if KillableEnemy(on: Board, at: (pawnLocation.0 - 1, pawnLocation.1 - 1), for: .left) {
                tempLeft = Traverse(through: Board, at: (pawnLocation.0 - 2, pawnLocation.1 - 2), killStreak:  killStreak + [Step.left])
            }
        }
        if Board[pawnLocation.1 - 1][pawnLocation.0 + 1] == "O" {
            if KillableEnemy(on: Board, at: (pawnLocation.0 + 1, pawnLocation.1 - 1), for: .right) {
                tempRight = Traverse(through: Board, at: (pawnLocation.0 + 2, pawnLocation.1 - 2), killStreak: killStreak + [Step.right])
            }
        }
    }
    
    if (tempLeft.count  > tempRight.count && tempLeft.count > killStreak.count) {
        return tempLeft
    }
    if (tempRight.count  > tempLeft.count && tempRight.count > killStreak.count) {
        return tempRight
    }
    return killStreak
}

func KillableEnemy(on Board : [[Character]], at position : (Int, Int), for traversal : Step) -> Bool {
    if (position.0  > 0 && position.0 < 24 && position.1 > 0) {
        if traversal == .left {
            if Board[position.1 - 1][position.0 - 1] != "O" {
                return true
            }
        }
        if traversal == .right {
            if Board[position.1 - 1][position.0 + 1] != "O" {
                return true
            }
        }
    }
    return false
}
var killStreak = Solution(for: Board)

for kill in killStreak.0 {
    if kill == .left {
        print("Left")
    } else {
        print("Right")
    }
}

print("Total \(killStreak.1) killed.")
