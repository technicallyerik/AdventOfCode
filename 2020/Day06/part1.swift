import Foundation

var customsForms = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
customsForms = customsForms.replacingOccurrences(of: "\n\n", with: "~")
customsForms = customsForms.replacingOccurrences(of: "\n", with: "")
let customFormsGroups = customsForms.components(separatedBy: "~")

var count = 0
for group in customFormsGroups {
	let unique = Set(group)
	count += unique.count
}

print(count)