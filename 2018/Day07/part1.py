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

text_file = open("input.txt", "r")
lines = text_file.readlines()
for index, line in enumerate(lines):
	sr = re.search('Step (.*) must be finished before step (.*) can begin.', line)
	prereq = sr.group(1)
	step = sr.group(2)
	if step not in steps:
		steps[step] = []
	steps[step].append(prereq)

for x in sorted(steps):
	print(x + ": " + ",".join(steps[x]))
	
completed = []

while len(steps) > 0:
	for x in sorted(steps):
		if all(step in completed for step in steps[x]):
			completed.append(x)
			steps.pop(x)
			break

print("".join(completed))