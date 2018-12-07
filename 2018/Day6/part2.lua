function manhattan_distance(p, q)
	-- Source: https://github.com/kennyledet/Algorithm-Implementations/blob/master/Manhattan_distance/Lua/Yonaba/manhattan_distance.lua
	assert(#p == #q, 'vectors must have the same length')
	local s = 0
	for i in ipairs(p) do
		s = s + math.abs(p[i] - q[i])
	end
	return s
end

-- get coordinates
lines = {}
maxX = 0
maxY = 0
for line in io.lines("input.txt") do 
	x, y = line:match("([^,]+), ([^,]+)")
	x = tonumber(x)
	y = tonumber(y)
	s = {
		x = x,
		y = y
	}
	if x > maxX then
		maxX = x
	end
	if y > maxY then
		maxY = y	
	end
	lines[#lines + 1] = s
end

-- lay out nearest coordinates in grid
locations = 0
for gridX = 0, maxX, 1 do 
	for gridY = 0, maxY, 1 do
		distance = 0
		for k, v in pairs(lines) do 
			dist = manhattan_distance({gridX, gridY}, {v.x, v.y})
			distance = distance + dist
		end
		if distance < 10000 then
			locations = locations + 1
		end
	end
end

print(locations)