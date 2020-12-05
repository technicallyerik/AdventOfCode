import Foundation

let requiredFields: [String] = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", /*"cid"*/]

var passports = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
passports = passports.replacingOccurrences(of: "\n\n", with: "~")
passports = passports.replacingOccurrences(of: "\n", with: " ")
let passportEntries = passports.components(separatedBy: "~")

var validPassports = 0
for passport in passportEntries {
	let passportFields = passport.components(separatedBy: " ")
	var missingFields = requiredFields
	for passportField in passportFields {
		let fieldParts = passportField.components(separatedBy: ":")
		let key = fieldParts[0]
		let value = fieldParts[1]
		missingFields.removeAll(where: { $0 == key })
	}
	if(missingFields.count == 0) {
		validPassports += 1
	}
}

print(validPassports)