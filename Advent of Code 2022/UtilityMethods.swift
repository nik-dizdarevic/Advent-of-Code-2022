//
//  UtilityMethods.swift
//  Advent of Code 2022
//
//  Created by Nik Dizdarević on 01/12/2022.
//

import Foundation

func readFile(emptyLines: Bool = false) -> [String] {
    // TODO: relative
    let filename = "/Users/nik/Documents/Xcode/Advent of Code 2022/Advent of Code 2022/input.txt"
    let contents = try! String(contentsOfFile: filename)
    return contents
        .split(separator: "\n", omittingEmptySubsequences: !emptyLines)
        .compactMap { String($0) }
}
