import Foundation

// 15-16 m: mhmjmzrmmlmmmmmm

let passwords = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
let passwordsArray = passwords.components(separatedBy: "\n")

var correctPasswords = 0

for password in passwordsArray {
	let passwordComponents = password.components(separatedBy: " ")
	let passwordRange = passwordComponents[0].components(separatedBy: "-")
	let passwordLetter = passwordComponents[1].replacingOccurrences(of: ":", with: "")
	let password = passwordComponents[2]
	let passwordRangeLower = Int(passwordRange[0])
	let passwordRangeUpper = Int(passwordRange[1])
	
	var letterCount = 0
	for character in Array(password) {
		if ("\(character)" == passwordLetter) {
			letterCount += 1
		}
	}
	if(letterCount >= passwordRangeLower! && letterCount <= passwordRangeUpper!) {
		correctPasswords += 1
	}
}

print(correctPasswords)