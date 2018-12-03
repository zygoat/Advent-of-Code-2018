// Advent of Code, Day 1: Frequency calculator.
//
// ben@zygoat.ca

import Foundation

let fileURL = URL(fileURLWithPath: "./freq_deltas.txt")
let deltas = try! String.init(contentsOf: fileURL).split(separator: "\n").map { Int($0)! }

var accumulatedFreqs = Set<Int>()
var currentFreq = 0
var throughOnce = false

repeat {
    for n in deltas {
        accumulatedFreqs.insert(currentFreq)
        currentFreq += n
        if accumulatedFreqs.contains(currentFreq) {
            print("part 2. first dupe freq: \(currentFreq)")  // 82516
            exit(0)
        }
    }
    
    if !throughOnce {
        print("part 1. end freq after first iteration: \(currentFreq)")  // 578
        throughOnce = true
    }
} while true
