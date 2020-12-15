import Foundation

let earliestTime = 1015292

let earliestBus = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
					   .components(separatedBy: ",")
					   .filter({ $0 != "x" })
					   .map( { Int($0)! })
					   .max(by: { earliestTime % $0 < earliestTime % $1 })!
let waitTime = abs(earliestTime - (earliestBus * (earliestTime / earliestBus)) - earliestBus)

print("\(earliestBus) \(waitTime) \(earliestBus * waitTime)")