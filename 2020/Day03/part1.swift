import Foundation

let map = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
let mapRows = map.components(separatedBy: "\n")

var position = 0
var trees = 0
for i in 0...mapRows.count - 1 {
	let arrayIndex = position % 31
	let object = Array(mapRows[i])[arrayIndex]
	if (object == "#") {
		trees += 1
	}
	position += 3
}

print(trees)