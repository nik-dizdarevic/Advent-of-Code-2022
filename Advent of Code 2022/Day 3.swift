//
//  Day 3.swift
//  Advent of Code 2022
//
//  Created by Nik Dizdarević on 02/12/2022.
//

import Foundation

// MARK: - part1

func prioritiesSum(_ input: [String]) -> Int {
    input.reduce(into: 0) { partialResult, line in
        if let item = Set(Array(line)[0..<line.count/2]).intersection(Set(Array(line)[line.count/2..<line.count])).first, let ascii = item.asciiValue {
            partialResult += Int(ascii - (item.isUppercase ? 38 : 96))
        }
    }
}

// MARK: - part2

func prioritiesSumPartTwo(_ input: [String]) -> Int {
    stride(from: 0, to: input.count - 2, by: 3).reduce(into: 0) { partialResult, i in
        if let item = Set(input[i]).intersection(Set(input[i + 1])).intersection(Set(input[i + 2])).first, let ascii = item.asciiValue {
            partialResult += Int(ascii - (item.isUppercase ? 38 : 96))
        }
    }
}
