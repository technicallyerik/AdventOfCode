#!/usr/bin/ruby

File.open("input.txt", "r") do |file_handle|
	twos = 0
	threes = 0
	file_handle.each_line do |boxid|
		characterFrequency = Hash.new(0)
		boxid.each_char do |c|
			characterFrequency[c] += 1
		end
		if characterFrequency.any?{|key, hash| hash == 2 } then
			twos += 1
		end
		if characterFrequency.any?{|key, hash| hash == 3 } then 
			threes += 1
		end
	end
	File.open("output-part1.txt", 'w') { |file| file.write(twos * threes) }
end