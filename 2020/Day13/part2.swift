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

var i = 0
while(true) {
	let matchingBusses = busObjs.filter({ (i + $0.start) % $0.duration == 0 })
	if(matchingBusses.count == busObjs.count) {
		print(i)
		break
	}
	let multiplier = matchingBusses.map({ $0.duration }).reduce(1, *)
	i += multiplier
}

class bus {
	init(start: Int, duration: Int) {
		self.start = start
		self.duration = duration
	}
	
	var start: Int
	var duration: Int
}