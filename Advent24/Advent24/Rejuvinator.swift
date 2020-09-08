//
//  Rejuvinator.swift
//  Advent24
//
//  Created by Dragan Cecavac on 07.09.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Rejuvinator {
    public static func heal(immuneInput: String, infectionInput: String) -> Int {
        var result = 0

        for i in 0..<Int.max {
            let health = Health(immuneInput: Input.Input1, infectionInput: Input.Input2, immuneSystemBoots: i)
            result = health.battle()
            if !Army.locked && health.isHealed {
                break
            }
        }

        return result
    }
}
