import Foundation

let frequenciesString = try String.init(contentsOfFile: "input.txt")
let frequenciesArray = frequenciesString.components(separatedBy: "\n")
var result = 0
for frequency in frequenciesArray {
	let numberStartIndex = frequency.index(frequency.startIndex, offsetBy: 1)
	let operation = frequency.first!
	let number = Int(frequency[numberStartIndex...])!
	switch operation {
		case "+":
			result += number
		case "-":
			result -= number
		default:
			break
	}
}
try! "\(result)".write(toFile: "output-part1.txt", atomically: true, encoding: .utf8)
