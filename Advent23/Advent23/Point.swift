//
//  Point.swift
//  Advent23
//
//  Created by Dragan Cecavac on 06.09.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

struct Point {
    var x: Int
    var y: Int
    var z: Int

    public func distance(to point: Point) -> Int {
        var result = 0

        result += abs(x - point.x)
        result += abs(y - point.y)
        result += abs(z - point.z)

        return result
    }
}
