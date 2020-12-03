import Foundation

// 15-16 m: mhmjmzrmmlmmmmmm

let passwords = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
let passwordsArray = passwords.components(separatedBy: "\n")

var correctPasswords = 0

for password in passwordsArray {
	let passwordComponents = password.components(separatedBy: " ")
	let passwordRange = passwordComponents[0].components(separatedBy: "-")
	let passwordLetter = passwordComponents[1].replacingOccurrences(of: ":", with: "")
	let passwordArray = Array(passwordComponents[2])
	let passwordPosition1 = Int(passwordRange[0])
	let passwordPosition2 = Int(passwordRange[1])
	let characterAtFirstPosition = passwordArray[passwordPosition1! - 1]
	let characterAtSecondPosition = passwordArray[passwordPosition2! - 1]
	let firstEqual = "\(characterAtFirstPosition)" == passwordLetter
	let secondEqual = "\(characterAtSecondPosition)" == passwordLetter
	
	if(firstEqual != secondEqual) {
		correctPasswords += 1
	}
	
}

print(correctPasswords)