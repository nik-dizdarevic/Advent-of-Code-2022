//
//  Day 14.swift
//  Advent of Code 2022
//
//  Created by Nik Dizdarević on 14/12/2022.
//

import Foundation

// MARK: - part1 (Point struct -> day 9)

struct Line {
    var startPoint: Point
    var endPoint: Point
    
    var points: Set<Point> {
        if startPoint.x != endPoint.x {
            let xS = startPoint.x < endPoint.x ? startPoint.x...endPoint.x : endPoint.x...startPoint.x
            return Set(xS.map { Point($0, startPoint.y) })
        } else {
            let yS = startPoint.y < endPoint.y ? startPoint.y...endPoint.y : endPoint.y...startPoint.y
            return Set(yS.map { Point(startPoint.x, $0) })
        }
    }
}

func simulateSand(_ input: [String]){
    
    var rocks: Set<Point> = []
    
    for line in input {
        let points = line
            .split(separator: " -> ")
            .map { $0.split(separator: ",") }
            .map { Point(Int($0[0])!, Int($0[1])!) }
        
        let zip = Array(zip(points, points[1..<points.count]))
        
        for (startPoint, endPoint) in zip {
            rocks.formUnion(Line(startPoint: startPoint, endPoint: endPoint).points)
        }
    }
    
    let maxY = rocks.map { $0.y }.max()!
    let count = pour(start: Point(500, 0), stops: rocks, maxY: maxY)
    let countFloor = pourWithFloor(start: Point(500, 0), stops: rocks, maxY: maxY)
    
    print(count)
    print(countFloor)
}

func availablePoints(point: Point) -> [Point] {
    [Point(point.x, point.y + 1), Point(point.x - 1, point.y + 1), Point(point.x + 1, point.y + 1)]
}

func pour(start: Point, stops: Set<Point>, maxY: Int) -> Int {
    var count = 0
    var start = start
    var stops = stops

    var path = [start]
    while start.y < maxY {
        if let newStart = availablePoints(point: start).first(where: { !stops.contains($0)} ) {
            start = newStart
        } else {
            stops.insert(path.last!)
            count += 1
            start = Point(500, 0)
            path = []
        }
        path.append(start)
    }
    
    return count
}

// MARK: - part2

func pourWithFloor(start: Point, stops: Set<Point>, maxY: Int) -> Int {
    var count = 0
    var start = start
    var stops = stops
    
    stops.formUnion(Line(startPoint: Point(500 - (maxY * 2), maxY + 2), endPoint: Point(500 + (maxY * 2), maxY + 2)).points)

    var path = [start]
    while true {
        if let newStart = availablePoints(point: start).first(where: { !stops.contains($0)} ) {
            start = newStart
        } else {
            if path.last! == Point(500, 0) {
                count += 1
                break
            }
            stops.insert(path.last!)
            count += 1
            start = Point(500, 0)
            path = []
        }
        path.append(start)
    }
    return count
}
