import Foundation

let luggageRules = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
let luggageRuleArray = luggageRules.components(separatedBy: "\n")

var luggageDictionary: [String: Luggage] = [:]

for luggageRule in luggageRuleArray {
	let luggageRuleParts = luggageRule.components(separatedBy: " bags contain ")
	let luggageName = luggageRuleParts[0]
	var luggage = luggageDictionary[luggageName]
	if(luggage == nil) {
		luggage = Luggage(name: luggageName)
		luggageDictionary[luggageName] = luggage
	}
	let luggageContainsParts = luggageRuleParts[1].components(separatedBy: ", ")
	for luggageContains in luggageContainsParts {
		if(luggageContains != "no other bags.") {
			let luggageContainsPartParts = luggageContains.components(separatedBy: " ")
			let count = Int(luggageContainsPartParts[0])!
			let bag = "\(luggageContainsPartParts[1]) \(luggageContainsPartParts[2])"
			let luggageRule = LuggageRule(count: count, bag: bag)
			luggage!.rules.append(luggageRule)
		}
	}
}

let shinyGoldBag = luggageDictionary["shiny gold"]!
print(countChildren(luggage: shinyGoldBag))

func countChildren(luggage: Luggage) -> Int {
	var count = 0
	if(luggage.rules.count != 0) {
		for rule in luggage.rules {
			count += rule.count
			count += (rule.count * countChildren(luggage:luggageDictionary[rule.bag]!))
		}
	}
	return count
}

class Luggage {
	
	init(name: String) {
		self.name = name
	}
	
	public let name: String
	public var rules: [LuggageRule] = []
	
}

class LuggageRule {
	
	init(count: Int, bag: String) {
		self.count = count
		self.bag = bag
	}
	
	let count: Int
	let bag: String
	
}