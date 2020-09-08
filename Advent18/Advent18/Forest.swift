//
//  Forest.swift
//  Advent18
//
//  Created by Dragan Cecavac on 24.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Forest {
    var grid:[[Character]] = []
    var width: Int
    var height: Int

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        height = lines.count
        width = lines[0].count
        for line in lines {
            var row = Array<Character>()
            for element in line {
                row.append(String(element).first!)
            }
            grid.append(row)
        }
    }

    private func elementCount(i: Int, j: Int, type: Character) -> Int {
        if grid[i][j] == type {
            return 1
        } else {
            return 0
        }
    }

    var currentCycle = 0

    private func tick() {
        var newGrid:[[Character]] = []

        for i in 0..<height {
            var row = Array<Character>()
            for j in 0..<width {
                var lumberyards = 0
                var trees = 0
                var empty = 0

                if i > 0 {
                    lumberyards += elementCount(i: i - 1, j: j, type: "#")
                    trees += elementCount(i: i - 1, j: j, type: "|")
                    empty += elementCount(i: i - 1, j: j, type: ".")
                }

                if i < height - 1 {
                    lumberyards += elementCount(i: i + 1, j: j, type: "#")
                    trees += elementCount(i: i + 1, j: j, type: "|")
                    empty += elementCount(i: i + 1, j: j, type: ".")
                }

                if j > 0 {
                    lumberyards += elementCount(i: i, j: j - 1, type: "#")
                    trees += elementCount(i: i, j: j - 1, type: "|")
                    empty += elementCount(i: i, j: j - 1, type: ".")
                }

                if j < width - 1 {
                    lumberyards += elementCount(i: i, j: j + 1, type: "#")
                    trees += elementCount(i: i, j: j + 1, type: "|")
                    empty += elementCount(i: i, j: j + 1, type: ".")
                }

                if i > 0 && j > 0 {
                    lumberyards += elementCount(i: i - 1, j: j - 1, type: "#")
                    trees += elementCount(i: i - 1, j: j - 1, type: "|")
                    empty += elementCount(i: i - 1, j: j - 1, type: ".")
                }

                if i > 0  && j < width - 1{
                    lumberyards += elementCount(i: i - 1, j: j + 1, type: "#")
                    trees += elementCount(i: i - 1, j: j + 1, type: "|")
                    empty += elementCount(i: i - 1, j: j + 1, type: ".")
                }

                if i < height - 1 && j > 0 {
                    lumberyards += elementCount(i: i + 1, j: j - 1, type: "#")
                    trees += elementCount(i: i + 1, j: j - 1, type: "|")
                    empty += elementCount(i: i + 1, j: j - 1, type: ".")
                }

                if i < height - 1 && j < width - 1{
                    lumberyards += elementCount(i: i + 1, j: j + 1, type: "#")
                    trees += elementCount(i: i + 1, j: j + 1, type: "|")
                    empty += elementCount(i: i + 1, j: j + 1, type: ".")
                }

                switch grid[i][j] {
                case "#":
                    if lumberyards >= 1 && trees >= 1 {
                        row.append("#")
                    } else {
                        row.append(".")
                    }
                case "|":
                    if lumberyards >= 3 {
                        row.append("#")
                    } else {
                        row.append("|")
                    }
                case ".":
                    if trees >= 3 {
                        row.append("|")
                    } else {
                        row.append(".")
                    }
                default:
                    print("Unknown grid element: \(grid[i][j])")
                }
            }
            newGrid.append(row)
        }

        grid = newGrid
        currentCycle += 1
    }

    public func run(cycles: Int) {
        for _ in 0..<cycles {
            tick()
        }
    }

    private var description: String {
        var result = ""

        for i in 0..<height {
            for j in 0..<width {
                result += String(grid[i][j])
            }
        }

        return result
    }

    private func show() {
        print()
        for i in 0..<height {
            var row = ""
            for j in 0..<width {
                row += String(grid[i][j])
            }
            print(row)
        }
    }

    public var result: Int {
        var trees = 0
        var lumberyards = 0

        for i in 0..<height {
            for j in 0..<width {
                if grid[i][j] == "#" {
                    lumberyards += 1
                } else if grid[i][j] == "|" {
                    trees += 1
                }
            }
        }

        return trees * lumberyards
    }

    public func heavyRun(cycles: Int) {
        var states:[String:Int] = [:]
        var repeatingScope = 0

        for i in currentCycle..<cycles {
            tick()
            let dsc = description
            if let previousCycle = states[dsc] {
                repeatingScope = i - previousCycle
                break
            } else {
                states[dsc] = i
            }
        }

        if repeatingScope > 0 {
            while repeatingScope + currentCycle < cycles {
                currentCycle += repeatingScope
            }

            for _ in currentCycle..<cycles {
                tick()
            }
        }
    }
}
