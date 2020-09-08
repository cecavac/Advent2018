//
//  main.swift
//  Advent21
//
//  Created by Dragan Cecavac on 29.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let superComputer1 = SuperComputer(findMinThreshold: true)
let result1 = superComputer1.run()
print("Result1: \(result1)")

let superComputer2 = SuperComputer(findMinThreshold: false)
let result2 = superComputer2.run()
print("Result2: \(result2)")
