package main

import (
	"bufio"
	"os"
	"log"
	//"fmt"
	"regexp"
	"sort"
	"strings"
	"strconv"
)

func main() {
	file, err := os.Open("input.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	var lines []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	sort.Strings(lines)
	
	currentGuard := 0
	lastSleep := 0
	
	guardSleepSchedule := make(map[int][60]int)
	
	for _, line := range lines {
		regex := regexp.MustCompile(`\[\d{4}-\d{2}-\d{2} \d{2}:(.*)\] (.*)`)
		res := regex.FindAllStringSubmatch(line, -1)
		minute, _ := strconv.Atoi(res[0][1])
		observation := res[0][2]
		
		if strings.HasPrefix(observation, "Guard") {
			guardNumberRegex := regexp.MustCompile(`Guard #(\d*) begins shift`)
			guardRegexMatches := guardNumberRegex.FindAllStringSubmatch(observation, -1)
			guardNumber, _ := strconv.Atoi(guardRegexMatches[0][1])
			currentGuard = guardNumber
		} else if strings.HasPrefix(observation, "falls") {
			lastSleep = minute
		} else if strings.HasPrefix(observation, "wakes") {
			guardInfo := guardSleepSchedule[currentGuard]
			for i := lastSleep; i < minute; i++ {
				guardInfo[i]+= 1
			}
			guardSleepSchedule[currentGuard] = guardInfo
		}	
	}
	
	maxGuard := 0
	maxSleep := 0
	maxHour := 0
	for k, v := range guardSleepSchedule { 		
		guardSleepHours := 0
		guardMaxHour := 0
		guardMaxHours := 0
		for hour, daysSleepingThatHour := range v {
			guardSleepHours += daysSleepingThatHour
			if daysSleepingThatHour > guardMaxHours {
				guardMaxHour = hour
				guardMaxHours = daysSleepingThatHour
			}
		}
		if guardSleepHours > maxSleep {
			maxGuard = k
			maxSleep = guardSleepHours
			maxHour = guardMaxHour
		}		
	}
	
	print(maxGuard)
	print(" * ")
	print(maxHour)
	
}