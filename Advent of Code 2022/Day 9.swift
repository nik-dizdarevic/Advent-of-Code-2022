//
//  Day 9.swift
//  Advent of Code 2022
//
//  Created by Nik Dizdarević on 09/12/2022.
//

import Foundation

// MARK: - part1

struct Point: Hashable, CustomStringConvertible, Equatable {
    var x: Int
    var y: Int
    
    var description: String {
        ("(\(x), \(y))")
    }
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

func positionsVisited(_ input: [String]) -> Int {
    
    var head = Point(0, 0)
    var tail = Point(0, 0)
    var tails: [Point] = []
        
    for line in input {
        let instruction = line.split(separator: " ")
        let direction = instruction[0]
        let amount = Int(instruction[1]) ?? -1
        
        switch direction {
        case "R":
            for _ in 0..<amount {
                head.x += 1
                tail = setTail(tail: tail, head: head)
                tails.append(tail)
            }
        case "L":
            for _ in 0..<amount {
                head.x -= 1
                tail = setTail(tail: tail, head: head)
                tails.append(tail)
            }
        case "U":
            for _ in 0..<amount {
                head.y += 1
                tail = setTail(tail: tail, head: head)
                tails.append(tail)
            }
        case "D":
            for _ in 0..<amount {
                head.y -= 1
                tail = setTail(tail: tail, head: head)
                tails.append(tail)
            }
        default:
            break
        }
    }
    return Set(tails).count
}

func setTail(tail: Point, head: Point) -> Point {
    
    let moveUp = [Point(head.x, head.y - 2), Point(head.x + 1, head.y - 2), Point(head.x - 1, head.y - 2)]
    let moveLeft = [Point(head.x + 2, head.y), Point(head.x + 2, head.y - 1), Point(head.x + 2, head.y + 1)]
    let moveRight = [Point(head.x - 2, head.y), Point(head.x - 2, head.y - 1), Point(head.x - 2, head.y + 1)]
    let moveDown = [Point(head.x, head.y + 2), Point(head.x + 1, head.y + 2), Point(head.x - 1, head.y + 2)]
    
    let moveUpLeft = [Point(head.x - 2, head.y - 2)]
    let moveUpRight = [Point(head.x + 2, head.y - 2)]
    let moveDownLeft = [Point(head.x - 2, head.y + 2)]
    let moveDownRight = [Point(head.x + 2, head.y + 2)]
    
    if moveUp.contains(where: { $0 == tail }) {
        return Point(head.x, head.y - 1)
    } else if moveLeft.contains(where: { $0 == tail }) {
        return Point(head.x + 1, head.y)
    } else if moveRight.contains(where: { $0 == tail }) {
        return Point(head.x - 1, head.y)
    } else if moveDown.contains(where: { $0 == tail }) {
        return Point(head.x, head.y + 1)
    }
    
    if moveUpLeft.contains(where: { $0 == tail }) {
        return Point(head.x - 1, head.y - 1)
    } else if moveUpRight.contains(where: { $0 == tail }) {
        return Point(head.x + 1, head.y - 1)
    } else if moveDownLeft.contains(where: { $0 == tail }) {
        return Point(head.x - 1, head.y + 1)
    } else if moveDownRight.contains(where: { $0 == tail }) {
        return Point(head.x + 1, head.y + 1)
    }
    
    return tail
}

// MARK: - part2

func positionsVisitedPartTwo(_ input: [String]) -> Int {
    
    var rope: [Point] = Array(repeating: Point(0, 0), count: 10)
    var tails: [Point] = []
        
    for line in input {
        let instruction = line.split(separator: " ")
        let direction = instruction[0]
        let amount = Int(instruction[1]) ?? -1
        
        switch direction {
        case "R":
            for _ in 0..<amount {
                rope[rope.count-1].x += 1
               
                for i in (0..<rope.count - 1) {
                    rope[rope.count-2 - i] = setTail(tail: rope[rope.count-2 - i], head: rope[rope.count-1 - i])
                    if rope.count - 2 - i == 0 {
                        tails.append(rope[rope.count-2 - i])
                    }
                }
            }
        case "L":
            for _ in 0..<amount {
                rope[rope.count-1].x -= 1
                
                for i in (0..<rope.count - 1) {
                    rope[rope.count-2 - i] = setTail(tail: rope[rope.count-2 - i], head: rope[rope.count-1 - i])
                    if rope.count - 2 - i == 0 {
                        tails.append(rope[rope.count-2 - i])
                    }
                }
            }
        case "U":
            for _ in 0..<amount {
                rope[rope.count-1].y += 1

                for i in (0..<rope.count - 1) {
                    rope[rope.count-2 - i] = setTail(tail: rope[rope.count-2 - i], head: rope[rope.count-1 - i])
                    if rope.count - 2 - i == 0 {
                        tails.append(rope[rope.count-2 - i])
                    }
                }
            }
        case "D":
            for _ in 0..<amount {
                rope[rope.count-1].y -= 1

                for i in (0..<rope.count - 1) {
                    rope[rope.count-2 - i] = setTail(tail: rope[rope.count-2 - i], head: rope[rope.count-1 - i])
                    if rope.count - 2 - i == 0 {
                        tails.append(rope[rope.count-2 - i])
                    }
                }
            }
        default:
            break
        }
        
    }
    return Set(tails).count
}
