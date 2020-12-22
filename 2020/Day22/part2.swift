import Foundation

var p1 = [1,43,24,34,13,7,10,36,14,12,47,32,11,3,9,25,37,21,2,45,26,8,23,6,49]
var p2 = [44,5,46,18,39,50,4,41,17,28,30,42,33,38,35,22,16,27,40,48,19,29,15,31,20]

let result = play(player1: p1, player2: p2, game: 1)

var score = 0
for (index, value) in result.cards.enumerated() {
	score += (value * (50 - index))
}
print(score)

func play(player1: [Int], player2: [Int], game: Int) -> (winner: Int, cards: [Int]) {
	
	var player1 = player1
	var player2 = player2
	
	var previousPlayer1: [[Int]] = []
	var previousPlayer2: [[Int]] = []
	
	var round = 1
	while (player1.count > 0 && player2.count > 0) {
		
		if previousPlayer1.contains(player1) || previousPlayer2.contains(player2) {
			print("Player 1 wins round \(round) of game \(game)")
			return (winner: 1, cards: player1)
		}
			
		previousPlayer1.append(player1)
		previousPlayer2.append(player2)
			
		let player1top = player1.removeFirst()
		let player2top = player2.removeFirst()
		
		var winner = 0
		if player1.count >= player1top && player2.count >= player2top {
			let recursiveResult = play(player1: Array(player1[0..<player1top]), 
									   player2: Array(player2[0..<player2top]),
									   game: game + 1)
			winner = recursiveResult.winner
		} else {
			winner = player1top > player2top ? 1 : 2
		}
		
		if winner == 1 {
			print("Player 1 wins round \(round) of game \(game)")
			player1.append(contentsOf: [player1top, player2top])
		} else {
			print("Player 2 wins round \(round) of game \(game)")
			player2.append(contentsOf: [player2top, player1top])
		}
		
		round += 1
	}
	
	return player1.count > 0 ? (winner: 1, cards: player1) : (winner: 2, cards: player2)
	
}