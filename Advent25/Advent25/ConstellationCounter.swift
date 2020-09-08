//
//  ConstellationCounter.swift
//  Advent25
//
//  Created by Dragan Cecavac on 08.09.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class ConstellationCounter {
    var constellations = Array<Array<Point>>()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let elements = line.split(separator: ",")
            let x = Int(String(elements[0]))!
            let y = Int(String(elements[1]))!
            let z = Int(String(elements[2]))!
            let l = Int(String(elements[3]))!

            let newPoint = Point(x: x, y: y, z: z, l: l)
            var newConstellation = true

            constellation_loop: for i in 0..<constellations.count {
                for point in constellations[i] {
                    let distance = point.distance(point: newPoint)
                    if distance <= 3 {
                        constellations[i].append(newPoint)
                        newConstellation = false
                        break constellation_loop
                    }
                }
            }

            if newConstellation {
                var newArray = Array<Point>()
                newArray.append(newPoint)
                constellations.append(newArray)
            }
        }
    }

    public func consolidate() -> Bool {
        let oldCount = constellations.count
        var newConstellations = Array<Array<Point>>()

        for i in 0..<constellations.count {
            for j in 0..<constellations[i].count {
                let newPoint = constellations[i][j]
                var newConstellation = true

                constellation_loop: for i in 0..<newConstellations.count {
                    for point in newConstellations[i] {
                        let distance = point.distance(point: newPoint)
                        if distance <= 3 {
                            newConstellations[i].append(newPoint)
                            newConstellation = false
                            break constellation_loop
                        }
                    }
                }

                if newConstellation {
                    var newArray = Array<Point>()
                    newArray.append(newPoint)
                    newConstellations.append(newArray)
                }
            }
        }

        constellations = newConstellations
        let changed = oldCount != constellations.count
        return changed
    }

    public func result() -> Int {
        var changed = true
        while changed {
            changed = consolidate()
        }

        return constellations.count
    }
}
