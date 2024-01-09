//
//  Day 7.swift
//  Advent of Code 2022
//
//  Created by Nik Dizdarević on 06/12/2022.
//

import Foundation

// MARK: - part1 and part2

class Node {
    
    var name: String.SubSequence
    var parent: Node?
    var children: [Node]
    var size: Int
    
    init(name: String.SubSequence, parent: Node?, children: [Node], size: Int = 0) {
        self.name = name
        self.parent = parent
        self.children = children
        self.size = size
    }
}

func totalSizesSum(_ input: [String]) {
    
    let node: Node = Node(name: "/", parent: nil, children: [])
    var currentNode = node
    
    for i in 1..<input.count {
        let split = input[i].split(separator: " ")
        if split.contains("cd") {
            if split.contains("..") {
                if let parent = currentNode.parent {
                    currentNode = parent
                }
            } else {
                if let n = currentNode.children.first(where: { $0.name == split.last! }) {
                    currentNode = n
                }
            }
        } else if !split.contains("cd") && !split.contains("ls") {
            if split.contains("dir") {
                currentNode.children.append(Node(name: split.last!, parent: currentNode, children: []))
            } else {
                currentNode.children.append(Node(name: split.last!, parent: currentNode, children: [], size: Int(split.first!)!))
            }
        }
    }
    
    var smallerThan100000: [Int] = []
    var sizes: [Int] = []
    let outermostSize = getDirectorySize((node), smallerThan100000: &smallerThan100000, sizes: &sizes)
    
    // part1
    print(smallerThan100000.reduce(0, +))
    
    // part2
    let unusedSpace = 70000000 - outermostSize
    print(sizes.filter({ unusedSpace + $0 >= 30000000  }).min()!)
    
}

func getDirectorySize(_ node: Node, smallerThan100000: inout [Int], sizes: inout [Int]) -> Int {
    
    var size = 0
    for child in node.children {
        if child.size > 0 {
            size += child.size
        } else {
            size += getDirectorySize(child, smallerThan100000: &smallerThan100000, sizes: &sizes)
        }
    }
    
    if size <= 100000 {
        smallerThan100000.append(size)
    }
    sizes.append(size)
    
    return size
}
