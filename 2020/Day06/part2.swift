import Foundation

var customsForms = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
let customFormsGroups = customsForms.components(separatedBy: "\n\n")

var count = 0
for group in customFormsGroups {
	let groupPeople = group.components(separatedBy: "\n")
	let firstPerson = groupPeople.first!
	var allYes = Set(firstPerson)
	if(groupPeople.count > 1) {
		for i in 1...groupPeople.count - 1 {
			let nextPerson = Set(groupPeople[i])
			allYes = allYes.intersection(nextPerson)
		}
	}
	count += allYes.count
}

print(count)