import Foundation

let maths = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
					  .components(separatedBy: "\n")
					  .map({ $0.replacingOccurrences(of: " ", with: "") })
			
var grandSum = 0
for math in maths {
	let result = calculate(math)
	grandSum += result
}
print(grandSum)

func calculate(_ string: String) -> Int {	

	var array = Array(string.reversed())
	var sum = 0
	
	var opr: Character?
	while(array.count > 0) {
		
		let next = array.removeLast()
		
		if next.isNumber {
			if sum == 0 {
				sum = Int(String(next))!
			} else {
				if(opr == "+") {
					sum += Int(String(next))!
				} else if(opr == "*") {
					sum *= Int(String(next))!
				}
			}
			opr = nil
		} else if next == "(" {
			var numParens = 1
			var innerExpression: String = ""
			while (numParens > 0) {
				let nextParens = array.removeLast()
				if (nextParens == "(") {
					numParens += 1
				} else if(nextParens == ")") {
					numParens -= 1
				}
				if (numParens > 0) {
					innerExpression.append(nextParens)
				}
			}
			
			if sum == 0 {
				sum = calculate(innerExpression)
			} else {
				if(opr == "+") {
					sum += calculate(innerExpression)
				} else if(opr == "*") {
					sum *= calculate(innerExpression)
				}
			}
			
			opr = nil
			
		} else {
			opr = next
		}
	}
	
	return sum
	
}
