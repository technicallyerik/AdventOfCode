import Foundation

let adapters = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
var adaptersArray = adapters.components(separatedBy: "\n").map({ Int($0)! })

adaptersArray.sort()
adaptersArray.reverse()
adaptersArray.append(0)

var precalculatedCombinations: [Int: Int] = [adaptersArray.first! + 3 : 1]

for adapter in adaptersArray {
	
	let combinations1 = precalculatedCombinations[adapter + 1] ?? 0
	let combinations2 = precalculatedCombinations[adapter + 2] ?? 0
	let combinations3 = precalculatedCombinations[adapter + 3] ?? 0
	
	precalculatedCombinations[adapter] = combinations1 + combinations2 + combinations3
	
}

print(precalculatedCombinations[adaptersArray.last!]!)

