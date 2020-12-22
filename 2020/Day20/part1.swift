import Foundation

let pieces = try String.init(contentsOfFile: "tiles.txt", encoding: .utf8)
					  .components(separatedBy: "\n\n")
					  .map({ $0.components(separatedBy: "\n") })
	
var pieceObjs: [PuzzlePiece] = []
for piece in pieces {
	
	let tileName = Array(piece[0])
	let substringIndex = Int(String(tileName[5...8]))!
	let pieceObj = PuzzlePiece(id: substringIndex)
	pieceObj.edge1 = Array(piece[1])
	pieceObj.edge2 = Array(piece[10])
	
	for i in 1...10 {
		let row = Array(piece[i])
		pieceObj.edge3.append(row[0])
		pieceObj.edge4.append(row[9])
	}
	
	pieceObjs.append(pieceObj)
}

var result = 1
for piece in pieceObjs {
	var matchingEdges = 0
	let edges = piece.edges
	for edge in edges {
		var hasMatchingEdge = false
		for otherPiece in pieceObjs {
			if otherPiece.id != piece.id {
				let otherEdges = otherPiece.edges
				for otherEdge in otherEdges {
					if edge == otherEdge || edge == String(Array(otherEdge).reversed()) {
						hasMatchingEdge = true
					}
				}	
			}
		}
		if hasMatchingEdge {
			matchingEdges += 1
		}
	}
	if matchingEdges == 2 {
		result *= piece.id
	}
}

print(result)

class PuzzlePiece {
	
	init(id: Int) {
		self.id = id
	}
	
	var id: Int
	var edge1: [Character] = []
	var edge2: [Character] = []
	var edge3: [Character] = []
	var edge4: [Character] = []
	var edges: [String] {
		[String(edge1), String(edge2), String(edge3), String(edge4)]
	}
}