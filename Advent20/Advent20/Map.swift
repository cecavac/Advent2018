//
//  Map.swift
//  Advent20
//
//  Created by Dragan Cecavac on 28.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Map {
    let paths: [String]
    var minI, maxI, minJ, maxJ: Int
    var i, j: Int
    var grid: [Int:Character] = [:]
    var longCount = 0
    var distance = 0

    init(_ input: String) {
        let regex = Regex(input)
        regex.expand()
        paths = regex.result

        i = 0
        minI = 0
        maxI = 0
        j = 0
        minJ = 0
        maxJ = 0
    }

    private func hash(i: Int, j: Int) -> Int {
        return i * 1000 + j
    }

    private func getElement(i: Int, j: Int) -> Character {
        if let element = grid[hash(i: i, j: j)] {
            return element
        } else {
            return "#"
        }
    }

    private func setElement(i: Int, j: Int, value: Character) {
        if grid[hash(i: i, j: j)] == nil && value == "." {
            if distance >= 1000 {
                longCount += 1
            }
        }

        grid[hash(i: i, j: j)] = value

        minI = min(minI, i)
        maxI = max(maxI, i)
        minJ = min(minJ, j)
        maxJ = max(maxJ, j)
    }

    private func step(direction: Character) {
        distance += 1

        switch direction {
        case "W":
            j -= 1
            setElement(i: i, j: j, value: "|")
            j -= 1
            setElement(i: i, j: j, value: ".")
        case "E":
            j += 1
            setElement(i: i, j: j, value: "|")
            j += 1
            setElement(i: i, j: j, value: ".")
        case "N":
            i -= 1
            setElement(i: i, j: j, value: "-")
            i -= 1
            setElement(i: i, j: j, value: ".")
        case "S":
            i += 1
            setElement(i: i, j: j, value: "-")
            i += 1
            setElement(i: i, j: j, value: ".")
        default:
            print("Unknown direction: \(direction)")
        }
    }

    public func explore() {
        setElement(i: i, j: j, value: "X")

        for path in paths {
            i = 0
            j = 0
            distance = 0

            for character in path {
                step(direction: character)
            }
        }
    }

    public func show() {
        for i in minI - 1...maxI + 1 {
            var row = ""
            for j in minJ - 1...maxJ + 1 {
                row += String(getElement(i: i, j: j))
            }
            print(row)
        }
    }

    public func longestDistance() -> Int {
            var longest = 0

            for path in paths {
                longest = max(longest, path.count)
            }

            return longest
    }
}
