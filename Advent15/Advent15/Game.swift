//
//  Game.swift
//  Advent15
//
//  Created by Dragan Cecavac on 18.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Game {
    var emptyField: [[Character]] = []
    var field: [[Character]] = []
    var elfs = Set<Player>()
    var goblins = Set<Player>()
    var round = -1
    var stopIfElfDead: Bool

    init(_ input: String, extraElfAP: Int) {
        let lines = input.split(separator: "\n")
        stopIfElfDead = extraElfAP != 0

        for i in 0..<lines.count {
            var row: [Character] = []
            let elements = Array<Character>(lines[i])

            for j in 0..<elements.count {
                switch elements[j] {
                case "#":
                    row.append("#")
                case ".":
                    row.append(".")
                case "E":
                    let elf = Player(game: self, i: i, j: j, extraAP: extraElfAP)
                    elfs.insert(elf)
                    row.append(".")
                case "G":
                    let goblin = Player(game: self, i: i, j: j, extraAP: 0)
                    goblins.insert(goblin)
                    row.append(".")
                default:
                    print("Unknown field element: \(elements[j])")
                }
            }

            emptyField.append(row)
        }
    }

    private var elfsDead: Bool {
        for elf in elfs {
            if elf.isAlive {
                return false
            }
        }

        return true
    }

    private var goblinsDead: Bool {
        for goblin in goblins {
            if goblin.isAlive {
                return false
            }
        }

        return true
    }

    private var score: Int {
        var result = 0

        if goblinsDead {
            for elf in elfs {
                if elf.isAlive {
                    result += elf.hp
                }
            }
        } else if elfsDead {
            for goblin in goblins {
                if goblin.isAlive {
                    result += goblin.hp
                }
            }
        } else {
            print("Invalid score calculation")
        }

        result *= round

        return result
    }

    private func updateField() {
        field = emptyField

        for elf in elfs {
            if elf.isAlive {
                field[elf.i][elf.j] = "E"
            }
        }

        for goblin in goblins {
            if goblin.isAlive {
                field[goblin.i][goblin.j] = "G"
            }
        }
    }

    private func show() {
        print("==================== Round: \(round)")
        for i in 0..<field.count {
            var row = ""
            for j in 0..<field[i].count {
                row += String(field[i][j])
            }
            print(row)
        }
    }

    private func showHP() {
        var hp = 0
        for player in goblins {
            print("hp: \(player.hp)")
            if player.isAlive {
                hp += player.hp
            }
        }
        for player in elfs {
            print("hp: \(player.hp)")
            if player.isAlive {
                hp += player.hp
            }
        }
        print("total hp: \(hp)")
    }

    public func isAnyElfDead() -> Bool {
        for elf in elfs {
            if !elf.isAlive {
                return true
            }
        }

        return false
    }

    public func play() -> Int {
        updateField()
        //show()

        gameLoop: while true {
            round += 1
            var players: [Player] = []

            for goblin in goblins {
                if goblin.isAlive {
                    players.append(goblin)
                }
            }

            for elf in elfs {
                if elf.isAlive {
                    players.append(elf)
                }
            }

            players.sort { $0.sequencingNumber < $1.sequencingNumber }
            for player in players {
                if player.isAlive {
                    if stopIfElfDead && isAnyElfDead() {
                        break gameLoop
                    }

                    let gameOver = player.action()
                    if gameOver {
                        break gameLoop
                    }
                    updateField()
                    //show()
                }
            }
            print("Round: \(round)")
            //showHP()
        }
        //showHP()
        return score
    }
}
