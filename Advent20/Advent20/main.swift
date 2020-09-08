//
//  main.swift
//  Advent20
//
//  Created by Dragan Cecavac on 27.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let map = Map(Input.Input1)
map.explore()
let result1 = map.longestDistance()
print("Result1: \(result1)")

let result2 = map.longCount
print("Result2: \(result2)")
