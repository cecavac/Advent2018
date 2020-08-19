//
//  ElfBuffer.swift
//  Advent15
//
//  Created by Dragan Cecavac on 19.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class ElfBooster {
    let input: String

    init(_ input: String) {
        self.input = input
    }

    private func test(boost: Int) -> Int {
        let game = Game(input, extraElfAP: boost)
        let result = game.play()

        if game.isAnyElfDead() {
            return -1
        } else {
            return result
        }
    }

    public func play() -> Int {
        let startBoost = 10
        var failBoost: Int
        var successBoost: Int

        let result = test(boost: startBoost)
        if result == -1 {
            failBoost = startBoost
            successBoost = startBoost * 2
            while test(boost: successBoost) == -1 {
                successBoost *= 2
            }
        } else {
            successBoost = startBoost
            failBoost = startBoost / 2
            while test(boost: failBoost) == -1 {
                successBoost /= 2
            }
        }

        print("Success: \(successBoost) - Fail: \(failBoost)")

        while failBoost + 1 != successBoost {
            let mid = (successBoost + failBoost) / 2
            let result = test(boost: mid)
            if result == -1 {
                failBoost = mid
            } else {
                successBoost = mid
            }

            print("Success: \(successBoost) - Fail: \(failBoost)")
        }

        return test(boost: successBoost)
    }
}
