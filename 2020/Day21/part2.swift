import Foundation

let ingredients = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
					  .components(separatedBy: "\n")
						
var ingredientMappings: [String: [Set<String>]] = [:]
						
for ingredient in ingredients {
	let ingredientParts = ingredient.components(separatedBy: " (contains ")
		
	let unknownIngredients = ingredientParts[0]
	let knownIngredients = ingredientParts[1].trimmingCharacters(in: [")"])
	
	let unknownIngredientArray = Set(unknownIngredients.components(separatedBy: " "))
	let knownIngredientArray = knownIngredients.components(separatedBy: ", ")
	
	for knownIngredient in knownIngredientArray {
		
		if !ingredientMappings.keys.contains(knownIngredient) {
			ingredientMappings[knownIngredient] = [Set<String>]()
		}
		
		ingredientMappings[knownIngredient]!.append(unknownIngredientArray)
	}
}

var knownIngredientMappings: [String: Set<String>] = [:]

for (knownIngredient, unknownLists) in ingredientMappings {
	
	var intersectionResult = unknownLists.first ?? []
	if unknownLists.count > 1 {
		for i in 1..<unknownLists.count {
			intersectionResult = intersectionResult.intersection(unknownLists[i])
		}
	}
	
	knownIngredientMappings[knownIngredient] = intersectionResult
	
}

var finalAnswers: [String: String] = [:]

while knownIngredientMappings.count > 0 {
	
	let itemWithOne = knownIngredientMappings.first(where: { $0.value.count == 1 })!
	finalAnswers[itemWithOne.key] = itemWithOne.value.first!
	knownIngredientMappings.removeValue(forKey: itemWithOne.key)
	for (key, value) in knownIngredientMappings {
		knownIngredientMappings[key]!.remove(itemWithOne.value.first!)
	}
	
}

var dangerousIngredients: [String] = []
let sortedAnswers = finalAnswers.keys.sorted()
for sortedAnswer in sortedAnswers {
	dangerousIngredients.append(finalAnswers[sortedAnswer]!)
}

print(dangerousIngredients.joined(separator: ","))