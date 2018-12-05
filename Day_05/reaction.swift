// Advent of Code, Day 5: Reacting a polymer.
//
// ben@zygoat.ca

import Foundation

let fileURL = URL(fileURLWithPath: "./polymer.txt")
let polymer = try! String.init(contentsOf: fileURL).replacingOccurrences(of: "\n", with: "")

var reducedPolymer = polymer
var lastReduction = ""

repeat {
    lastReduction = reducedPolymer
    for n in UnicodeScalar("a").value ... UnicodeScalar("z").value {
        let c = UnicodeScalar(n)!
        let lower = String(c)
        let upper = String(c).uppercased()
        for search in [(lower + upper), (upper + lower)] {
            reducedPolymer = reducedPolymer.replacingOccurrences(of: search, with: "")
        }
    }
} while reducedPolymer != lastReduction

print("Part 1. The reduced polymer is \(reducedPolymer.count) units long.")
