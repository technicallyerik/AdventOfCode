import Foundation

var input = [4,1,8,9,7,6,2,3,5]
var minInput = input.min()!
var maxInput = input.max()!

var currentCup = Cup.initialize(numbers: input)

for c in 1...100 {
	
	print("-- move \(c) -- ")
	print("current cup: \(currentCup.label)")
	
	// The crab picks up the three cups that are immediately clockwise of the current cup. 
	// They are removed from the circle; cup spacing is adjusted as necessary to maintain the circle.
	let (cups, nextCup) = currentCup.pickThree()
	print("pick up: \(cups)")
	
	// The crab selects a destination cup: the cup with a label equal to the current cup's label minus one.
	var destinationCupValue = currentCup.label - 1
	if destinationCupValue < minInput {
		destinationCupValue = maxInput
	}
	while cups.contains(where: { $0.label == destinationCupValue }) {
		// If this would select one of the cups that was just picked up, 
		// the crab will keep subtracting one until it finds a cup that wasn't just picked up.
		destinationCupValue -= 1
		
		// If at any point in this process the value goes below the lowest value on any cup's label, 
		// it wraps around to the highest value on any cup's label instead.
		if destinationCupValue < minInput {
			destinationCupValue = maxInput
		}
	}
	print("destination: \(destinationCupValue)")
	
	// The crab places the cups it just picked up so that they are immediately clockwise of the destination cup. 
	// They keep the same order as when they were picked up.
	var destinationCup = currentCup
	while destinationCup.label != destinationCupValue {
		destinationCup = destinationCup.next
	}
	destinationCup.insertThree(beginning: cups.first!, end: cups.last!)
	
	// The crab selects a new current cup: the cup which is immediately clockwise of the current cup.
	currentCup = nextCup
}

while currentCup.label != 1 {
	currentCup = currentCup.next
}

var answer = ""
for _ in 0..<input.count {
	answer += "\(currentCup.label)"
	currentCup = currentCup.next
}
print(answer)

public class Cup: CustomStringConvertible {
	
	static func initialize(numbers: [Int]) -> Cup {
		let first = Cup(label: numbers.first!)
		var pointer = first
		for i in 1..<numbers.count {
			let next = Cup(label: numbers[i])
			pointer.next = next
			pointer = next
		}
		pointer.next = first
		return first
	}
	
	init(label: Int) {
		self.label = label
	}
	
	var label: Int
	var next: Cup!
	
	func pickThree() -> (cups: [Cup], nextCup: Cup) {
		
		var cups: [Cup] = []
		var nextCup: Cup = self.next
		for _ in 1...3 {
			cups.append(nextCup)
			nextCup = nextCup.next
		}
		self.next = nextCup
		
		return(cups: cups, nextCup: nextCup)
	}
	
	func insertThree(beginning: Cup, end: Cup) {
		
		let nextCup: Cup = self.next
		self.next = beginning
		end.next = nextCup
		
	}
	
	public var description: String { return "\(label)" }
}