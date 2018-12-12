import Foundation

let frequenciesString = try String.init(contentsOfFile: "input.txt")
let frequenciesArray = frequenciesString.components(separatedBy: "\n")

var initialResult = 0
var initialFrequencySums = [Int]()
for frequency in frequenciesArray {
	let numberStartIndex = frequency.index(frequency.startIndex, offsetBy: 1)
	let operation = frequency.first!
	let number = Int(frequency[numberStartIndex...])!

	switch operation {
		case "+":
			initialResult += number
		case "-":
			initialResult -= number
		default:
			break
	}
	
	initialFrequencySums.append(initialResult)
}

var duplicateResult: Int?
var frequencySumMultipler = 1
whileLoop: while duplicateResult == nil {
	for intialSum in initialFrequencySums {
		let number = intialSum + (initialResult * frequencySumMultipler)
		
		if initialFrequencySums.contains(number) {
			duplicateResult = number
			break whileLoop
		}		
	}
	frequencySumMultipler += 1
}

try! "\(duplicateResult!)".write(toFile: "output-part2.txt", atomically: true, encoding: .utf8)