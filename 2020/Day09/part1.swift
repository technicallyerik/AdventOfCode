import Foundation

let numbers = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
let numbersArray = numbers.components(separatedBy: "\n")

var queue: [Int] = []

for number in numbersArray {
	let newNumber = Int(number)!
	
	if(queue.count == 25) {
		
		var hasSum = false
		for num1 in queue {
			for num2 in queue {
				if(num1 + num2 == newNumber) {
					hasSum = true
				}
			}
		}
		
		if(!hasSum) {
			print(newNumber)
			break
		}
		
		queue.removeFirst()
	}
	
	queue.append(newNumber)
}