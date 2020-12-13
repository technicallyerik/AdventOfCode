import Foundation

let directions = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
var directionArray = directions.components(separatedBy: "\n").map( { Array($0) })

var waypointnorth = 1
var waypointeast = 10

var shipnorth = 0
var shipeast = 0

var facing = 36000

for direction in directionArray {
	let instruction = direction[0]
	let number = Int(String(direction[1...]))!
	
	switch(instruction) {
		// Action N means to move the waypoint north by the given value..
		case "N":
			waypointnorth += number
		// Action S means to move the waypoint south by the given value.
		case "S":
			waypointnorth -= number
		// ction E means to move the waypoint east by the given value.
		case "E":
			waypointeast += number
		// Action W means to move the waypoint west by the given value.
		case "W":
			waypointeast -= number
		// Action L means to rotate the waypoint around the ship left (counter-clockwise) the given number of degrees.
		case "L":
			let own = waypointnorth
			let owe = waypointeast
			switch number {
				case 90:
					waypointnorth = owe
					waypointeast = -1 * own
				case 180:
					waypointeast = -1 * owe
					waypointnorth = -1 * own
				case 270:
					waypointnorth = -1 * owe
					waypointeast = own
				default:
				()
			}
		// Action R means to rotate the waypoint around the ship right (clockwise) the given number of degrees.
		case "R":
			let own = waypointnorth
			let owe = waypointeast
			switch number {
				case 90:
					waypointnorth = -1 * owe
					waypointeast = own
				case 180:
					waypointeast = -1 * owe
					waypointnorth = -1 * own
				case 270:
					waypointnorth = owe
					waypointeast = -1 * own
				default:
				()
			}
		// Action F means to move forward to the waypoint a number of times equal to the given value..
		case "F":
			shipnorth += (waypointnorth * number)
			shipeast += (waypointeast * number)
		default:
		()
	}
}

print("\(shipnorth) \(shipeast) \(abs(shipnorth) + abs(shipeast))")