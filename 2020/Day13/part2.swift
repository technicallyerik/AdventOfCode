import Foundation

let busses = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
                       .components(separatedBy: ",")
					
var busObjs: [bus] = []
for i in 0..<busses.count {
	let busNumber = busses[i]
	if(busNumber != "x") {
		let busObj = bus(start: i, duration: Int(busNumber)!)
		busObjs.append(busObj)
	}
}

// Brute force
for i in 1... {
	if(busObjs.allSatisfy({ (i + $0.start) % $0.duration == 0 })) {
		print(i)
		break
	}
}

// CRT -- Couldn't get this algorithm working
// let result = abs(crt(busObjs.map({$0.start}), busObjs.map({$0.duration})))
// print(result)

class bus {
	init(start: Int, duration: Int) {
		self.start = start
		self.duration = duration
	}
	
	var start: Int
	var duration: Int
}