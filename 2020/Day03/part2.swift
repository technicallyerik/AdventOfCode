import Foundation

let map = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
let mapRows = map.components(separatedBy: "\n")

var total = 1
let traversals = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
for traversal in traversals {
	let result = calculateTrees(right: traversal.0, down: traversal.1)
	total *= result
}

func calculateTrees(right: Int, down: Int) -> Int {
	var position = 0
	var trees = 0
	for i in stride(from: 0, to: mapRows.count, by: down) {
		let arrayIndex = position % 31
		let object = Array(mapRows[i])[arrayIndex]
		if (object == "#") {
			trees += 1
		}
		position += right
	}
	return trees
}

print(total)