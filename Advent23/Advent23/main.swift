//
//  main.swift
//  Advent23
//
//  Created by Dragan Cecavac on 06.09.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let teleporter = Teleporter(Input.Input1)

let result1 = teleporter.findLRLSR()
print("Result1: \(result1)")

let result2 = teleporter.findBestDistance()
print("Result2: \(result2)")
