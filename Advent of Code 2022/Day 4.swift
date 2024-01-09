//
//  Day 4.swift
//  Advent of Code 2022
//
//  Created by Nik Dizdarević on 03/12/2022.
//

import Foundation

// MARK: - part1

func fullContains(_ input: [String]) -> Int {
    input.reduce(into: 0) { partialResult, line in
        let ranges = getRanges(line)
        
        if ranges.0.count < ranges.1.count {
            partialResult += Set(ranges.0).subtracting(Set(ranges.1)) == [] ? 1 : 0
        } else {
            partialResult += Set(ranges.1).subtracting(Set(ranges.0)) == [] ? 1 : 0
        }
    }
}

func getRanges(_ line: String) -> (ClosedRange<Int>, ClosedRange<Int>) {
    let split = line.split(separator: ",")
    let first = split[0].split(separator: "-").compactMap({ Int($0) })
    let second = split[1].split(separator: "-").compactMap({ Int($0) })
    return (first[0]...first[1], second[0]...second[1])
}

// MARK: - part2

func overlaps(_ input: [String]) -> Int {
    input.reduce(into: 0) { partialResult, line in
        let ranges = getRanges(line)
        partialResult += Set(ranges.0).intersection(Set(ranges.1)).count > 0 ? 1 : 0
    }
}
