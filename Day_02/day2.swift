// Advent of Code, Day 2
//
// ben@zygoat.ca

import Foundation

let fileURL = URL(fileURLWithPath: "./boxes.txt")
let boxes = try! String.init(contentsOf: fileURL).split(separator: "\n")

var totalDistribution = [Int: Int]()

for box in boxes {
    // Tally the internal distribution.
    var composition = [Character: Int]()
    box.forEach { char in
        composition[char, default: 0] += 1
    }
    
    // Note the represented distributions.
    var distribution = Set<Int>()
    for (_, count) in composition where count != 1 {
        distribution.insert(count)
    }
    
    // Accumulate our results.
    for frequency in distribution {
        totalDistribution[frequency, default: 0] += 1
    }
}

// Multiply them all up.
var checksum = 1
for (_, count) in totalDistribution {
    checksum *= count
}

print("Part 1: the distribution is \(totalDistribution); our checksum is \(checksum).")  // 5880

for boxA in boxes {
    for boxB in boxes where boxB != boxA {
        var mismatches = 0
        var common = ""
        
        for (a, b) in zip(boxA, boxB) {
            if a == b {
                common.append(a)
            } else {
                mismatches += 1
            }
        }
        
        if mismatches == 1 {
            print("Part 2. the matching boxes share the letters: \(common)")  // tiwcdpbseqhxryfmgkvjujvza
            exit(0)
        }
    }
}
