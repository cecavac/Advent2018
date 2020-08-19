//
//  main.swift
//  Advent15
//
//  Created by Dragan Cecavac on 18.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let game = Game(Input.Input1, extraElfAP: 0)
let result1 = game.play()
print("Result1: \(result1)")

let elfBooster = ElfBooster(Input.Input1)
let result2 = elfBooster.play()
print("Result2: \(result2)")
