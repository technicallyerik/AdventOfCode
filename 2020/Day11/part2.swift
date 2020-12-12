import Foundation

let seats = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
var seatRows = seats.components(separatedBy: "\n").map({ Array($0) })

var hasChanges = false
var iterations = 0
var occupied = 0
repeat {
	hasChanges = false
	iterations += 1
	occupied = 0
	var newSeatRows = seatRows
	
	for r in 0..<seatRows.count {
		let row = seatRows[r]
		for c in 0..<row.count {
			let space = row[c]
			
			let n = isSeatFull(seatRows, currentRow: r, currentColumn: c, direction: "n")
			let ne = isSeatFull(seatRows, currentRow: r, currentColumn: c, direction: "ne")
			let e = isSeatFull(seatRows, currentRow: r, currentColumn: c, direction: "e")
			let se = isSeatFull(seatRows, currentRow: r, currentColumn: c, direction: "se")
			let s = isSeatFull(seatRows, currentRow: r, currentColumn: c, direction: "s")
			let sw = isSeatFull(seatRows, currentRow: r, currentColumn: c, direction: "sw")
			let w = isSeatFull(seatRows, currentRow: r, currentColumn: c, direction: "w")
			let nw = isSeatFull(seatRows, currentRow: r, currentColumn: c, direction: "nw")
			
			switch(space) {
				case "L":
				//If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
				if (n + ne + e + se + s + sw + w + nw == 0) {
					newSeatRows[r][c] = "#"
					occupied += 1
					hasChanges = true
				}
				case "#":
				//If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
				if (n + ne + e + se + s + sw + w + nw >= 5) {
					newSeatRows[r][c] = "L"
					hasChanges = true
				} else {
					occupied += 1
				}
				default:
				//Otherwise, the seat's state does not change.
				()
			}
		}
	}
	
	seatRows = newSeatRows
	
} while(hasChanges)

print("Iterations: \(iterations), Occupied: \(occupied)")

func isSeatFull(_ array: [[Character]], currentRow: Int, currentColumn: Int, direction: String) -> Int {

	var currentCharacter: Character?
	var r = currentRow
	var c = currentColumn
	
	repeat {
		switch(direction) {
			case "n":
				r = r - 1
			case "ne":
				r = r - 1
				c = c + 1
			case "e":
				c = c + 1
			case "se":
				r = r + 1
				c = c + 1
			case "s":
				r = r + 1
			case "sw":
				r = r + 1
				c = c - 1
			case "w":
				c = c - 1
			case "nw":
				r = r - 1
				c = c - 1
			default:
			()
		}
		
		currentCharacter = safeGet(array, row: r, column: c)
		if(currentCharacter == "#") {
			return 1
		} else if(currentCharacter == "L") {
			return 0
		}
		
	}
	while(currentCharacter != nil)
	
	return 0
}

func safeGet(_ array: [[Character]], row: Int, column: Int) -> Character? {
	if(array.indices.contains(row)) {
		let row = array[row]
		if(row.indices.contains(column)) {
			return row[column]
		}
	}
	
	return nil
}