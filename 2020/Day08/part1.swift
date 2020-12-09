import Foundation

let instructions = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
let instructionArray = instructions.components(separatedBy: "\n")

var parsedInstructions: [(name: String, value: Int, visited: Bool)] = []

for instruction in instructionArray {
	let instructionParts = instruction.components(separatedBy: " ")
	let instructionTuple = (instructionParts[0], Int(instructionParts[1])!, false)
	parsedInstructions.append(instructionTuple)
}

var pointer = 0
var accumulator = 0
var done = false

while(!done) {
	let currentInstruction = parsedInstructions[pointer]
	
	if(currentInstruction.visited) {
		print(accumulator)
		done = true
		break
	}
	
	parsedInstructions[pointer].visited = true
	
	switch(currentInstruction.name) {
		case "acc":
		accumulator += currentInstruction.value
		pointer += 1
		break
		case "jmp":
		pointer += currentInstruction.value
		break
		case "nop":
		pointer += 1
		break
		default:
		break
	}
	
}
