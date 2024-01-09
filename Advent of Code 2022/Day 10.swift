//
//  Day 10.swift
//  Advent of Code 2022
//
//  Created by Nik Dizdarević on 10/12/2022.
//

import Foundation

// MARK: - part1 and part2

func signalStrengthsSum(_ input: [String]) -> Int {
    var x = 1
    var cycle = 0
    let cycles = [20, 60, 100, 140, 180, 220]
    var sprite = [3, 1, 2]
    var signalStrengths: [Int] = []
    
    for instruction in input {
        let split = instruction.split(separator: " ")
        if split.contains(where: { $0 == "addx" }) {
            for _ in 0..<2 {
                cycle += 1
                
                if sprite.contains(cycle % 40) {
                    print("#", terminator: "")
                } else {
                    print(".", terminator: "")
                }
                if cycles.contains(cycle) {
                    let signalStrength = cycle * x
                    signalStrengths.append(signalStrength)
                }
                if cycle % 40 == 0 {
                    print()
                }
            }
            
            x += Int(split[1]) ?? 0
            sprite = [x, x + 1, x + 2]
        } else {
            cycle += 1
            if sprite.contains(cycle % 40) {
                print("#", terminator: "")
            } else {
                print(".", terminator: "")
            }
            if cycles.contains(cycle) {
                let signalStrength = cycle * x
                signalStrengths.append(signalStrength)
            }
            if cycle % 40 == 0 {
                print()
            }
        }
    }
    
    return signalStrengths.reduce(0, +)
}
