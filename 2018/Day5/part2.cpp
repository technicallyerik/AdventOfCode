#include <iostream>
#include <fstream>
#include <list>
#include <stdio.h>
#include <ctype.h>

using namespace std;
int main(int argc, char *argv[]) {
	
	ifstream file("input.txt");
	string s;
	getline(file, s);

	//printf("%s\n", s.c_str());

	int bestLetter = 0;
	int bestReaction = 999999;

	for (int letter = 97 /*a*/; letter <= 122 /*z*/; letter++) {
		string newString = s;
		
		int i = 0;
		while(i < newString.length()) {
			if(tolower(newString[i]) == char(letter)) {
				newString.erase(i, 1);
			} else {
				i++;
			}
		}
				
		bool gogogo = true;
		while(gogogo) {		
			bool changesMade = false;
			int position = 0;
			while(position < newString.length()) {
				int positionPlus = position + 1;
				char textAtPosition = newString[position];
				char textAtPositionPlus = newString[positionPlus];
				
				bool lowerUpper = islower(textAtPosition) && isupper(textAtPositionPlus);
				bool upperLower = isupper(textAtPosition) && islower(textAtPositionPlus);
				bool charMatches = tolower(textAtPosition) == tolower(textAtPositionPlus);
				
				if ((lowerUpper || upperLower) && charMatches) {
					newString.erase(position, 2);
					changesMade = true;
				} else {
					position++;
				}
			}
			if(!changesMade) {
				gogogo = false;
			}
		}
		
		if (newString.size() < bestReaction) {
			bestLetter = letter;
			bestReaction = newString.size();
		}

	}

	cout << char(bestLetter) << ":" << bestReaction;

	return 0;	
}