import Foundation

let requiredFields: [String] = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", /*"cid"*/]
let eyeColors: [String] = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

var passports = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
passports = passports.replacingOccurrences(of: "\n\n", with: "~")
passports = passports.replacingOccurrences(of: "\n", with: " ")
let passportEntries = passports.components(separatedBy: "~")

var validPassports = 0
for passport in passportEntries {
	let passportFields = passport.components(separatedBy: " ")
	var validFields = 0
	for passportField in passportFields {
		let fieldParts = passportField.components(separatedBy: ":")
		let key = fieldParts[0]
		let value = fieldParts[1]
		switch key {
			case "byr":
			// byr (Birth Year) - four digits; at least 1920 and at most 2002.
			if let year = Int(value) {
				if (year >= 1920 && year <= 2002) {
					validFields += 1
				}
			}
			break
			case "iyr":
			// iyr (Issue Year) - four digits; at least 2010 and at most 2020.
			if let year = Int(value) {
				if (year >= 2010 && year <= 2020) {
					validFields += 1
				}
			}
			break
			case "eyr":
			// eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
			if let year = Int(value) {
				if (year >= 2020 && year <= 2030) {
					validFields += 1
				}
			}
			break
			case "hgt":
			// hgt (Height) - a number followed by either cm or in:
			// 	If cm, the number must be at least 150 and at most 193.
			//	If in, the number must be at least 59 and at most 76.
			if(value.hasSuffix("cm")) {
				let height = value.prefix(3)
				if let heightInt = Int(height) {
					if (heightInt >= 150 && heightInt <= 193) {
						validFields += 1
					}
				}
			}
			if(value.hasSuffix("in")) {
				let height = value.prefix(2)
				if let heightInt = Int(height) {
					if (heightInt >= 59 && heightInt <= 76) {
						validFields += 1
					}
				}
			}
			break
			case "hcl":
			// hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
			if(value.range(of: "#[0-9a-f]{6}", options:.regularExpression) != nil) {
				validFields += 1
			}
			break
			case "ecl":
			// ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
			if(eyeColors.contains(value)) {
				validFields += 1
			}
			break
			case "pid":
			// pid (Passport ID) - a nine-digit number, including leading zeroes.
			if(CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: value)) && value.count == 9) {
				validFields += 1
			}
			break
			default:
			break
		}
	}
	if(validFields == 7) {
		validPassports += 1
	}
}

print(validPassports)