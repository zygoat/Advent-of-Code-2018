// Advent of Code, Day 4: Snoozing guards.
//
// ben@zygoat.ca

import Foundation

let fileURL = URL(fileURLWithPath: "./snoozes.txt")
let entries = try! String.init(contentsOf: fileURL).split(separator: "\n")
let calendar = Calendar.current

enum Action {
    case begins(Int)
    case sleeps
    case wakes
}

typealias LogEvent = (date: Date, action: Action)

var events = [LogEvent]()

// Parse the log.
for entry in entries {
    let scanner = Scanner(string: String(entry))
    scanner.charactersToBeSkipped = CharacterSet.alphanumerics.inverted
    var year = 0 ; scanner.scanInt(&year)
    var month = 0 ; scanner.scanInt(&month)
    var day = 0 ; scanner.scanInt(&day)
    var hour = 0 ; scanner.scanInt(&hour)
    var minute = 0 ; scanner.scanInt(&minute)
    var keyword: NSString? ; scanner.scanUpTo(" ", into: &keyword)
    
    let components = DateComponents(calendar: calendar,
                                    year: year,
                                    month: month,
                                    day: day,
                                    hour: hour,
                                    minute: minute)
    let date = calendar.date(from: components)!
    
    var action: Action
    switch keyword?.lowercased {
    case "guard":
        var number = 0 ; scanner.scanInt(&number)
        action = .begins(number)
    case "wakes":
        action = .wakes
    case "falls":
        action = .sleeps
    default:
        fatalError("Unconsidered entry in the log!")
    }
    
    events.append((date, action))
}

// Sort the log and re-parse it into a guard snooze tally.
events.sort { $0.date < $1.date }

var minutesAsleepByGuard = [Int : [Int : Int]]() // [guardNumber : [minuteOfHour : count]]
var totalSleepByGuard = [Int : Int]() // [guardNumber : totalMinutes]
var currentGuard: Int?
var asleepMinute: Int?

for event in events {
    let minuteOfHour = calendar.component(.minute, from: event.date)
    
    switch event.action {
    case .begins(let guardNumber):
        currentGuard = guardNumber
    case .sleeps:
        asleepMinute = minuteOfHour
    case .wakes:
        guard let asleepMinute = asleepMinute,
            let currentGuard = currentGuard
            else { preconditionFailure() }
        
        for i in asleepMinute ..< minuteOfHour {
            minutesAsleepByGuard[currentGuard, default: [:]][i, default: 0] += 1
            totalSleepByGuard[currentGuard, default: 0] += 1
        }
    }
}

// Determine who slept the most.
let sleepyGuard = totalSleepByGuard.sorted { $0.value > $1.value }.first!.key
let sleepiestMinute = minutesAsleepByGuard[sleepyGuard]!.sorted { $0.value > $1.value }.first!.key
let product = sleepyGuard * sleepiestMinute

print("Part 1. Guard #\(sleepyGuard) was sleepiest, and most often at 00:\(sleepiestMinute); the product is \(product).")
