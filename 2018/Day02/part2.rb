#!/usr/bin/ruby

def removeCharacterAtIndex(string, index)
	return string.chars.map.with_index do |c, i|
	if i == index
		""
	else
		c
	end
	end.join
end

boxIds = File.readlines('input.txt')

for i in 0..25 do
	boxIdsCharRemoved = boxIds.map{ | boxId | removeCharacterAtIndex(boxId, i) }
	result = boxIdsCharRemoved.detect { | boxId | boxIdsCharRemoved.count(boxId) > 1 }
	if result
		File.open("output-part2.txt", 'w') { |file| file.write(result) }
	end
end

