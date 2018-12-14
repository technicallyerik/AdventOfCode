### TODO: Need to finish this

property puzzleInput: 3613
property squareSize: 300

property highX: 0
property highY: 0
property highValue: 0
property highSquareSize: 0

property gridValues: { }
repeat with y from 1 to squareSize
	set temp to {}
	repeat with x from 1 to squareSize
		set temp's end to 0
	end repeat
	set gridValues's end to temp
end repeat

repeat with currentY from squareSize to 1 by -1
	repeat with currentX from squareSize to 1 by -1
		log currentX & currentY
		if currentX < squareSize and currentY < squareSize then
			set currentValue to calculatePowerLevel(currentX, currentY) + (gridValues's item currentY's item (currentX + 1)) + (gridValues's item (currentY + 1)'s item currentX) - (gridValues's item (currentY + 1)'s item (currentX + 1)) 
		else if currentX < squareSize
			set currentValue to calculatePowerLevel(currentX, currentY) + gridValues's item currentY's item (currentX + 1)
		else if currentY < squareSize
			set currentValue to calculatePowerLevel(currentX, currentY) + gridValues's item (currentY + 1)'s item currentX
		else
			set currentValue to calculatePowerLevel(currentX, currentY)
		end if
		
		set gridValues's item currentY's item currentX to currentValue
				
	end repeat
end repeat

repeat with x from 1 to squareSize
	repeat with y from 1 to squareSize
		repeat with s from 1 to min(squareSize + 1 - x, squareSize + 1 - y)
			
			#set value to 
			
			#if currentValue is greater than highValue then
			#	set highX to x
			#	set highY to y
			#	set highSquareSize to s
			#	set highValue to value
			#end if	
			
		end repeat
	end repeat
end repeat

log highX
log highY
log highSquareSize
log highValue

on calculatePowerLevel(localX, localY)
	set rackId to localX + 10
	set powerLevel to rackId * localY
	set powerLevel to powerLevel + puzzleInput
	set powerLevel to powerLevel * rackId
	set powerLevel to (powerLevel mod 1000 - powerLevel mod 100) / 100
	set powerLevel to powerLevel - 5
	return powerLevel
end calculatePowerLevel

on max(x, y)
	if x is greater than or equal to y then
		return x
	else
		return y
	end if
end max

on min(x, y)
	if x is less than or equal to y then
		return x
	else
		return y
	end if
end max
