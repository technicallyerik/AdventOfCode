import Foundation

let lines = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
				.components(separatedBy: "\n")

var memory: [Int: Int] = [:]
var currentMask: [Character] = []

for line in lines {
	
	let parts = line.components(separatedBy: " = ")
	let firstPart = parts[0]
	let secondPart = parts[1]
	
	// mask = 110000011XX0000X101000X10X01XX001011
	if firstPart.starts(with: "mask") {
		
		currentMask = Array(secondPart)

	// 	mem[49397] = 468472
	} else {
		
		let regex = try NSRegularExpression(pattern: "mem\\[(\\d+)\\]")
		let results = regex.matches(in: firstPart, range: NSMakeRange(0, firstPart.count))
		
		let value = Int(secondPart)!
		
		let memoryLocation = Int((firstPart as NSString).substring(with: results.first!.range(at: 1)))!
		let memoryLocationBinary = String(memoryLocation, radix: 2)
		let memoryLocationPadding = String(repeating: "0", count: 36 - memoryLocationBinary.count)
		let paddedMemoryLocation = memoryLocationPadding + memoryLocationBinary
		var memoryLocationBits = Array(paddedMemoryLocation)

		var floatingBits = 0
		for i in 0..<memoryLocationBits.count {
			let maskBit = currentMask[i]
			if (maskBit == "1") {
				memoryLocationBits[i] = "1"
			} else if (maskBit == "X") {
				memoryLocationBits[i] = "X"
				floatingBits += 1
			}
		}
		
		for i in 0..<Int(pow(Double(2), Double(floatingBits))) {
			var flipBitmask = String(i, radix: 2)
			let flipBitmaskPadding = String(repeating: "0", count: floatingBits - flipBitmask.count)
			flipBitmask = flipBitmaskPadding + flipBitmask
			let flipBitmaskArray = Array(flipBitmask)
			
			var flippedMemoryLocation = memoryLocationBits
			
			var flipLocation = 0
			for j in 0..<flippedMemoryLocation.count {
				if(flippedMemoryLocation[j] == "X") {
					flippedMemoryLocation[j] = flipBitmaskArray[flipLocation]
					flipLocation += 1
				}
			}
						
			memory[Int(String(flippedMemoryLocation), radix: 2)!] = value
		}
	
	}
	
}

var sum = 0
for addr in memory.keys {
	sum += memory[addr]!
}
print(sum)