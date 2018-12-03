// Advent of Code, Day 3: Fabric claims.
//
// ben@zygoat.ca

import Foundation

let fileURL = URL(fileURLWithPath: "./claims.txt")
let manifest = try! String.init(contentsOf: fileURL).split(separator: "\n")

func rectFromManifest(_ substring: Substring) -> (x: Int, y: Int, w: Int, h: Int) {
    var n: Int = 0
    var x: Int = 0
    var y: Int = 0
    var w: Int = 0
    var h: Int = 0
    let scanner = Scanner(string: String(substring))
    scanner.charactersToBeSkipped = CharacterSet.decimalDigits.inverted
    scanner.scanInt(&n) // ignore
    scanner.scanInt(&x)
    scanner.scanInt(&y)
    scanner.scanInt(&w)
    scanner.scanInt(&h)
    return (x, y, w, h)
}

var occupations = [Int : [Int : Int]]()   // [y : [x : count]]

for entry in manifest {
    let rect = rectFromManifest(entry)

    for y in (rect.y ..< rect.y + rect.h) {
        var row = occupations[y] ?? [Int : Int]()
        
        for x in (rect.x ..< rect.x + rect.w) {
            row[x, default: 0] += 1
            occupations[y] = row
        }
    }
}

var overlapCount = 0

for (_, row) in occupations {
    for (_, count) in row {
        if count > 1 {
            overlapCount += 1
        }
    }
}

print("Part 1. Total square inches under multiple claims: \(overlapCount)")  // 107043
