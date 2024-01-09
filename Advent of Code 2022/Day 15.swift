//
//  Day 15.swift
//  Advent of Code 2022
//
//  Created by Nik Dizdarević on 15/12/2022.
//

import Foundation

// MARK: - part1

func positionsThatCannotContainBeacon(_ input: [String], row: Int) -> Int {
    var sensors: [Point] = []
    var beacons: [Point] = []

    input
        .map { $0.components(separatedBy: CharacterSet.decimalDigits.union(["-"]).inverted).compactMap { Int($0) } }
        .forEach {
            sensors.append(Point($0[0], $0[1]))
            beacons.append(Point($0[2], $0[3]))
        }
        
    let bsOnY = Set(sensors + beacons)
        .filter{ $0.y == row }
        .count

    return getIntervals(for: row, sensors: sensors, beacons: beacons).reduce(0) { $0 + $1.count } - bsOnY
}

func getIntervals(for row: Int, sensors: [Point], beacons: [Point]) -> [ClosedRange<Int>] {
    var ranges: [ClosedRange<Int>] = []
    for i in sensors.indices {
        let s = sensors[i]
        let b = beacons[i]
        let m = abs(s.x - b.x) + abs(s.y - b.y)

        let diff = abs(row - s.y)
        if diff <= m {
            ranges.append(s.x - m + diff...s.x + m - diff)
        }
    }
    
    let sortedRanges = ranges.sorted(by: { $0.lowerBound < $1.lowerBound })
    
    var intervals: [ClosedRange<Int>] = []
    var currentInterval = sortedRanges[0]
    for i in 0..<sortedRanges.count {
        if currentInterval.overlaps(sortedRanges[i]) {
            currentInterval = min(sortedRanges[i].lowerBound, currentInterval.lowerBound)...max(sortedRanges[i].upperBound, currentInterval.upperBound)
        } else {
            intervals.append(currentInterval)
            currentInterval = sortedRanges[i]
        }
    }
    intervals.append(currentInterval)
    
    return intervals
}

// MARK: - part2 (runs roughly a minute)

func tuningFrequency(_ input: [String], xyMinLimit: Int, xyMaxLimit: Int) -> Int {

    var sensors: [Point] = []
    var beacons: [Point] = []

    input
        .map { $0.components(separatedBy: CharacterSet.decimalDigits.union(["-"]).inverted).compactMap { Int($0) } }
        .forEach {
            sensors.append(Point($0[0], $0[1]))
            beacons.append(Point($0[2], $0[3]))
        }
    
    for y in xyMinLimit...xyMaxLimit {
        let intervals = getIntervals(for: y, sensors: sensors, beacons: beacons)
        if intervals.count == 2 {
            let x = intervals[0].upperBound + (intervals[1].lowerBound - intervals[0].upperBound - 1)
            return x * 4000000 + y
        }
    }
    
    return 0
}
