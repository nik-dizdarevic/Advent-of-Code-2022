//
//  Day 8.swift
//  Advent of Code 2022
//
//  Created by Nik Dizdarević on 07/12/2022.
//

import Foundation

// MARK: - part1

func visibleTrees(_ input: [String]) {
    let heights = input.map { Array($0).map({ $0.wholeNumberValue ?? -1 }) }
    
    var visible = 0
    var innerCount = 0
    var scores: [Int] = []
    for i in 1..<heights.count - 1 {
        for j in 1..<heights[i].count - 1 {
            if isVisible(i: i, j: j, heights) {
                visible += 1
            }
            innerCount += 1
            scores.append(scenicScore(i: i, j: j, heights))
        }
    }
    
    print(visible + (heights[0].count * heights.count - innerCount))
    print(scores.max()!)
}

func isVisible(i: Int, j: Int, _ heights: [[Int]]) -> Bool {
    return (i+1..<heights.count).allSatisfy { heights[$0][j] < heights[i][j] } || (0..<i).allSatisfy { heights[$0][j] < heights[i][j] } ||
        (0..<j).allSatisfy { heights[i][$0] < heights[i][j] } || (j+1..<heights[0].count).allSatisfy { heights[i][$0] < heights[i][j] }
}

// MARK: - part2

func scenicScore(i: Int, j: Int, _ heights: [[Int]]) -> Int {
    
    var viewDistances: [Int] = []
    
    if let bigger = (0..<i).reversed().first(where: { heights[$0][j] >= heights[i][j] }) {
        viewDistances.append(i - bigger)
    } else {
        viewDistances.append((0..<i).count)
    }
    
    if let bigger = (0..<j).reversed().first(where: { heights[i][$0] >= heights[i][j] }) {
        viewDistances.append(j - bigger)
    } else {
        viewDistances.append((0..<j).count)
    }

    if let bigger = (i+1..<heights.count).first(where: { heights[$0][j] >= heights[i][j]  }) {
        viewDistances.append(bigger - i)
    } else {
        viewDistances.append((i+1..<heights.count).count)
    }

    if let bigger = (j+1..<heights[0].count).first(where: { heights[i][$0] >= heights[i][j] }) {
        viewDistances.append(bigger - j)
    } else {
        viewDistances.append((j+1..<heights[0].count).count)
    }
    
    return viewDistances.reduce(1, *)
}

