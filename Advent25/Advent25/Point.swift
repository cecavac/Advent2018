//
//  Point.swift
//  Advent25
//
//  Created by Dragan Cecavac on 08.09.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

struct Point {
    let x: Int
    let y: Int
    let z: Int
    let l: Int

    public func distance(point: Point) -> Int {
        var distance = 0

        distance += abs(x - point.x)
        distance += abs(y - point.y)
        distance += abs(z - point.z)
        distance += abs(l - point.l)

        return distance
    }
}
