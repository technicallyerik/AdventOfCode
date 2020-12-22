import Foundation

let ingredients = try String.init(contentsOfFile: "input.txt", encoding: .utf8)
					  .components(separatedBy: "\n")
						
var foods: [(known: [String], unknown: Set<String>)] = []
var ingredientMappings: [String: [Set<String>]] = [:]
var notPossibleAllergens: Set<String> = []

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
	
	notPossibleAllergens = notPossibleAllergens.union(unknownIngredientArray)
	foods.append((known: knownIngredientArray, unknown: unknownIngredientArray))
}

var possibleAllergens: Set<String> = []
for (knownIngredient, unknownLists) in ingredientMappings {
	
	var intersectionResult = unknownLists.first ?? []
	if unknownLists.count > 1 {
		for i in 1..<unknownLists.count {
			intersectionResult = intersectionResult.intersection(unknownLists[i])
		}
	}
	
	possibleAllergens = possibleAllergens.union(intersectionResult)	
}

notPossibleAllergens.subtract(possibleAllergens)

var count = 0
for food in foods {
	count += notPossibleAllergens.intersection(food.unknown).count
}
print(count)