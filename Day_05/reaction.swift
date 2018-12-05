// Advent of Code, Day 5: Reacting a polymer.
//
// ben@zygoat.ca

import Foundation

let fileURL = URL(fileURLWithPath: "./polymer.txt")
let polymer = try! String.init(contentsOf: fileURL)

// Build a regular expression to do our heavy lifting.

var s = ""
var pairs: [String] = []
for n in UnicodeScalar("a").value ... UnicodeScalar("z").value {
    let c = UnicodeScalar(n)!
    let lower = String(c)
    let upper = String(c).uppercased()
    pairs.append(lower + upper)
    pairs.append(upper + lower)
}
let search = "(" + pairs.joined(separator: "|") + "|\\s+)"

let regex = try! NSRegularExpression(pattern: search, options: [])
let mutablePolymer = NSMutableString(string: polymer)
var matches = 0
repeat {
    matches = regex.replaceMatches(in: mutablePolymer,
                                   options: [],
                                   range: NSRange(location: 0, length: mutablePolymer.length),
                                   withTemplate: "")
} while matches > 0

let reducedPolymer = mutablePolymer as String

print("Part 1. The reduced polymer is \(reducedPolymer.count) units long.")
