//
//  Day 2.swift
//  Advent of Code 2022
//
//  Created by Nik Dizdarević on 01/12/2022.
//

import Foundation

// MARK: - part1

func totalScore(_ input: [String]) -> Int {
    let guide = input.map { $0.split(separator: " ") }
    return score(for: guide)
}

func score(for guide: [[String.SubSequence]]) -> Int {
    var score = 0
    
    for line in guide {
        score += roundResult(h1: line[0], h2: line[1])
        switch line[1] {
        case "X":
            score += 1
        case "Y":
           score += 2
        case "Z":
            score += 3
        default:
            break
        }
    }
    
    return score
}

func roundResult(h1: String.SubSequence, h2: String.SubSequence) -> Int {
    var result = 0
    switch h1 {
    case "A":
        switch h2 {
        case "X":
            result = 3
        case "Y":
            result = 6
        case "Z":
            result = 0
        default:
            break
        }
    case "B":
        switch h2 {
        case "X":
            result = 0
        case "Y":
            result = 3
        case "Z":
            result = 6
        default:
            break
        }
    case "C":
        switch h2 {
        case "X":
            result = 6
        case "Y":
            result = 0
        case "Z":
            result = 3
        default:
            break
        }
    default:
        break
    }
    return result
}

// MARK: - part2

func totalScorePartTwo(_ input: [String]) -> Int {
    var guide = input.map { $0.split(separator: " ") }
    guide = completeGuide(guide)
    return score(for: guide)
}

func completeGuide(_ guide: [[String.SubSequence]]) -> [[String.SubSequence]] {
    var guide = guide
    
    for i in 0..<guide.count {
        switch guide[i][1] {
        case "X":
            switch guide[i][0] {
            case "A":
                guide[i][1] = "Z"
            case "B":
                guide[i][1] = "X"
            case "C":
                guide[i][1] = "Y"
            default:
                break
            }
        case "Y":
            switch guide[i][0] {
            case "A":
                guide[i][1] = "X"
            case "B":
                guide[i][1] = "Y"
            case "C":
                guide[i][1] = "Z"
            default:
                break
            }
        case "Z":
            switch guide[i][0] {
            case "A":
                guide[i][1] = "Y"
            case "B":
                guide[i][1] = "Z"
            case "C":
                guide[i][1] = "X"
            default:
                break
            }
        default:
            break
        }
    }
    
    return guide
}
