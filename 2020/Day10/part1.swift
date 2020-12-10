import Foundation

let adapters = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
var adaptersArray = adapters.components(separatedBy: "\n").map({ Int($0)! })

adaptersArray.sort()

var adapterJumps: [Int: Int] = [1: 0, 2: 0, 3: 1]

var lastAdapter = 0

for adapter in adaptersArray {
	let difference = adapter - lastAdapter
	adapterJumps[difference]! += 1
	lastAdapter = adapter
}

print("\(adapterJumps[1]!), \(adapterJumps[3]!), \(adapterJumps[1]! * adapterJumps[3]!)")