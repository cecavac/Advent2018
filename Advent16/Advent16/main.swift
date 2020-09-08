//
//  main.swift
//  Advent16
//
//  Created by Dragan Cecavac on 20.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let computer = Computer(tests: Input.Input1, instructions: Input.Input2)

computer.runTests(restrictReoccurrence: false)
let result1 = computer.result1
print("Result1: \(result1)")

computer.runTests(restrictReoccurrence: true)
let result2 = computer.execute()
print("Result2: \(result2)")
