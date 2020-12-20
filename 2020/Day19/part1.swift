import Foundation

let rules = try String.init(contentsOfFile: "rules.txt", encoding: .utf8)
					  .components(separatedBy: "\n")
					  .map({ $0.components(separatedBy: ": ") })

var ruleRoots: [Int: String] = [:]
var ruleDict: [Int: [[Int]]] = [:]

for rule in rules {
	let ruleId = Int(rule[0])!
	ruleDict[ruleId] = []
	let ruleRules = rule[1].components(separatedBy: " | ")
	for ruleRule in ruleRules {
		if(ruleRule.starts(with: "\"")) {
			let rule = ruleRule.replacingOccurrences(of: "\"", with: "")
			ruleRoots[ruleId] = rule
		} else {
			let ruleArray = ruleRule.components(separatedBy: " ").map({ Int($0)! })
			ruleDict[ruleId]!.append(ruleArray)
		}
	}
}

var precompiledRules: [Int: Set<String>] = [:]
for rule in ruleDict.keys {
	precompiledRules[rule] = compileRules(ruleId: rule)
}

func compileRules(ruleId: Int) -> Set<String> {
	if ruleRoots[ruleId] != nil {
		return [ruleRoots[ruleId]!]
	}
	
	let rule = ruleDict[ruleId]!
	
	var ruleStrings: Set<String> = []
	for ruleOption in rule {
		let firstRuleStrings = compileRules(ruleId: ruleOption[0])
		if ruleOption.count == 1 {
			for firstRuleString in firstRuleStrings {
				ruleStrings.insert(firstRuleString)
			}
		} else {
			let secondRuleStrings = compileRules(ruleId: ruleOption[1])
			for firstRuleString in firstRuleStrings {
				for secondRuleString in secondRuleStrings {
					ruleStrings.insert(firstRuleString + secondRuleString)
				}
			}
		}
	}
	return ruleStrings
}

let messages = try String.init(contentsOfFile: "messages.txt", encoding: .utf8)
					  .components(separatedBy: "\n")
	
var count = 0
for message in messages {
	if precompiledRules[0]!.contains(message) {
		count += 1
	}
}
print(count)