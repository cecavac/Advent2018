//
//  Cave.swift
//  Advent22
//
//  Created by Dragan Cecavac on 29.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Cave {
    private static let extraElements = 25

    var grid = Array(repeating: Array(repeating: -1, count: Input.targetJ + 1 + Cave.extraElements), count: Input.targetI + 1 + Cave.extraElements)
    var erosion = Array(repeating: Array(repeating: -1, count: Input.targetJ + 1 + Cave.extraElements), count: Input.targetI + 1 + Cave.extraElements)

    init() {
        for i in 0...Input.targetI + Cave.extraElements {
            erosion[i][0] = (i * 16807 + Input.depth) % 20183
        }

        for j in 0...Input.targetJ + Cave.extraElements {
            erosion[0][j] = (j * 48271 + Input.depth) % 20183
        }

        for i in 1...Input.targetI + Cave.extraElements {
            for j in 1...Input.targetJ + Cave.extraElements {
                erosion[i][j] = (erosion[i - 1][j] * erosion[i][j - 1] + Input.depth) % 20183
            }
        }

        erosion[Input.targetI][Input.targetJ] = (0 + Input.depth) % 20183

        for i in 0...Input.targetI + Cave.extraElements {
            for j in 0...Input.targetJ + Cave.extraElements {
                grid[i][j] = erosion[i][j] % 3
            }
        }
    }

    public var riskLevel: Int {
        var result = 0

        for i in 0...Input.targetI {
            for j in 0...Input.targetJ {
                result += grid[i][j]
            }
        }

        return result
    }

    private func hash(i: Int, j: Int) -> Int {
        return i * 1000 + j
    }

    var torchMap: [Int:Int] = [:]
    var gearMap: [Int:Int] = [:]
    var neitherMap: [Int:Int] = [:]

    private func move(i localI: Int, j localJ: Int, time localTime: Int, item localItem: String, terrain  previousTerrain: Int) -> (Int, Int, Int, String) {
        let terrain = grid[localI][localJ]
        var time = 1
        var item = localItem

        switch previousTerrain {
        case 0:
            switch terrain {
            case 0:
                break
            case 1:
                if localItem != "gear" {
                    item = "gear"
                    time += 7
                }
            case 2:
                if localItem != "torch" {
                    item = "torch"
                    time += 7
                }
            default:
                print("Unknown terrain: \(terrain)")
            }
        case 1:
            switch terrain {
            case 0:
                if localItem != "gear" {
                    item = "gear"
                    time += 7
                }
            case 1:
                break
            case 2:
                if localItem != "neither" {
                    item = "neither"
                    time += 7
                }
            default:
                print("Unknown terrain: \(terrain)")
            }
        case 2:
            switch terrain {
            case 0:
                if localItem != "torch" {
                    item = "torch"
                    time += 7
                }
            case 1:
                if localItem != "neither" {
                    item = "neither"
                    time += 7
                }
            case 2:
                break
            default:
                print("Unknown terrain: \(terrain)")
            }
        default:
            print("Unknown previousTerrain: \(previousTerrain)")
        }

        if terrain == 1 && item == "torch" {
            print("whoa")
        }

        return (localI, localJ, localTime + time, item)
    }

    private func explore(i localI: Int, j localJ: Int, time localTime: Int, item localItem: String) {
        // Weed out bad casses
        if localTime >= (localI + localJ + 2) * 8 / 5   {
            return
        }

        let localHash = hash(i: localI, j: localJ)

        switch localItem {
        case "torch":
            if let bestTime = torchMap[localHash] {
                if bestTime <= localTime {
                    return
                } else {
                    torchMap[localHash] = localTime
                }
            } else {
                torchMap[localHash] = localTime
            }

            if let bestTime = gearMap[localHash] {
                if bestTime + 8 <= localTime {
                    return
                }
            }

            if let bestTime = neitherMap[localHash] {
                if bestTime + 8 <= localTime {
                    return
                }
            }
        case "gear":
            if let bestTime = gearMap[localHash] {
                if bestTime <= localTime {
                    return
                } else {
                    gearMap[localHash] = localTime
                }
            } else {
                gearMap[localHash] = localTime
            }

            if let bestTime = torchMap[localHash] {
                if bestTime + 8 <= localTime {
                    return
                }
            }

            if let bestTime = neitherMap[localHash] {
                if bestTime + 8 <= localTime {
                    return
                }
            }
        case "neither":
            if let bestTime = neitherMap[localHash] {
                if bestTime <= localTime {
                    return
                } else {
                    neitherMap[localHash] = localTime
                }
            } else {
                neitherMap[localHash] = localTime
            }

            if let bestTime = gearMap[localHash] {
                if bestTime + 8 <= localTime {
                    return
                }
            }

            if let bestTime = torchMap[localHash] {
                if bestTime + 8 <= localTime {
                    return
                }
            }
        default:
            print("Unknown item: \(localItem)")
            return
        }

        let terrain = grid[localI][localJ]

        switch localItem {
        case "torch":
            if terrain == 1 {
                print("Torch is not allowed on swamp terraint")
            }
        case "gear":
            if terrain == 2 {
                print("Climbing gear is not allowed on narrow terraint")
            }
        case "neither":
            if terrain == 0 {
                print("Neither is not allowed on rocky terraint")
            }
        default:
            print("Unknown item: \(localItem)")
            return
        }

        if localI > 0 {
            let moveResult = move(i: localI - 1, j: localJ, time: localTime, item: localItem, terrain: terrain)
            explore(i: moveResult.0, j: moveResult.1, time: moveResult.2, item: moveResult.3)
        }

        if localJ > 0 {
            let moveResult = move(i: localI, j: localJ - 1, time: localTime, item: localItem, terrain: terrain)
            explore(i: moveResult.0, j: moveResult.1, time: moveResult.2, item: moveResult.3)
        }

        if localI < Input.targetI + Cave.extraElements {
            let moveResult = move(i: localI + 1, j: localJ, time: localTime, item: localItem, terrain: terrain)
            explore(i: moveResult.0, j: moveResult.1, time: moveResult.2, item: moveResult.3)
        }

        if localJ < Input.targetJ + Cave.extraElements {
            let moveResult = move(i: localI, j: localJ + 1, time: localTime, item: localItem, terrain: terrain)
            explore(i: moveResult.0, j: moveResult.1, time: moveResult.2, item: moveResult.3)
        }
    }

    public func explore() -> Int {
        explore(i: 0, j: 0, time: 0, item: "torch")
        return shortestTime()
    }

    private func shortestTime() -> Int {
        let hash1 = hash(i: Input.targetI, j: Input.targetJ)
        var result = Int.max

        if let time = gearMap[hash1] {
            result = min(result, time)
        }

        if let time = torchMap[hash1] {
            result = min(result, time)
        }

        if let time = neitherMap[hash1] {
            result = min(result, time)
        }

        return result
    }
}

