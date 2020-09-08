//
//  Computer.swift
//  Advent16
//
//  Created by Dragan Cecavac on 20.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Computer {
    var ip: Int = 0
    var reg: [Int] = []
    var instructions: [String] = []
    var tests: [String] = []
    var operations: [String: (Int, Int, Int) -> Void] = [:]
    var opcodeCandidates: [String: Set<Int>] = [:]
    var result1 = 0

    private func reset() {
        for i in 0..<4 {
            reg[i] = 0
        }
        ip = 0
    }

    init(tests: String, instructions: String) {
        for _ in 0..<4 {
            reg.append(0)
        }

        let testLines = tests.split(separator: "\n")
        for testLine in testLines {
            self.tests.append(String(testLine))
        }

        let instructionLines = instructions.split(separator: "\n")
        for instructionLine in instructionLines {
            self.instructions.append(String(instructionLine))
        }

        operations["addi"] = addi(a:b:c:)
        operations["addr"] = addr(a:b:c:)
        operations["muli"] = muli(a:b:c:)
        operations["mulr"] = mulr(a:b:c:)
        operations["bani"] = bani(a:b:c:)
        operations["banr"] = banr(a:b:c:)
        operations["bori"] = bori(a:b:c:)
        operations["borr"] = borr(a:b:c:)
        operations["seti"] = seti(a:b:c:)
        operations["setr"] = setr(a:b:c:)
        operations["gtir"] = gtir(a:b:c:)
        operations["gtri"] = gtri(a:b:c:)
        operations["gtrr"] = gtrr(a:b:c:)
        operations["eqir"] = eqir(a:b:c:)
        operations["eqei"] = eqri(a:b:c:)
        operations["eqrr"] = eqrr(a:b:c:)

        for (key, _) in operations {
            opcodeCandidates[key] = Set<Int>()
            for i in 0...15 {
                opcodeCandidates[key]!.insert(i)
            }
        }
    }

    private func testOperation(registersBefore: [Int], registersAfter: [Int],
                               operation: (Int, Int, Int) -> Void,
                               a: Int, b: Int, c: Int) -> Bool {
        for i in 0..<4 {
            reg[i] = registersBefore[i]
        }

        operation(a, b, c)

        for i in 0..<4 {
            if reg[i] != registersAfter[i] {
                return false
            }
        }

        return true
    }

    var determindedOpcodes = Set<Int>()
    var determindedOperations = Set<String>()
    var opcodeMap: [Int:(Int, Int, Int) -> Void] = [:]

    private func testOperations(registersBefore: [Int], registersAfter: [Int],
                                opcode: Int,
                                a: Int, b: Int, c: Int, restrictReoccurrence: Bool) {
        var succesfull = 0
        var lastSuccessfulOpcode = ""

        if restrictReoccurrence && determindedOpcodes.contains(opcode) {
            return
        }

        for (key, operation) in operations {
            if restrictReoccurrence && determindedOperations.contains(key) {
                continue
            }

            if opcodeCandidates[key]!.contains(opcode) || !restrictReoccurrence {
                let result = testOperation(registersBefore: registersBefore, registersAfter: registersAfter, operation: operation, a: a, b: b, c: c)
                if result {
                    succesfull += 1
                    lastSuccessfulOpcode = key
                    opcodeMap[opcode] = operation
                } else {
                    opcodeCandidates[key]!.remove(opcode)
                }
            }
        }

        if restrictReoccurrence && succesfull == 1 {
            determindedOpcodes.insert(opcode)
            determindedOperations.insert(lastSuccessfulOpcode)

            opcodeCandidates[lastSuccessfulOpcode]!.removeAll()
            opcodeCandidates[lastSuccessfulOpcode]!.insert(opcode)
        }

        if succesfull >= 3 {
            result1 += 1
        }
    }

    private func runTest(testID: Int, restrictReoccurrence: Bool) {
        var regsBefore = Array<Int>()
        var cleanRegsBeforeInput = ""
        for char in tests[testID * 3] {
            if char != "[" && char != "]" && char != "," {
                cleanRegsBeforeInput += String(char)
            }
        }
        let elements0 = cleanRegsBeforeInput.split(separator: " ")
        for i in 1..<elements0.count {
            regsBefore.append(Int(String(elements0[i]))!)
        }

        let elements1 = tests[testID * 3 + 1].split(separator: " ")

        let opcode = Int(String(elements1[0]))!
        let valA = Int(String(elements1[1]))!
        let valB = Int(String(elements1[2]))!
        let valC = Int(String(elements1[3]))!

        var regsAfter = Array<Int>()
        var cleanRegsAfterInput = ""
        for char in tests[testID * 3 + 2] {
            if char != "[" && char != "]" && char != "," {
                cleanRegsAfterInput += String(char)
            }
        }
        let elements3 = cleanRegsAfterInput.split(separator: " ")
        for i in 1..<elements3.count {
            regsAfter.append(Int(String(elements3[i]))!)
        }

        return testOperations(registersBefore: regsBefore, registersAfter: regsAfter, opcode: opcode, a: valA, b: valB, c: valC, restrictReoccurrence: restrictReoccurrence)
    }

    public func runTests(restrictReoccurrence: Bool) {
        for i in 0..<tests.count / 3 {
            runTest(testID: i, restrictReoccurrence: restrictReoccurrence)
        }
    }

    private func addi(a: Int, b: Int, c: Int) {
        reg[c] = reg[a] + b
    }

    private func addr(a: Int, b: Int, c: Int) {
        reg[c] = reg[a] + reg[b]
    }

    private func muli(a: Int, b: Int, c: Int) {
        reg[c] = reg[a] * b
    }

    private func mulr(a: Int, b: Int, c: Int) {
        reg[c] = reg[a] * reg[b]
    }

    private func bani(a: Int, b: Int, c: Int) {
        reg[c] = reg[a] & b
    }

    private func banr(a: Int, b: Int, c: Int) {
        reg[c] = reg[a] & reg[b]
    }

    private func bori(a: Int, b: Int, c: Int) {
        reg[c] = reg[a] | b
    }

    private func borr(a: Int, b: Int, c: Int) {
        reg[c] = reg[a] | reg[b]
    }

    private func seti(a: Int, b: Int, c: Int) {
        reg[c] = reg[a]
    }

    private func setr(a: Int, b: Int, c: Int) {
        reg[c] = a
    }

    private func gtir(a: Int, b: Int, c: Int) {
        if a > reg[b] {
            reg[c] = 1
        } else {
            reg[c] = 0
        }
    }

    private func gtri(a: Int, b: Int, c: Int) {
        if reg[a] > b {
            reg[c] = 1
        } else {
            reg[c] = 0
        }
    }

    private func gtrr(a: Int, b: Int, c: Int) {
        if reg[a] > reg[b] {
            reg[c] = 1
        } else {
            reg[c] = 0
        }
    }

    private func eqir(a: Int, b: Int, c: Int) {
        if a == reg[b] {
            reg[c] = 1
        } else {
            reg[c] = 0
        }
    }

    private func eqri(a: Int, b: Int, c: Int) {
        if reg[a] == b {
            reg[c] = 1
        } else {
            reg[c] = 0
        }
    }

    private func eqrr(a: Int, b: Int, c: Int) {
        if reg[a] == reg[b] {
            reg[c] = 1
        } else {
            reg[c] = 0
        }
    }

    public func execute() -> Int {
        reset()

        for instruction in instructions {
            let elements = instruction.split(separator: " ")

            let opcode = Int(String(elements[0]))!
            let valA = Int(String(elements[1]))!
            let valB = Int(String(elements[2]))!
            let valC = Int(String(elements[3]))!

            let operation = opcodeMap[opcode]!
            operation(valA, valB, valC)
        }

        return reg[0]
    }
}
