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
nearestMatrix = {}
for gridX = 0, maxX, 1 do 
	nearestMatrix[gridX] = {}
	for gridY = 0, maxY, 1 do
		nearestMatrix[gridX][gridY] = 0
		dists = {}
		for k, v in pairs(lines) do 
			dist = manhattan_distance({gridX, gridY}, {v.x, v.y})
			dists[k] = dist
		end
		minDistance = 9999
		minDistanceIndex = -1
		for k, v in pairs(dists) do 
			if v < minDistance then
				minDistance = v
				minDistanceIndex = k
			elseif v == minDistance then
				minDistanceIndex = -1
			end
		end		
		nearestMatrix[gridX][gridY] = minDistanceIndex
	end
end

-- get counts for each coordinates
coordCount = {}
for gridX = 0, maxX, 1 do 
	for gridY = 0, maxY, 1 do
		index = nearestMatrix[gridX][gridY]
		--io.write(index, " ")
		if coordCount[index] == nil then
			coordCount[index] = 0
		end
		coordCount[index] = coordCount[index] + 1
	end
	--print("")
end

-- disquality any coordinates on edge
for gridX = 0, maxX, 1 do 
	for gridY = 0, maxY, 1 do
		index = nearestMatrix[gridX][gridY]
		if gridX == 0 or gridY == 0 or gridX == maxX or gridY == maxY then
			coordCount[index] = 0
		end
	end
end

-- count max area
maxCount = 0
for k, v in pairs(coordCount) do
	print(k, v)
	if v > maxCount then
		maxCount = v
	end
end

print(maxCount)