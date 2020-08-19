//
//  Maze.swift
//  Advent15
//
//  Created by Dragan Cecavac on 27.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Maze {
    var height: Int
    var width: Int

    var fields: [[Character]]
    var w = Set<Int>()
    var d: [Int:Int] = [:]
    var t: [Int:Int] = [:]

    var startI: Int
    var startJ: Int

    func hash(x: Int, y: Int) -> Int {
        return x * 1000 + y
    }

    init(fields: [[Character]], startI: Int, startJ: Int) {
        self.fields = fields
        self.startI = startI
        self.startJ = startJ

        height = fields.count
        width = fields[0].count

        initWeights()
        dijkstra()
    }

    private func insertWeight(hash1: Int, x: Int, y: Int) {
        let hash2 = hash(x: x, y: y)
        if fields[x][y] == "." {
            let hash3 = hash1 * 1000000 + hash2
            w.insert(hash3)

            // only to simplify the start position inserting
            let hash4 = hash3 * 1000000 + hash1
            w.insert(hash4)
        }
    }

    private func insertWeights(x: Int, y: Int) {
        let i = x
        let j = y
        let hash1 = hash(x: i, y: j)

        if i > 0 {
            insertWeight(hash1: hash1, x: i - 1, y: j)
        }

        if i < height - 1 {
            insertWeight(hash1: hash1, x: i + 1, y: j)
        }

        if j > 0 {
            insertWeight(hash1: hash1, x: i, y: j - 1)
        }

        if j < width - 1 {
            insertWeight(hash1: hash1, x: i, y: j + 1)
        }
    }

    private func initWeights() {
        for i in 0..<height {
            for j in 0..<width {
                if fields[i][j] == "." {
                    insertWeights(x: i, y: j)
                }
            }
        }

        insertWeights(x: startI, y: startJ)
    }

    private func dijkstra() {
        let startHash = hash(x: startI, y: startJ)
        var s = Set<Int>()
        s.insert(startHash)

        d = [:]
        t = [:]

        for i in 0..<fields.count {
            for j in 0..<fields[i].count {
                let key = hash(x: i, y: j)

                if key == startHash {
                    continue
                }

                var distance: Int
                let hash3 = startHash * 1000000 + key

                if w.contains(hash3) {
                    distance = 1
                    t[key] = startHash
                } else {
                    distance = Int.max
                    t[key] = 0
                }

                d[key] = distance
            }
        }

        for i in 0..<fields.count {
            for j in 0..<fields[i].count {
                let key = hash(x: i, y: j)

                if key == startHash {
                    continue
                }

                var minD = Int.max
                var minHash = Int.max

                for (key, value) in d {
                    if !s.contains(key) {
                        if value < minD {
                            minD = value
                            minHash = key
                        }
                    }
                }

                if minD == Int.max {
                    break
                }

                s.insert(minHash)
                for i2 in 0..<fields.count {
                    for j2 in 0..<fields[i2].count {
                        let key2 = hash(x: i2, y: j2)

                        if !s.contains(key2) {
                            var distance = Int.max
                            let hash3 = minHash * 1000000 + key2

                            if w.contains(hash3) {
                                distance = 1

                                if d[minHash]! + distance < d[key2]! {
                                    d[key2] = d[minHash]! + distance
                                    t[key2] = minHash
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    var closestDistance = Int.max
    var bestSequence = -1

    private func inspectPosition(x: Int, y: Int) {
        if x == startI && y == startJ {
            closestDistance = 0
            return
        }

        if fields[x][y] == "." {
            let positionHash = hash(x: x, y: y)
            if d[positionHash]! < closestDistance {
                closestDistance = d[positionHash]!
                bestSequence = x * 1000 + y
            } else if d[positionHash]! == closestDistance {
                if x * 1000 + y < bestSequence {
                    bestSequence = x * 1000 + y
                }
            }
        }
    }

    public func getDistance(enemies: Set<Player>) -> Int {
        for enemy in enemies {
            if enemy.isAlive {
                inspectPosition(x: enemy.i - 1, y: enemy.j)
                inspectPosition(x: enemy.i, y: enemy.j - 1)
                inspectPosition(x: enemy.i, y: enemy.j + 1)
                inspectPosition(x: enemy.i + 1, y: enemy.j)
            }
        }

         return closestDistance
    }
}
