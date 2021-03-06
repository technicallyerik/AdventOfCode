import Foundation

var boardingPassesInput = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
let boardingPasses = boardingPassesInput.components(separatedBy: "\n")

var seatNumbers: [Int] = []
for boardingPass in boardingPasses {
	var rows = Array(boardingPass.prefix(8))
	var columns = Array(boardingPass.suffix(3))
	
	var minRow = 0
	var maxRow = 127
	var minColumn = 0
	var maxColumn = 7
	
	let row = calculate(rows: &rows, min: &minRow, max: &maxRow, minChar: "F", maxChar: "B")
	let column = calculate(rows: &columns, min: &minColumn, max: &maxColumn, minChar: "L", maxChar: "R")
	let seat = (row * 8) + column
	seatNumbers.append(seat)
}

seatNumbers.sort()
var lastSeat = seatNumbers.first!
for i in 1...seatNumbers.count - 1 {
	let currentSeat = seatNumbers[i]
	if(currentSeat != lastSeat + 1) {
		print(currentSeat - 1)
	}
	lastSeat = currentSeat
}

func calculate(rows: inout [Character], min: inout Int, max: inout Int, minChar: Character, maxChar: Character) -> Int {

	if(min == max) {
		return min
	}
	
	let next = rows[0]

	if(next == minChar) {
		max = min + (((max - 1) - min) / 2)
	}
	if(next == maxChar) {
		min = min + (((max + 1) - min) / 2)
	}
	
	rows.removeFirst()
	return calculate(rows: &rows, min: &min, max: &max, minChar: minChar, maxChar: maxChar)

}