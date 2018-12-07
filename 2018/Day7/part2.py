import re

steps = {
	"A": [],
	"B": [],
	"C": [],
	"D": [],
	"E": [],
	"F": [],
	"G": [],
	"H": [],
	"I": [],
	"J": [],
	"K": [],
	"L": [],
	"M": [],
	"N": [],
	"O": [],
	"P": [],
	"Q": [],
	"R": [],
	"S": [],
	"T": [],
	"U": [],
	"V": [],
	"W": [],
	"X": [],
	"Y": [],
	"Z": [],
}

class elf:
	def __init__(self, letter, timeRemaining):
		self.letter = letter
		self.timeRemaining = timeRemaining
		
text_file = open("input.txt", "r")
lines = text_file.readlines()
for index, line in enumerate(lines):
	sr = re.search('Step (.*) must be finished before step (.*) can begin.', line)
	prereq = sr.group(1)
	step = sr.group(2)
	if step not in steps:
		steps[step] = []
	steps[step].append(prereq)
	
completed = []
elves = [
	elf(None, 0),
	elf(None, 0),
	elf(None, 0),
	elf(None, 0),
	elf(None, 0)
]
time = 0

while len(completed) < 26:
	
	for elfi in range(0, 5):
		if elves[elfi].letter != None:
			if elves[elfi].timeRemaining == 0:
				completed.append(elves[elfi].letter)
				elves[elfi].letter = None
			else:
				elves[elfi].timeRemaining -= 1
	
	for elfi in range(0, 5):	
		if elves[elfi].letter == None:
			for x in sorted(steps):
				if all(step in completed for step in steps[x]):
					steps.pop(x)
					elves[elfi].letter = x
					elves[elfi].timeRemaining = 60 + (ord(x) - 65)
					break

	print(str(time) + " " + (elves[0].letter or "-") + " " + (elves[1].letter or "-") + " " + (elves[2].letter or "-") + " " + (elves[3].letter or "-") + " " + (elves[4].letter or "-") + " " + "".join(completed))
	time += 1