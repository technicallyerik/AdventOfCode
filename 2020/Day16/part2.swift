import Foundation

let rules: [String: [[Int]]] = [
	"departure location": [[42,322], [347,954]],
	"departure station": [[49,533], [555,966]],
	"departure platform": [[28,86], [101,974]],
	"departure track": [[50,150], [156,950]],
	"departure date": [[30,117], [129,957]],
	"departure time": [[31,660], [678,951]],
	"arrival location": [[26,482], [504,959]],
	"arrival station": [[29,207], [220,971]],
	"arrival platform": [[28,805], [829,964]],
	"arrival track": [[48,377], [401,964]],
	"class": [[28,138], [145,959]],
	"duration": [[33,182], [205,966]],
	"price": [[25,437], [449,962]],
	"route": [[41,403], [428,968]],
	"row": [[33,867], [880,960]],
	"seat": [[40,921], [930,955]],
	"train": [[47,721], [732,955]],
	"type": [[33,243], [265,964]],
	"wagon": [[31,756], [768,973]],
	"zone": [[50,690], [713,967]]
]

let nearbyTicketsInput = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
					.components(separatedBy: "\n")

var nearbyTickets: [[Int]] = []

for ticket in nearbyTicketsInput {
	let ticketNumbers = ticket.components(separatedBy: ",").map({ Int($0)! })
	nearbyTickets.append(ticketNumbers)
}
	
// This is all terribly inefficient, but did not have time to refactor

var invalidTickets: [Int] = []
for (index, ticket) in nearbyTickets.enumerated() {
	var valid = true
	for number in ticket {
		var someRuleValid = false
		for rule in rules.keys {
			let rule = rules[rule]!
			if ((number >= rule[0][0] && number <= rule[0][1]) || 
			    (number >= rule[1][0] && number <= rule[1][1])) {
				someRuleValid = true
			}
		}
		if !someRuleValid {
			valid = false
		}
	}
	if !valid {
		invalidTickets.append(index)
	}
}

var ticketPositions: [String: [Int]] = [:]
for rule in rules.keys {
	ticketPositions[rule] = [Int](repeating: 0, count: 20)
}
for (index, ticket) in nearbyTickets.enumerated() {
	if !invalidTickets.contains(where: { $0 == index }) {
		for (numberIndex, number) in ticket.enumerated() {
			for ruleKey in rules.keys {
				let rule = rules[ruleKey]!
				for range in rule {
					if number >= range[0] && number <= range[1] {
						ticketPositions[ruleKey]![numberIndex] += 1
					}
				}
			}
		}
	}
}

var ticketPositionMaxes: [String: [Int]] = [:]
for ticketPosition in ticketPositions.keys {
	let ticketValues = ticketPositions[ticketPosition]!
	let max = ticketValues.max()
	var maxIndex: [Int] = []
	for (index, value) in ticketValues.enumerated() {
		if value == max {
			maxIndex.append(index)
		}
	}	
	ticketPositionMaxes[ticketPosition] = maxIndex
}

print(ticketPositionMaxes)

var ticketPositionAnswers: [String: Int] = [:]
var takenPositions: [Int] = []
while(ticketPositionAnswers.filter({ $0.key.starts(with: "departure") }).count < 6) {
	for ticketPosition in ticketPositionMaxes.keys {
		var maxPositions = ticketPositionMaxes[ticketPosition]!
		maxPositions.removeAll(where: { (value: Int) -> Bool in 
			takenPositions.contains(where: { $0 == value })
		})
		if maxPositions.count == 1 {
			ticketPositionAnswers[ticketPosition] = maxPositions[0]
			takenPositions.append(maxPositions[0])
		}
	}
}

print(ticketPositionAnswers)

let myTicket = [67,107,59,79,53,131,61,101,71,73,137,109,157,113,173,103,83,167,149,163]

var answer = 1
for position in ticketPositionAnswers.keys.filter({ $0.starts(with: "departure") }) {
	let positionKey = ticketPositionAnswers[position]!
	answer *= myTicket[positionKey]
}

print(answer)