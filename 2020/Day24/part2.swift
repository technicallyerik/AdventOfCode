import Foundation

let tiles = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
					  .components(separatedBy: "\n")
						
var tilesFlipped: [TileLocation: Bool] = [:]

for tile in tiles {
	
	var tileInstructions = Array(tile)
	var currentLocation = TileLocation(0, 0)
	while tileInstructions.count > 0 {
		let first = tileInstructions.removeFirst()
		if first == "e" {
			currentLocation = TileLocation(currentLocation.x + 1, currentLocation.y)
		} else if first == "w" {
			currentLocation = TileLocation(currentLocation.x - 1, currentLocation.y)
		} else {
			let second = tileInstructions.removeFirst()
			
			var newY: Int!
			if first == "s" {
				newY = currentLocation.y - 1
			} else if first == "n" {
				newY = currentLocation.y + 1
			}

			var newX: Int!
			if second == "e" {
				if currentLocation.y % 2 == 0 {
					newX = currentLocation.x
				} else {
					newX = currentLocation.x + 1
				}
			} else if second == "w" {
				if currentLocation.y % 2 == 0 {
					newX = currentLocation.x - 1
				} else {
					newX = currentLocation.x
				}
			}
			
			currentLocation = TileLocation(newX, newY)
		}
	}

	tilesFlipped[currentLocation] = !(tilesFlipped[currentLocation] ?? false)
}

let Xes = tilesFlipped.keys.map{ $0.x }
let Yes = tilesFlipped.keys.map{ $0.y }
var floorMaxX = Xes.max()! + 1
var floorMinX = Xes.min()! - 1
var floorMaxY = Yes.max()! + 1
var floorMinY = Yes.min()! - 1

for i in 1...100 {
	
	var tilesFlippedCopy = tilesFlipped
	
	for x in floorMinX...floorMaxX {
		for y in floorMinY...floorMaxY {
			
			let currentTile = (tilesFlipped[TileLocation(x, y)] ?? false)
			
			let e = (tilesFlipped[TileLocation(x + 1, y)] ?? false) ? 1 : 0
			let w = (tilesFlipped[TileLocation(x - 1, y)] ?? false) ? 1 : 0
			let se = (tilesFlipped[TileLocation(x + (y % 2 == 0 ? 0 : 1), y - 1)] ?? false) ? 1 : 0
			let sw = (tilesFlipped[TileLocation(x + (y % 2 == 0 ? -1 : 0), y - 1)] ?? false) ? 1 : 0
			let nw = (tilesFlipped[TileLocation(x + (y % 2 == 0 ? -1 : 0), y + 1)] ?? false) ? 1 : 0
			let ne = (tilesFlipped[TileLocation(x + (y % 2 == 0 ? 0 : 1), y + 1)] ?? false) ? 1 : 0
			let total = e + w + se + sw + nw + ne
			
			if currentTile {
				if total == 0 || total > 2 {
					tilesFlippedCopy[TileLocation(x, y)] = false
				}
			} else {
				if total == 2 {
					tilesFlippedCopy[TileLocation(x, y)] = true
				}
			}
			
		}
	}
	
	floorMaxX += 1
	floorMinX -= 1
	floorMaxY += 1
	floorMinY -= 1
	
	tilesFlipped = tilesFlippedCopy
}

var result = 0
for (key, value) in tilesFlipped {
	if value {
		result += 1
	}
}
print(result)

struct TileLocation: Hashable {
	
	init(_ x: Int, _ y: Int) {
		self.x = x
		self.y = y
	}
	
	var x: Int
	var y: Int
}