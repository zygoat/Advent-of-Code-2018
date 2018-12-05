// Advent of Code, Day 5: Reacting a polymer.
//
// ben@zygoat.ca

import Foundation

let fileURL = URL(fileURLWithPath: "./polymer.txt")
let polymer = try! String.init(contentsOf: fileURL).replacingOccurrences(of: "\n", with: "")

let alphabet = UnicodeScalar("a").value ... UnicodeScalar("z").value

func reduce(_ polymer: String) -> Int {
    var reducedPolymer = polymer
    var lastReduction = ""
    
    repeat {
        lastReduction = reducedPolymer
        for n in alphabet {
            let c = UnicodeScalar(n)!
            let lower = String(c)
            let upper = String(c).uppercased()
            for search in [(lower + upper), (upper + lower)] {
                reducedPolymer = reducedPolymer.replacingOccurrences(of: search, with: "")
            }
        }
    } while reducedPolymer != lastReduction
    
    return reducedPolymer.count
}

print("Part 1. The reduced initial polymer is \(reduce(polymer)) units long.")  // 10598

var shortestLength = Int.max

for n in alphabet {
    let search = String(UnicodeScalar(n)!)
    let modifiedPolymer = polymer.replacingOccurrences(of: search, with: "", options: .caseInsensitive)
    let length = reduce(modifiedPolymer)
    
    if length < shortestLength {
        shortestLength = length
    }
}

print("Part 2. The shortest reduced polymer is \(shortestLength) units long.")  // 5312 (removing "j", nearly 50% shorter!
