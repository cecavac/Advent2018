//
//  SuperComputer.swift
//  Advent21
//
//  Created by Dragan Cecavac on 29.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class SuperComputer {
    var haltOnFirstResult: Bool

    init (findMinThreshold lookForMin: Bool) {
        haltOnFirstResult = lookForMin
    }

    var a = 0
    var b = 0
    var c = 0
    var d = 0
    var e = 0

    var halted = false
    var runSection1 = true

    var lastreg1 = -1
    var reg1Values = Set<Int>()

    private func section1() {
            c = b | 65536
            b = 6663054
    }

    private func section2() {
            e = c & 255
            b += e
            b &= 16777215
            b *= 65899
            b &= 16777215
    }

    private func section3() {
        e = 0

        while true {
            d = e + 1
            d *= 256

            if d > c {
                break
            } else {
                e += 1
            }
        }
    }

    private func section4() {
        c = e
        runSection1 = false
    }

    var result = -1

    private func finalSection() {
        runSection1 = true

        if haltOnFirstResult {
            result = b
            halted = true
        } else {
            if reg1Values.contains(b) {
                halted = true
            } else {
                lastreg1 = b
                reg1Values.insert(b)
            }

            result = lastreg1
        }
    }

    public func run() -> Int {
        while true {
            if runSection1 {
                section1()
            }
            section2()

            if 256 > c {
                finalSection()
            } else {
                section3()
                section4()
            }

            if halted {
                break
            }
        }

        return result
    }
}
