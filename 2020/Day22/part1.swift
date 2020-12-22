import Foundation

var player1 = [1,43,24,34,13,7,10,36,14,12,47,32,11,3,9,25,37,21,2,45,26,8,23,6,49]
var player2 = [44,5,46,18,39,50,4,41,17,28,30,42,33,38,35,22,16,27,40,48,19,29,15,31,20]

while (player1.count > 0 && player2.count > 0) {
	let player1top = player1.removeFirst()
	let player2top = player2.removeFirst()
	
	if player1top > player2top {
		player1.append(contentsOf: [player1top, player2top])
	} else {
		player2.append(contentsOf: [player2top, player1top])
	}
}

let winner = player1.count > 0 ? player1 : player2

var score = 0
for (index, value) in winner.enumerated() {
	score += (value * (50 - index))
}
print(score)