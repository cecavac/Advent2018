//
//  Nanobot.swift
//  Advent23
//
//  Created by Dragan Cecavac on 06.09.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

struct Nanobot {
    var point: Point
    let range: Int

    public func distance(to nanobot: Nanobot) -> Int {
        return point.distance(to: nanobot.point)
    }
}
