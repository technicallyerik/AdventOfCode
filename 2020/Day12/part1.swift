import Foundation

let directions = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
var directionArray = directions.components(separatedBy: "\n").map( { Array($0) })

var north = 0
var east = 0
var facing = 36000

for direction in directionArray {
	let instruction = direction[0]
	let number = Int(String(direction[1...]))!
	
	switch(instruction) {
		// Action N means to move north by the given value.
		case "N":
			north += number
		// Action S means to move south by the given value.
		case "S":
			north -= number
		// Action E means to move east by the given value.
		case "E":
			east += number
		// Action W means to move west by the given value.
		case "W":
			east -= number
		// Action L means to turn left the given number of degrees.
		case "L":
			facing -= number
		// Action R means to turn right the given number of degrees.
		case "R":
			facing += number
		// Action F means to move forward by the given value in the direction the ship is currently facing.
		case "F":
			switch(facing % 360) {
				case 0:
					east += number
				case 90:
					north -= number
				case 180:
					east -= number
				case 270:
					north += number
				default:
				()
			}
		default:
		()
	}
}

print("\(north) \(east) \(facing) \(abs(north) + abs(east))")