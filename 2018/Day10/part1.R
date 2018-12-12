library(gsubfn)

myLines <- readLines(file("/Users/erik/Documents/AdventOfCode/2018/Day10/input.txt", open="r"))
closeAllConnections()

regex <- "^position=<\\D*?(-?\\d+),\\D*?(-?\\d+)> velocity=<\\D*?(-?\\d+),\\D*?(-?\\d+)>$"

coordinates <- strapplyc(myLines, regex, simplify = "rbind")

x <- c(as.numeric(coordinates[,1]))
y <- c(as.numeric(coordinates[,2]))
y <- y * -1

xDelta <- c(as.numeric(coordinates[,3]))
yDelta <- c(as.numeric(coordinates[,4]))
yDelta <- yDelta * -1

plot(x,y, pch=20)

for (i in 1:9900) {
  x <- x+xDelta
  y <- y+yDelta
}

for (i in 1:500) {
  x <- x+xDelta
  y <- y+yDelta
  plot(x,y, pch=20)
  readline(prompt="Press [enter] to continue")
}

# 10144

