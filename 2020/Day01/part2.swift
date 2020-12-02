import Foundation

let expenseReport = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
let expenseArray = expenseReport.components(separatedBy: "\n")

for expense in expenseArray {
	for expense2 in expenseArray {
		for expense3 in expenseArray {
			if(Int(expense)! + Int(expense2)! + Int(expense3)! == 2020) {
				print(Int(expense)! * Int(expense2)! * Int(expense3)!)
			}
		}
	}
}