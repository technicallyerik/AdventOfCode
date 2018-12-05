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

	bool gogogo = true;
	while(gogogo) {		
		bool changesMade = false;
		int position = 0;
		while(position < s.length()) {
			int positionPlus = position + 1;
			char textAtPosition = s[position];
			char textAtPositionPlus = s[positionPlus];
			
			bool lowerUpper = islower(textAtPosition) && isupper(textAtPositionPlus);
			bool upperLower = isupper(textAtPosition) && islower(textAtPositionPlus);
			bool charMatches = tolower(textAtPosition) == tolower(textAtPositionPlus);
			
			if ((lowerUpper || upperLower) && charMatches) {
				s.erase(position, 2);
				changesMade = true;
			} else {
				position++;
			}
		}
		if(!changesMade) {
			gogogo = false;
		}
	}
	
	cout << s.size();

	return 0;	
}