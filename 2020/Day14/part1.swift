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
		let memoryLocation = Int((firstPart as NSString).substring(with: results.first!.range(at: 1)))!
		let value = String(Int(secondPart)!, radix: 2)
		
		let padding = String(repeating: "0", count: 36 - value.count)
		let paddedValue = padding + value
		var valueArray = Array(paddedValue)
		
		for i in 0..<valueArray.count {
			let maskBit = currentMask[i]
			if (maskBit == "0") {
				valueArray[i] = "0"
			} else if (maskBit == "1") {
				valueArray[i] = "1"
			}
		}
	
		memory[memoryLocation] = Int(String(valueArray), radix: 2)
	
	}
	
}

var sum = 0
for addr in memory.keys {
	sum += memory[addr]!
}
print(sum)