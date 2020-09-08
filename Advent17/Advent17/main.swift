//
//  main.swift
//  Advent17
//
//  Created by Dragan Cecavac on 21.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let waterfall = Waterfall(Input.Input1)
waterfall.flowSemiRecursive()
//waterfall.show()
let result = waterfall.waterCount
print("Result1: \(result.0)")
print("Result2: \(result.1)")
