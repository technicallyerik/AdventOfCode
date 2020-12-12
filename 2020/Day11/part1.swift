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
			
			let n = isSeatFull(safeGet(seatRows, row: r - 1, column: c))
			let ne = isSeatFull(safeGet(seatRows, row: r - 1, column: c + 1))
			let e = isSeatFull(safeGet(seatRows, row: r, column: c + 1))
			let se = isSeatFull(safeGet(seatRows, row: r + 1, column: c + 1))
			let s = isSeatFull(safeGet(seatRows, row: r + 1, column:  c))
			let sw = isSeatFull(safeGet(seatRows, row: r + 1, column: c - 1))
			let w = isSeatFull(safeGet(seatRows, row: r, column: c - 1))
			let nw = isSeatFull(safeGet(seatRows, row: r - 1, column: c - 1))
			
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
				if (n + ne + e + se + s + sw + w + nw >= 4) {
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

func isSeatFull(_ character: Character?) -> Int {
	return character == "#" ? 1 : 0
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