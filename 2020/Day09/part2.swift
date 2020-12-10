import Foundation

let numbers = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
let numbersArray = numbers.components(separatedBy: "\n")

var queue: [Int] = []
let magicNumber = 21806024

for number in numbersArray {
	let newNumber = Int(number)!
	
	queue.append(newNumber)
	
	while queue.reduce(0, +) > magicNumber {
		queue.removeFirst()
	}
	
	if queue.reduce(0, +) == magicNumber {
		print("\(queue.min()! + queue.max()!)")
		break
	}
	
}