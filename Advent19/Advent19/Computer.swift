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
    var ipLinked: Int
    var reg: [Int] = []
    var instructions: [String] = []
    var operations: [String: (Int, Int, Int) -> Void] = [:]

    init(_ input: String, reg0: Int) {
        for _ in 0..<6 {
            reg.append(0)
        }

        reg[0] = reg0

        let lines = input.split(separator: "\n")
        let ipElements = lines[0].split(separator: " ")
        ipLinked = Int(String(ipElements[1]))!

        for i in 1..<lines.count {
            instructions.append(String(lines[i]))
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
        reg[c] = a
    }

    private func setr(a: Int, b: Int, c: Int) {
        reg[c] = reg[a]
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

    private func executeCoreInstruction() {
        let elements = instructions[ip].split(separator: " ")

        let opcode = String(elements[0])
        let valA = Int(String(elements[1]))!
        let valB = Int(String(elements[2]))!
        let valC = Int(String(elements[3]))!

        let operation = operations[opcode]!
        operation(valA, valB, valC)
    }

    @discardableResult
    public func execute() -> Int {
        while ip >= 0 && ip < instructions.count {
            reg[ipLinked] = ip

            executeCoreInstruction()

            ip = reg[ipLinked]
            ip += 1
        }

        return reg[0]
    }

    public func wireJump() -> Int {
        instructions.removeLast()
        execute()
        let target = reg[5]
        var result = target

        for i in 1...target / 2 {
            if target % i == 0 {
                result += i
            }
        }

        return result
    }
}
