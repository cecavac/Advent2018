//
//  Waterfall.swift
//  Advent17
//
//  Created by Dragan Cecavac on 21.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Waterfall {
    var minJ = 500
    var maxJ = 500
    var minI = 0
    var maxI = 0
    var minInputI = Int.max

    var positionI = 0
    var positionJ = 500

    var map:[Int:Character] = [:]
    var pointsOfInterest = Set<Int>()

    private func hash(i: Int, j: Int) -> Int {
        return i * 1000000 + j
    }

    private func getElement(i: Int, j: Int) -> Character {
        let hashVal = hash(i: i, j: j)
        if let result = map[hashVal] {
            return result
        } else {
            return "."
        }
    }

    private func setElement(i: Int, j: Int, value: Character) {
        let hashVal = hash(i: i, j: j)
        map[hashVal] = value

        for k in i - 1...i + 1 {
            for l in j - 1...j + 1 {
                let hashVal = hash(i: k, j: l)
                pointsOfInterest.insert(hashVal)
            }
        }
    }

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            var cleanLine = ""
            for char in line {
                if char != "," && char != "=" && char != "." {
                    cleanLine += String(char)
                } else {
                    cleanLine += " "
                }
            }

            let elements = cleanLine.split(separator: " ")
            let val1 = Int(String(elements[1]))!
            let val2 = Int(String(elements[3]))!
            let val3 = Int(String(elements[4]))!

            let first = String(elements[0])
            if first == "x" {
                let j = val1
                let i1 = val2
                let i2 = val3

                for i in i1...i2 {
                    setElement(i: i, j: j, value: "#")
                }

                minI = min(minI, i1)
                maxI = max(maxI, i2)
                minJ = min(minJ, j)
                maxJ = max(maxJ, j)

                minInputI = min(minInputI, i1)
            } else if first == "y" {
                let i = val1
                let j1 = val2
                let j2 = val3

                for j in j1...j2 {
                    setElement(i: i, j: j, value: "#")
                }

                minI = min(minI, i)
                maxI = max(maxI, i)
                minJ = min(minJ, j1)
                maxJ = max(maxJ, j2)

                minInputI = min(minInputI, i)
            } else {
              print("Unknown element: \(first)")
            }
        }

        minJ -= 1
        maxJ += 1

        setElement(i: 0, j: 500, value: "+")
        setElement(i: 1, j: 500, value: "|")
    }

    public func show() {
        for i in minI...maxI {
            var row = ""
            for j in minJ...maxJ {
                row += String(getElement(i: i, j: j))
            }
            print(row)
        }
    }

    public func realShow() {
        for i in minI...maxI {
            var row = ""
            var hasWater = false

            for j in minJ...maxJ {
                row += String(getElement(i: i, j: j))

                if getElement(i: i, j: j) == "|" || getElement(i: i, j: j) == "~" {
                    hasWater = true
                }
            }
            if hasWater {
                print(row)
            }
        }
    }

    private func flowDown() {
        positionI += 1

        while (getElement(i: positionI, j: positionJ) == "." || getElement(i: positionI, j: positionJ) == "|") && positionI <= maxI {
            setElement(i: positionI, j: positionJ, value: "|")
            positionI += 1

            if getElement(i: positionI, j: positionJ) == "|" {
                return
            }
        }

        if positionI == maxI + 1 {
            return
        }

        var localI = positionI
        var localJ = positionJ

        var flowSideways = true
        while flowSideways {
            positionI -= 1
            if positionI < minI {
                return
            }

            localI = positionI
            localJ = positionJ

            let wallLeft = flowLeft()
            positionI = localI
            positionJ = localJ
            let wallRight = flowRight()
            positionI = localI
            positionJ = localJ
            flowSideways = wallLeft && wallRight
        }

        overflow()
    }

    private func overflow() {
        for j in positionJ...maxJ {
            if getElement(i: positionI, j: j) == "~" ||  getElement(i: positionI, j: j) == "|" {
                setElement(i: positionI, j: j, value: "|")
            } else if getElement(i: positionI, j: j) == "." && getElement(i: positionI, j: j - 1) == "|" && getElement(i: positionI + 1, j: j - 1) == "#" {
                setElement(i: positionI, j: j, value: "|")
                break
            } else {
                break
            }
        }

        for j in (minJ...positionJ).reversed() {
            if getElement(i: positionI, j: j) == "~" ||  getElement(i: positionI, j: j) == "|" {
                setElement(i: positionI, j: j, value: "|")
            } else if getElement(i: positionI, j: j) == "." && getElement(i: positionI, j: j + 1) == "|" && getElement(i: positionI + 1, j: j + 1) == "#" {
               setElement(i: positionI, j: j, value: "|")
                break
            } else {
                break
            }
        }

        //flowDown()
    }

    private func flowLeft() -> Bool {
        let localPositionJ = positionJ

        while (getElement(i: positionI, j: positionJ) == "." || getElement(i: positionI, j: positionJ) == "|" || getElement(i: positionI, j: positionJ) == "~") &&
        (getElement(i: positionI + 1, j: positionJ) == "#" || getElement(i: positionI + 1, j: positionJ) == "~" )  {
            setElement(i: positionI, j: positionJ, value: "~")
            positionJ -= 1
        }

        let wallHit = getElement(i: positionI, j: positionJ) == "#"
        positionJ = localPositionJ

        if !wallHit {
            setElement(i: positionI, j: positionJ, value: "|")
        }

        positionJ = localPositionJ

        return wallHit
    }

    private func flowRight() -> Bool {
        let localPositionJ = positionJ

        while (getElement(i: positionI, j: positionJ) == "." || getElement(i: positionI, j: positionJ) == "|" || getElement(i: positionI, j: positionJ) == "~") &&
            (getElement(i: positionI + 1, j: positionJ) == "#" || getElement(i: positionI + 1, j: positionJ) == "~" ) {
            setElement(i: positionI, j: positionJ, value: "~")
            positionJ += 1
        }

        let wallHit =  getElement(i: positionI, j: positionJ) == "#"
        positionJ = localPositionJ

        if !wallHit {
            setElement(i: positionI, j: positionJ, value: "|")
        }

        positionJ = localPositionJ

        return wallHit
    }

    public func flowSemiRecursive() {
        while true {
            var changed = false

            for i in minI...maxI {
                for j in minJ...maxJ {
                    if getElement(i: i, j: j) == "|" && getElement(i: i + 1, j: j) == "." {
                        if i == maxI {
                            continue
                        }

                        changed = true
                        positionI = i
                        positionJ = j
                        flowDown()
                    }
                }
            }

            if !changed {
                break
            }
        }
    }

    public var waterCount: (Int, Int) {
        var result1 = 0
        var result2 = 0

        for i in minInputI...maxI {
            for j in minJ...maxJ {
                if getElement(i: i, j: j) == "~" {
                    result1 += 1
                    result2 += 1
                } else if getElement(i: i, j: j) == "|" {
                    result1 += 1
                }
            }
        }

        return (result1, result2)
    }
}
