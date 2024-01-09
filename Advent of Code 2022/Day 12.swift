//
//  Day 12.swift
//  Advent of Code 2022
//
//  Created by Nik Dizdarević on 12/12/2022.
//

import Foundation

// MARK: - part1 and part2 (Point struct -> day 9)

func bfs(graph: [[Character]], root: Point, end: Point) -> Int {
    
    var visited: Set<Point> = [root]
    var queue = [root]
    var parents: [Point:Point] = [:]
    
    while queue.count > 0 {
        var v = queue.removeFirst()

        if v == end {
            var path = [v]
            while parents[v] != nil {
                if let parent = parents[v] {
                    path.append(parent)
                    v = parent
                }
            }
            return path.count - 1
        }
        
        for n in neighbours(of: v, in: graph) {
            if !visited.contains(n) {
                queue.append(n)
                visited.insert(n)
                parents[n] = v
            }
        }
    }
    
    return Int.max
}

func neighbours(of v: Point, in graph: [[Character]]) -> [Point] {
    let neighbours: [Point] = [Point(v.x, v.y + 1), Point(v.x, v.y - 1),
                                    Point(v.x + 1, v.y), Point(v.x - 1, v.y)]

    return neighbours.filter {
        ($0.y >= 0 && $0.y <= graph.count - 1 ) &&
        ($0.x >= 0 && $0.x <= graph[v.y].count - 1 ) &&
        (graph[$0.y][$0.x].asciiValue! == graph[v.y][v.x].asciiValue! + 1 ||
        graph[$0.y][$0.x].asciiValue! <= graph[v.y][v.x].asciiValue!)
    }
}

func fewestSteps(_ input: [String]) {
    
    var heights = input.map({ Array($0) })
    
    var s = Point(-1, -1)
    var e = Point(-1, -1)
    var allA: [Point] = []
    
    for i in 0..<heights.count {
        for j in 0..<heights[i].count {
            if heights[i][j] == "S" {
                s = Point(j, i)
                heights[i][j] = "a"
            } else if heights[i][j] == "E" {
                e = Point(j, i)
                heights[i][j] = "z"
            }
            
            if heights[i][j] == "a" {
                allA.append(Point(j, i))
            }
        }
    }
    
    let count = bfs(graph: heights, root: s, end: e)
    print(count)
    
    print(allA.map { bfs(graph: heights, root: $0, end: e) }.min()!)
}
