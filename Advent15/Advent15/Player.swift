//
//  Player.swift
//  Advent15
//
//  Created by Dragan Cecavac on 18.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Player : Hashable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    private static var IDGenerator = 0
    let id: Int

    var hp = 200
    var ap = 3

    var game: Game
    var i: Int
    var j: Int

    init(game: Game, i: Int, j: Int, extraAP: Int) {
        self.game = game
        self.i = i
        self.j = j

        id = Player.IDGenerator
        Player.IDGenerator += 1

        ap += extraAP
    }

    var sequencingNumber: Int {
        return i * 1000 + j
    }

    var isAlive: Bool {
        return hp > 0
    }

    private func getEnemies() -> Set<Player> {
        if game.elfs.contains(self) {
            return game.goblins
        } else {
            return game.elfs
        }
    }

    private func enemiesInReach() -> [Player] {
        let enemies = getEnemies()
        var reachable = Array<Player>()
        for enemy in enemies {
            if !enemy.isAlive {
                continue
            }

            if  (i + 1 == enemy.i && j == enemy.j) ||
                (i - 1 == enemy.i && j == enemy.j) ||
                (i == enemy.i && j + 1 == enemy.j) ||
                (i == enemy.i && j - 1 == enemy.j) {
                reachable.append(enemy)
            }
        }

        return reachable
    }

    enum Direction {
        case Up
        case Down
        case Left
        case Right
        case None
    }

    private func move() {
        let enemies = getEnemies()
        var bestDistance = Int.max
        var direction = Direction.None

        if game.field[i - 1][j] == "." {
            let maze = Maze(fields: game.field, startI: i - 1, startJ: j)
            let distance = maze.getDistance(enemies: enemies)
            if distance < bestDistance {
                bestDistance = distance
                direction = .Up
            }
        }

        if game.field[i][j - 1] == "." {
            let maze = Maze(fields: game.field, startI: i, startJ: j - 1)
            let distance = maze.getDistance(enemies: enemies)
            if distance < bestDistance {
                bestDistance = distance
                direction = .Left
            }
        }

        if game.field[i][j + 1] == "." {
            let maze = Maze(fields: game.field, startI: i, startJ: j + 1)
            let distance = maze.getDistance(enemies: enemies)
            if distance < bestDistance {
                bestDistance = distance
                direction = .Right
            }
        }

        if game.field[i + 1][j] == "." {
            let maze = Maze(fields: game.field, startI: i + 1, startJ: j)
            let distance = maze.getDistance(enemies: enemies)
            if distance < bestDistance {
                bestDistance = distance
                direction = .Down
            }
        }

        switch direction {
        case .Up:
            i -= 1
        case .Down:
            i += 1
        case .Left:
            j -= 1
        case .Right:
            j += 1
        default:
            break
        }
    }

    private func bestTarget(reachableEnemies: [Player]) -> Player {
        var minHp = Int.max
        var bestSequence = Int.max
        var target: Player?
        for enemy in reachableEnemies {
            if enemy.hp < minHp {
                minHp = enemy.hp
                bestSequence = enemy.sequencingNumber
                target = enemy
            } else if enemy.hp == minHp {
                if enemy.sequencingNumber < bestSequence {
                    bestSequence = enemy.sequencingNumber
                    target = enemy
                }
            }
        }

        return target!
    }

    private func attack(reachableEnemies: [Player]) {
        let target = bestTarget(reachableEnemies: reachableEnemies)
        target.hp -= ap
    }

    private func getLiveEnemies() -> [Player] {
        let enemies = getEnemies()

        var liveEnemies: [Player] = []
        for enemy in enemies {
            if enemy.isAlive {
                liveEnemies.append(enemy)
            }
        }

        return liveEnemies
    }

    public func action() -> Bool {
        var reachable = enemiesInReach()
        if getLiveEnemies().count == 0 {
            return true
        }

        if reachable.count > 0 {
            attack(reachableEnemies: reachable)
        } else {
            move()
            reachable = enemiesInReach()
            if reachable.count > 0 {
                attack(reachableEnemies: reachable)
            }
        }

        return false
    }
}
