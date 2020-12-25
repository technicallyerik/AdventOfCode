import Foundation

let cardPublicKey = 3418282
let doorPublicKey = 8719412

var cardSecretLoopSize = 0
var doorSecretLoopSize = 0

var value = 1
var loop = 1
while cardSecretLoopSize == 0 || doorSecretLoopSize == 0 {
	value = value * 7
	value = value % 20201227
	
	if(value == cardPublicKey) {
		cardSecretLoopSize = loop
	}
	
	if(value == doorPublicKey) {
		doorSecretLoopSize = loop
	}
	
	loop += 1
}

var encryptionKey = handshake(cardPublicKey, doorSecretLoopSize)

print("\(encryptionKey)")

func handshake(_ subjectNumber: Int, _ loopSize: Int) -> Int {
	var value = 1
	for _ in 1...loopSize {
		value = value * subjectNumber
		value = value % 20201227
	}
	return value
}