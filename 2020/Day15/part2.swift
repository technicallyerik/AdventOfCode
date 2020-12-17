import Foundation

var input = [6,13,1,15,2,0]
var memoryNumbers: [Int: MemoryNumber] = [:]

var lastSpoke: MemoryNumber!

for i in 1...30000000 {
	if input.count > 0 {
		let number = input.removeFirst()
		let memoryNumber = MemoryNumber(number, i)
		memoryNumbers[number] = memoryNumber
		lastSpoke = memoryNumber
	} else {
		if lastSpoke.spokeOnce() {
			let zero = memoryNumbers[0]!
			zero.spoke(turn: i)
			lastSpoke = zero
		} else {
			let difference = lastSpoke.spokenDifference()
			var newNumber = memoryNumbers[difference]
			if newNumber == nil {
				newNumber = MemoryNumber(difference, i)
				memoryNumbers[difference] = newNumber
			} else {
				newNumber!.spoke(turn: i)
			}
			lastSpoke = newNumber
		}
	}
}

print(lastSpoke!.number)

class MemoryNumber {
	
	var lastSpoken: [Int] = []
	var number: Int
	
	init(_ number: Int, _ turn: Int) {
		self.number = number
		lastSpoken.append(turn)
	}
	
	func spoke(turn: Int) {
		lastSpoken.append(turn)
	}
	
	func spokeOnce() -> Bool {
		return lastSpoken.count == 1
	}
	
	func spokenDifference() -> Int {
		return lastSpoken[lastSpoken.count - 1] 
			 - lastSpoken[lastSpoken.count - 2]
	}
	
}