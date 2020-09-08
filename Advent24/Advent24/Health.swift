//
//  Health.swift
//  Advent24
//
//  Created by Dragan Cecavac on 07.09.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Health {
    var immunities = Array<Army>()
    var infections = Array<Army>()
    var armies = Array<Army>()

    init(immuneInput: String, infectionInput: String, immuneSystemBoots: Int) {
        let immuneLines = immuneInput.split(separator: "\n")
        for immuneLine in immuneLines {
            immunities.append(Army(String(immuneLine), type: "D", boost: immuneSystemBoots))
        }

        let infectionLines = infectionInput.split(separator: "\n")
        for infectionLine in infectionLines {
            infections.append(Army(String(infectionLine), type: "A", boost: immuneSystemBoots))
        }

        armies.append(contentsOf: immunities)
        armies.append(contentsOf: infections)
    }

    private var result: Int {
        var result = 0

        for i in 0..<armies.count {
            result += armies[i].units
        }

        return result
    }

    private func cleanOut() {
        for i in (0..<immunities.count).reversed() {
            if immunities[i].units <= 0 {
                immunities.remove(at: i)
            }
        }

        for i in (0..<infections.count).reversed() {
            if infections[i].units <= 0 {
                infections.remove(at: i)
            }
        }

        for i in (0..<armies.count).reversed() {
            if armies[i].units <= 0 {
                armies.remove(at: i)
            }
        }
    }

    private func done() -> Bool {
        cleanOut()

        return infections.count == 0 || immunities.count == 0
    }

    private func selectTargets() {
        var selected = Set<Int>()

        armies.sort { $0.initiative > $1.initiative }
        armies.sort { $0.effectivePower > $1.effectivePower }

        for army in armies {
            let selection = army.targetSelect(immunities: immunities, infections: infections, selected: selected)
            selected.insert(selection)
        }
    }

    private func fight() {
        armies.sort { $0.initiative > $1.initiative }
        for army in armies {
            army.fight()
        }
    }

    public func battle() -> Int {
        while !done() {
            selectTargets()
            fight()

            if Army.locked {
                break
            }
        }

        return result
    }

    public var isHealed: Bool {
        return immunities.count > 0
    }
}
