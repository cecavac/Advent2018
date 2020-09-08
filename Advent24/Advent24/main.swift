//
//  main.swift
//  Advent24
//
//  Created by Dragan Cecavac on 07.09.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let health = Health(immuneInput: Input.Input1, infectionInput: Input.Input2, immuneSystemBoots: 0)
let result1 = health.battle()
print("Result1: \(result1)")

let result2 = Rejuvinator.heal(immuneInput: Input.Input1, infectionInput: Input.Input2)
print("Result2: \(result2)")
