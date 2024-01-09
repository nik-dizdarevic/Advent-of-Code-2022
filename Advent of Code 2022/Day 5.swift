//
//  Day 5.swift
//  Advent of Code 2022
//
//  Created by Nik Dizdarević on 04/12/2022.
//

import Foundation

// MARK: - part1

func topCrates(_ input: [String]) -> String {
    let instructions = input.filter { $0.contains("move") }
    var stacks = buildStacks(input.filter { !$0.contains("move") })
    
    for instruction in instructions {
        let arr = instruction
            .split(separator: " ")
            .compactMap { Int($0) }
        
        for _ in 0..<arr[0] {
            stacks[arr[2] - 1].append(stacks[arr[1] - 1].popLast()!)
        }
    }
    
    return stacks.reduce(into: "") { partialResult, stack in
        partialResult += String(stack[stack.count - 1])
    }
}

func buildStacks(_ input: [String]) -> [[Character]] {
    
    var input = input
    
    let positions = Array(input.popLast() ?? "")
    let stackPositions = positions
        .indices
        .filter { positions[$0].wholeNumberValue != nil }
    
    var stacks: [[Character]] = Array(repeating: [], count: stackPositions.count)
    input.forEach {
        let crates = Array($0)
        let cratePositions = crates
            .indices
            .filter { crates[$0] != "]" && crates[$0] != "[" && crates[$0] != " " }
        
        cratePositions.forEach {
            stacks[stackPositions.firstIndex(of: $0) ?? 0].insert(crates[$0], at: 0)
        }
    }
    
    return stacks
}

// MARK: - part2

func topCratesPartTwo(_ input: [String]) -> String {
    let instructions = input.filter { $0.contains("move") }
    var stacks = buildStacks(input.filter { !$0.contains("move") })
    
    for instruction in instructions {
        let arr = instruction
            .split(separator: " ")
            .compactMap { Int($0) }
        
        stacks[arr[2] - 1] += stacks[arr[1] - 1].suffix(arr[0])
        stacks[arr[1] - 1].removeLast(arr[0])
    }
    
    return stacks.reduce(into: "") { partialResult, stack in
        partialResult += String(stack[stack.count - 1])
    }
}
