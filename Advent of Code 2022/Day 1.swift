//
//  Day 1.swift
//  Advent of Code 2022
//
//  Created by Nik Dizdarević on 30/11/2022.
//

import Foundation

// MARK: - part1

func totalCalories(_ input: [String]) -> Int {
    input
        .split(separator: "")
        .map { Array($0.compactMap { Int($0) }) }
        .map { $0.reduce(0, +) }
        .max() ?? -1
}

// MARK: - part2

func totalCaloriesTopThree(_ input: [String]) -> Int {
    input
        .split(separator: "")
        .map { Array($0.compactMap { Int($0) }) }
        .map { $0.reduce(0, +) }
        .sorted()
        .suffix(3)
        .reduce(0, +)
}
