//
//  Day 11.swift
//  Advent of Code 2022
//
//  Created by Nik Dizdarević on 11/12/2022.
//

import Foundation

// MARK: - part1 and part2

enum Operation {
    case addition(Int?)
    case multiplication(Int?)
}

func level(_ input: [String], part1: Bool) -> Int {

    let input = input
        .split(separator: "")
        .map { Array($0) }

    var items = input.map { $0[1].components(separatedBy: CharacterSet.decimalDigits.inverted).compactMap{ Int($0) } }
    let operations = input.map {
        let num = Int(String($0[2].split(separator: " ").last ?? ""))
        return $0[2].contains("*") ? Operation.multiplication(num) : Operation.addition(num)
    }
    let divisions = input.compactMap({ Int($0[3].split(separator: " ").last ?? "") })
    let indices = input.compactMap {
        (
            Int($0[4].split(separator: " ").last ?? "") ?? -1,
            Int($0[5].split(separator: " ").last ?? "") ?? -1
        )
    }

    var inspections = Array(repeating: 0, count: items.count)
    
    let product = divisions.reduce(1, *)

    for _ in 0..<(part1 ? 20 : 10000) {
        for i in 0..<items.count {
            var toRemove: [Int] = []
            for j in 0..<items[i].count {
                switch operations[i] {
                case .addition(let amount):
                    items[i][j] += amount ?? items[i][j]
                    break
                case .multiplication(let amount):
                    items[i][j] *= amount ?? items[i][j]
                    break
                }
                
                part1 ? (items[i][j] /= 3) : (items[i][j] = items[i][j] % product)

                if items[i][j] % divisions[i] == 0 {
                    items[indices[i].0].append(items[i][j])
                    toRemove.append(j)
                } else {
                    items[indices[i].1].append(items[i][j])
                    toRemove.append(j)
                }

                inspections[i] += 1
            }

            for item in toRemove.reversed() {
                items[i].remove(at: item)
            }
        }
    }
    return inspections.sorted().suffix(2).reduce(1, *)
}
