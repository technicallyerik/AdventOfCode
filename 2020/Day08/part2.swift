import Foundation

let instructions = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
let instructionArray = instructions.components(separatedBy: "\n")

var parsedInstructions: [(name: String, value: Int, visited: Bool)] = []

for instruction in instructionArray {
	let instructionParts = instruction.components(separatedBy: " ")
	let instructionTuple = (instructionParts[0], Int(instructionParts[1])!, false)
	parsedInstructions.append(instructionTuple)
}

for i in 0..<parsedInstructions.count {
	var pointer = 0
	var accumulator = 0
	var done = false
	
	while(!done) {
		let currentInstruction = parsedInstructions[pointer]
		
		if(currentInstruction.visited) {
			done = true
			break
		}
		
		parsedInstructions[pointer].visited = true
		
		var instruction = currentInstruction.name
		if(pointer == i) {
			if(instruction == "jmp") {
				instruction = "nop"
			} else if(instruction == "nop") {
				instruction = "jmp"
			}
		}
		
		switch(instruction) {
			case "acc":
			accumulator += currentInstruction.value
			pointer += 1
			case "jmp":
			pointer += currentInstruction.value
			case "nop":
			pointer += 1
			default:
			break
		}
				
		if(pointer == parsedInstructions.count) {
			print(accumulator)
			done = true
			break
		}
	}
	
	for i in 0..<parsedInstructions.count {
		parsedInstructions[i].visited = false
	}
}


