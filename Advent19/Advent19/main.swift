//
//  main.swift
//  Advent19
//
//  Created by Dragan Cecavac on 25.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let comupter1 = Computer(Input.Input1, reg0: 0)
let result1 = comupter1.execute()
print("Result1: \(result1)")

let comupter2 = Computer(Input.Input1, reg0: 1)
let result2 = comupter2.wireJump()
print("Result2: \(result2)")
