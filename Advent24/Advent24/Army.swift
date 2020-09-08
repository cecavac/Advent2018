//
//  Army.swift
//  Advent24
//
//  Created by Dragan Cecavac on 07.09.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Army {
    private static var idCounter = 0
    public static var locked = false

    let id: Int
    var units: Int
    let hp: Int
    let attack: Int
    let initiative: Int
    let damageType: String
    let type: String

    var target: Army? = nil

    var immuneSet = Set<String>()
    var weakSet = Set<String>()

    init(_ input: String, type: String, boost: Int) {
        self.type = type

        var hasSpecialEffects = false
        var cleanInput = ""

        for char in input {
            if char == "," {
                cleanInput += " "
            } else if char == "(" || char == ")" {
                cleanInput += "#"
                hasSpecialEffects = true
            } else {
                cleanInput += String(char)
            }
        }

        if hasSpecialEffects {
            let elements = cleanInput.split(separator: "#")
            let specialEffects = String(elements[1])
            let effectElements = specialEffects.split(separator: ";")
            for effectElement in effectElements {
                let localElements = effectElement.split(separator: " ")
                for i in 2..<localElements.count {
                    if localElements[0] == "weak" {
                        weakSet.insert(String(localElements[i]))
                    } else if localElements[0] == "immune" {
                        immuneSet.insert(String(localElements[i]))
                    } else {
                        print("Unknown effect type \(localElements[0])")
                    }
                }
            }

            cleanInput = "\(elements[0]) \(elements[2])"
        }

        id = Army.idCounter
        Army.idCounter += 1

        let elements = cleanInput.split(separator: " ")

        units = Int(String(elements[0]))!
        hp = Int(String(elements[4]))!
        if type == "A" {
            attack = Int(String(elements[12]))!
        } else {
            attack = Int(String(elements[12]))! + boost
        }
        damageType = String(elements[13])
        initiative = Int(String(elements[17]))!
    }

    public var effectivePower: Int {
        return units * attack
    }

    struct TargetMetrics {
        let attackScore: Int
        let effectivePower: Int
        let initiative: Int
        let index: Int
    }

    private func potentialDamage(to army: Army) -> Int {
        if army.immuneSet.contains(damageType) {
            return 0
        }

        var damage = effectivePower
        if army.weakSet.contains(damageType) {
            damage *= 2
        }

        return damage
    }

    public func targetSelect(immunities: [Army], infections: [Army], selected: Set<Int>) -> Int {
        var enemies: [Army] = []
        var metrics: [TargetMetrics] = []
        Army.locked = true

        if type == "A" {
            enemies = immunities
        } else if type == "D" {
            enemies = infections
        } else {
            print("Error type: \(type)")
        }

        for i in 0..<enemies.count {
            let enemy = enemies[i]

            if selected.contains(enemy.id) {
                let metric = TargetMetrics(attackScore: 0, effectivePower: 0, initiative: 0, index: -1)
                metrics.append(metric)
            } else {
                let damage = potentialDamage(to: enemy)
                let metric = TargetMetrics(attackScore: damage, effectivePower: enemy.effectivePower, initiative: enemy.initiative, index: i)
                metrics.append(metric)
            }
        }

        metrics.sort { $0.initiative > $1.initiative }
        metrics.sort { $0.effectivePower > $1.effectivePower }
        metrics.sort { $0.attackScore > $1.attackScore }

        if metrics.first!.attackScore > 0 {
            target = enemies[metrics.first!.index]
            return enemies[metrics.first!.index].id
        } else {
            return -1
        }
    }

    public func fight() {
        if units <= 0 || target == nil {
            return
        }

        let damage = potentialDamage(to: target!)
        let killed = damage / target!.hp

        target!.units -= killed
        target = nil

        if killed > 0 {
            Army.locked = false
        }
    }
}
