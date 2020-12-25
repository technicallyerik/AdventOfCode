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
				if newY % 2 == 0 {
					newX = currentLocation.x
				} else {
					newX = currentLocation.x + 1
				}
			} else if second == "w" {
				if newY % 2 == 0 {
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