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
	
var errorRate = 0
for ticket in nearbyTickets {
	for number in ticket {
		var valid = false
		for rule in rules.keys {
			let rule = rules[rule]!
			for range in rule {
				if number > range[0] && number < range[1] {
					valid = true
				}
			}
		}
		if !valid {
			errorRate += number
		}
	}
}

print(errorRate)