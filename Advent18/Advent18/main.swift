//
//  main.swift
//  Advent18
//
//  Created by Dragan Cecavac on 24.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let forest = Forest(Input.Input1)

forest.run(cycles: 10)
let result1 = forest.result
print("Result1: \(result1)")

forest.heavyRun(cycles: 1000000000)
let result2 = forest.result
print("Result2: \(result2)")
