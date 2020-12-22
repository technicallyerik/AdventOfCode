import Foundation

let pieces = try String.init(contentsOfFile: "tiles.txt", encoding: .utf8)
					  .components(separatedBy: "\n\n")
					  .map({ $0.components(separatedBy: "\n") })
	
var pieceObjs: [Int: PuzzlePiece] = [:]
for piece in pieces {
	
	let tileName = Array(piece[0])
	let tileId = Int(String(tileName[5...8]))!
	let pieceObj = PuzzlePiece(id: tileId)
	pieceObj.edge1.characters = Array(piece[1])
	pieceObj.edge2.characters = Array(piece[10])
	
	for i in 1...10 {
		let row = Array(piece[i])
		pieceObj.edge3.characters.append(row[0])
		pieceObj.edge4.characters.append(row[9])
	}
	
	// TODO: Collect the tile "insides"
	
	pieceObjs[tileId] = pieceObj
}

for pieceKey in pieceObjs.keys {
	let piece = pieceObjs[pieceKey]!
	let edges = piece.edges
	for edge in edges {
		for otherPieceKey in pieceObjs.keys {
			let otherPiece = pieceObjs[otherPieceKey]!
			if otherPiece.id != piece.id {
				let otherEdges = otherPiece.edges
				for otherEdge in otherEdges {
					if edge.string == otherEdge.string || edge.string == String(otherEdge.characters.reversed()) {
						edge.adjoiningPiece = otherPieceKey
					}
				}	
			}
		}
	}
}

for pieceKey in pieceObjs.keys {
	let piece = pieceObjs[pieceKey]!
	print("\(piece.id): \(piece.edge1.adjoiningPiece ?? 0) \(piece.edge2.adjoiningPiece ?? 0) \(piece.edge3.adjoiningPiece ?? 0) \(piece.edge4.adjoiningPiece ?? 0)")
}

// TODO: Figure out how to arrange connected pieces in a square and find monster

class PuzzlePiece {
	
	init(id: Int) {
		self.id = id
	}
	
	var id: Int
	var edge1: PuzzlePieceEdge = PuzzlePieceEdge()
	var edge2: PuzzlePieceEdge = PuzzlePieceEdge()
	var edge3: PuzzlePieceEdge = PuzzlePieceEdge()
	var edge4: PuzzlePieceEdge = PuzzlePieceEdge()
	var edges: [PuzzlePieceEdge] {
		[edge1, edge2, edge3, edge4]
	}
}

class PuzzlePieceEdge {
	
	var characters: [Character] = []
	var string: String {
		String(characters)
	}
	var adjoiningPiece: Int?
	
}