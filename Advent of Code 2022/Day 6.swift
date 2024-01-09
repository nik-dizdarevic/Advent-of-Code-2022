//
//  Day 6.swift
//  Advent of Code 2022
//
//  Created by Nik Dizdarević on 06/12/2022.
//

import Foundation

// MARK: - part1

func processedChars(_ input: [Character]) -> Int {
    (0..<input.count - 3).reduce(into: 0) { partialResult, i in
        if partialResult == 0, Set(input[i...i+3]).count == 4 {
            partialResult += i + 4
        }
    }
}

// MARK: - part2

func processedCharsPartTwo(_ input: [Character]) -> Int {
    (0..<input.count - 13).reduce(into: 0) { partialResult, i in
        if partialResult == 0, Set(input[i...i+13]).count == 14 {
            partialResult += i + 14
        }
    }
}
