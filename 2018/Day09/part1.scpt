# Note to reader:  I've been picking the language at random before looking at the puzzle.
# In this case, it didn't work out too well for this puzzle.  Internally, AppleScript stores
# lists as vectors, which are great for random access, but not for all the insertions and deletions
# needed to solve this puzzle.  This code worked to solve the example, but runs too long 
# to solve with my inputs, so I wrote the actual solution in Java.


#set inputFile to "input.txt"
#set inputFileHandle to open for access inputFile
#set inputs to paragraphs of (read inputFileHandle)
#close access inputFileHandle
#
#repeat with input in inputs
#	log input
#end repeat

property numPlayers: 9
property lastMarblePoints: 25

property marbles: { 0 }
property playerScores: { }
repeat numPlayers times 
	copy 0 to end of playerScores
end repeat

property currentMarblePosition: 1
property currentPlayer: 1
property currentMarbleNumber: 1

repeat while currentMarbleNumber <= lastMarblePoints

	repeat numPlayers times

		if currentMarbleNumber mod 23 is equal to 0 then
		
			set counterClockwiseMarble to (currentMarblePosition - 7)
			set item currentPlayer of playerScores to ((item currentPlayer of playerScores) + currentMarbleNumber + (item counterClockwiseMarble of marbles))
		
			set marbles to deleteItemInList(marbles, counterClockwiseMarble)
			set currentMarblePosition to counterClockwiseMarble
		
		else
		
			set nextMarblePosition to currentMarblePosition + 2
			if nextMarblePosition > ((length of marbles) + 1) then
				set nextMarblePosition to nextMarblePosition - (length of marbles)
			end if
			set marbles to insertItemInList(currentMarbleNumber, marbles, nextMarblePosition)
				
			set currentMarblePosition to nextMarblePosition

		end if 
		
		set currentMarbleNumber to currentMarbleNumber + 1
		set currentPlayer to currentPlayer + 1
		
		if currentMarbleNumber > lastMarblePoints then
			exit
		end if
		
		#log convertListToString(marbles, " ")
		
	end repeat
	
	set currentPlayer to 1

end repeat

#log convertListToString(playerScores, " ")
log getHighestNumberInList(playerScores)

on deleteItemInList(theList, thePosition)

	set resultList to {}
	set sourceListCount to count theList

	repeat with i from 1 to sourceListCount
		if i is not thePosition then set end of resultList to item i of theList
	end repeat
	
	return resultList

end deleteItemInList

# List manipulation methods taken from
# https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/ManipulateListsofItems.html

on insertItemInList(theItem, theList, thePosition)
	set theListCount to length of theList
	if thePosition is 0 then
		return false
	else if thePosition is less than 0 then
		if (thePosition * -1) is greater than theListCount + 1 then return false
	else
		if thePosition is greater than theListCount + 1 then return false
	end if
	if thePosition is less than 0 then
		if (thePosition * -1) is theListCount + 1 then
			set beginning of theList to theItem
		else
			set theList to reverse of theList
			set thePosition to (thePosition * -1)
			if thePosition is 1 then
				set beginning of theList to theItem
			else if thePosition is (theListCount + 1) then
				set end of theList to theItem
			else
				set theList to (items 1 thru (thePosition - 1) of theList) & theItem & (items thePosition thru -1 of theList)
			end if
			set theList to reverse of theList
		end if
	else
		if thePosition is 1 then
			set beginning of theList to theItem
		else if thePosition is (theListCount + 1) then
			set end of theList to theItem
		else
			set theList to (items 1 thru (thePosition - 1) of theList) & theItem & (items thePosition thru -1 of theList)
		end if
	end if
	return theList
end insertItemInList

on convertListToString(theList, theDelimiter)
	set AppleScript's text item delimiters to theDelimiter
	set theString to theList as string
	set AppleScript's text item delimiters to ""
	return theString
end convertListToString

on getHighestNumberInList(theList)
	set theHighestNumber to 0
	repeat with a from 1 to count of theList
		set theCurrentItem to item a of theList
		set theClass to class of theCurrentItem
		if theClass is in {integer, real} then
			if theHighestNumber is "" then
				set theHighestNumber to theCurrentItem
			else if theCurrentItem is greater than theHighestNumber then
				set theHighestNumber to item a of theList
			end if
		else if theClass is list then
			set theHighValue to getHighestNumberInList(theCurrentItem)
			if theHighValue is greater than theHighestNumber then
				set theHighestNumber to theHighValue
			end if
		end if
	end repeat
	return theHighestNumber
end getHighestNumberInList