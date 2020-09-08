//
//  Regex.swift
//  Advent20
//
//  Created by Dragan Cecavac on 27.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Regex {
    var inputArray: [Character]
    var result: [String] = []

    init(_ input: String) {
        inputArray = Array(input)
        inputArray.removeFirst()
        inputArray.removeLast()
    }

    var mcnt = 0

    private func expand(element: String, array: [Character]) {
        var localPosition = 0
        var localElement = element
        var depth = 0

        for i in 0..<array.count {
            localPosition = i + 1

            if array[i] != "(" {
                localElement += String(array[i])
            } else {
                depth += 1
                break
            }
        }

        if depth == 0 {
            result.append(localElement)
        } else {
            var midElementStrings: [String] = []
            var subsectionEnd = -1
            var midElement = ""
            var endElement = ""

            for i in localPosition..<array.count {
                if array[i] == "(" {
                    depth += 1
                } else if array[i] == ")" {
                    depth -= 1
                }

                if array[i] == "|" && depth == 1 {
                    midElementStrings.append(midElement)
                    midElement = ""
                } else if depth > 0 {
                    midElement += String(array[i])
                }

                if depth == 0 {
                    subsectionEnd = i + 1
                    midElementStrings.append(midElement)
                    break
                }
            }

            if subsectionEnd == -1 {
                print("Error: subsection end ')' was not found")
            } else {
                for i in subsectionEnd..<array.count {
                    endElement += String(array[i])
                }

                let containsEmptyMidElement = midElementStrings.last! == ""

                if containsEmptyMidElement {
                    for i in 0..<midElementStrings.count - 1 {
                        let newElement = "\(localElement)\(midElementStrings[i])"
                        expand(element: "", array: Array(newElement))
                    }

                    expand(element: localElement, array: Array(endElement))
                } else {
                    for element in midElementStrings {
                        let newElement = "\(element)\(endElement)"
                        expand(element: localElement, array: Array(newElement))
                    }
                }
            }
        }
    }

    public func expand() {
        expand(element: "", array: inputArray)
    }
}
