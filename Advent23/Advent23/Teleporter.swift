//
//  Teleporter.swift
//  Advent23
//
//  Created by Dragan Cecavac on 06.09.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Teleporter {
    var bots = Array<Nanobot>()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            var cleanLine = ""

            for char in line {
                if char == "<" || char == ">" || char == "," || char == "=" {
                    cleanLine += " "
                } else {
                    cleanLine += String(char)
                }
            }

            let elements = cleanLine.split(separator: " ")

            let x = Int(String(elements[1]))!
            let y = Int(String(elements[2]))!
            let z = Int(String(elements[3]))!
            let r = Int(String(elements[5]))!
            let point = Point(x: x, y: y, z: z)
            let nanobot = Nanobot(point: point, range: r)

            bots.append(nanobot)
        }
    }

    private func findBestIndex() -> Int {
        var best = 0
        var bestIndex = -1

        for i in 0..<bots.count {
            var count = 0

            for j in 0..<bots.count {
                let distance = bots[i].distance(to: bots[j])
                if distance <= bots[j].range {
                    count += 1
                }
            }

            if count > best {
                best = count
                bestIndex = i
            }
        }

        return bestIndex
    }

    public func findBestDistance() -> Int {
        var bestVal = 0
        var bestCount = 0
        var minDistances = Array<Int>()
        var maxDistances = Array<Int>()
        var edgeVals = Array<Int>()
        var greatestDistance = 0

        for i in 0..<bots.count {
            var distance = 0
            distance += abs(bots[i].point.x)
            distance += abs(bots[i].point.y)
            distance += abs(bots[i].point.z)

            let minDistance = abs(distance - bots[i].range)
            let maxDistance = abs(distance + bots[i].range)

            minDistances.append(minDistance)
            maxDistances.append(maxDistance)

            greatestDistance = max(greatestDistance, maxDistance)
        }

        edgeVals.append(contentsOf: minDistances)
        edgeVals.append(contentsOf: maxDistances)
        edgeVals.sort { $0 < $1 }

        for i in edgeVals {
            var count = 0

            for j in 0..<bots.count {
                if i >= minDistances[j] && i <= maxDistances[j] {
                    count += 1
                }
            }

            if count > bestCount {
                bestCount = count
                bestVal = i
            }
        }

        return bestVal
    }

    public func findLRLSR() -> Int {
        var largestRadius = 0
        var largestRadiusIndex = -1
        var result = 0

        for i in 0..<bots.count {
            if bots[i].range > largestRadius {
                largestRadius = bots[i].range
                largestRadiusIndex = i
            }
        }

        for i in 0..<bots.count {
            let distance = bots[largestRadiusIndex].distance(to: bots[i])
            if distance <= bots[largestRadiusIndex].range {
                result += 1
            }
        }

        return result
    }
}
