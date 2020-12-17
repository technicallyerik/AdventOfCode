import Foundation

var inputs: [[String]] = [
	["#","#",".",".","#",".","#","."],
	["#","#","#",".","#",".","#","#"],
	[".",".","#","#","#",".",".","#"],
	[".","#",".",".",".",".","#","#"],
	[".","#",".",".","#","#","#","#"],
	["#","#","#","#","#",".",".","."],
	["#","#","#","#","#","#","#","."],
	["#",".","#","#",".","#",".","#"]
]

struct threeDee: Hashable {
	var x: Int
	var y: Int
	var z: Int
	var w: Int
}

enum state {
	case active
	case inactive
}

var data: [threeDee: state] = [:]

for i in 0..<inputs.count {
	let row = inputs[i]
	for j in 0..<row.count {
		let position = threeDee(x: j, y: i, z: 0, w: 0)
		data[position] = row[j] == "#" ? .active : .inactive
	}
}

for _ in 1...6 {
	
	let minX = data.keys.map({ $0.x }).min()! - 1
	let maxX = data.keys.map({ $0.x }).max()! + 1
	let minY = data.keys.map({ $0.y }).min()! - 1
	let maxY = data.keys.map({ $0.y }).max()! + 1
	let minZ = data.keys.map({ $0.z }).min()! - 1
	let maxZ = data.keys.map({ $0.z }).max()! + 1
	let minW = data.keys.map({ $0.w }).min()! - 1
	let maxW = data.keys.map({ $0.w }).max()! + 1

	let dataCopy = data
	
	for calculateX in minX...maxX {
		for calculateY in minY...maxY {
			for calculateZ in minZ...maxZ {
				for calculateW in minW...maxW {
					
					let calculatePoint = threeDee(x: calculateX, y: calculateY, z: calculateZ, w: calculateW)
					let dataValue = dataCopy[calculatePoint]
					
					var nearbyActive = 0
					for x in -1...1 {
						for y in -1...1 {
							for z in -1...1 {
								for w in -1...1 {
									if !(x == 0 && y == 0 && z == 0 && w == 0) {
										let searchLocation = threeDee(x: calculateX + x, y: calculateY + y, z: calculateZ + z, w: calculateW + w)
										let searchValue = dataCopy[searchLocation]
										if searchValue == .active {
											nearbyActive += 1
										}
									}
								}
							}
						}
					}
					
					if dataValue == .active {
						if nearbyActive != 2 && nearbyActive != 3 {
							data[calculatePoint] = .inactive
						}
					} else {
						if nearbyActive == 3 {
							data[calculatePoint] = .active
						}
					}
					
				}
			}
		}
	}
}

var active = 0
for k in data.keys {
	if data[k] == .active {
		active += 1
	}
}

print(active)