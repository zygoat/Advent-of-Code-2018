// Advent of Code, Day 3: Fabric claims.
//
// ben@zygoat.ca

import Foundation

let fileURL = URL(fileURLWithPath: "./claims.txt")
let manifest = try! String.init(contentsOf: fileURL).split(separator: "\n")

struct Claim {
    let number: Int
    let x: Int
    let y: Int
    let w: Int
    let h: Int

    init(from substring: Substring) {
        let scanner = Scanner(string: String(substring))
        scanner.charactersToBeSkipped = CharacterSet.decimalDigits.inverted
        var n: Int = 0 ; scanner.scanInt(&n) ; self.number = n
        var x: Int = 0 ; scanner.scanInt(&x) ; self.x = x
        var y: Int = 0 ; scanner.scanInt(&y) ; self.y = y
        var w: Int = 0 ; scanner.scanInt(&w) ; self.w = w
        var h: Int = 0 ; scanner.scanInt(&h) ; self.h = h
    }
}

var distinctClaimNumbers = Set<Int>()
var occupations = [Int : [Int : [Claim]]]()   // [y : [x : [claim]]]
var overlapCount = 0

for entry in manifest {
    let claim = Claim(from: entry)
    distinctClaimNumbers.insert(claim.number)
    
    for y in (claim.y ..< claim.y + claim.h) {
        var row = occupations[y] ?? [Int : [Claim]]()
        
        for x in (claim.x ..< claim.x + claim.w) {
            var position = row[x] ?? [Claim]()
            position.append(claim)
            if position.count > 1 {
                if position.count == 2 {
                    overlapCount += 1
                }
                for claim in position {
                    distinctClaimNumbers.remove(claim.number)
                }
            }
            row[x] = position
            occupations[y] = row
        }
    }
}

print("Part 1. Total square inches under multiple claims: \(overlapCount)")  // 107043
print("Part 2. Claim numbers that have no overlaps: \(distinctClaimNumbers)")  // 346
