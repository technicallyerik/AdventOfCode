property puzzleInput: 3613

property x: 1
property y: 1

property highX: 0
property highY: 0
property highValue: 0

property gridValues: { }

repeat 298 times
	set rowValues to { }
	repeat 298 times
		set val1 to calculatePowerLevel(x, y)
		set val2 to calculatePowerLevel(x + 1, y)
		set val3 to calculatePowerLevel(x + 2, y)
		set val4 to calculatePowerLevel(x, y + 1)
		set val5 to calculatePowerLevel(x + 1, y + 1)
		set val6 to calculatePowerLevel(x + 2, y + 1)
		set val7 to calculatePowerLevel(x, y + 2)
		set val8 to calculatePowerLevel(x + 1, y + 2)
		set val9 to calculatePowerLevel(x + 2, y + 2)
		set totalValue to val1 + val2 + val3 + val4 + val5 + val6 + val7 + val8 + val9
		if totalValue is greater than highValue then
			set highX to x
			set highY to y
			set highValue to totalValue
		end if		
		set x to x + 1
	end repeat
#	log rowValues
	copy rowValues to end of gridValues
	set x to 1
	set y to y + 1
end repeat

log highX
log highY
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
