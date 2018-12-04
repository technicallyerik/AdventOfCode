use std::fs::File;
use std::io::BufReader;
use std::io::BufRead;

fn main() {
	let file = File::open("input.txt").expect("No such file");;
	let buf = BufReader::new(file);
	let strings: Vec<String> = buf.lines()
									.map(|l| l.expect("Could not parse line"))
									.collect();
									
	let mut fabric = [[0u16; 1000]; 1000];
									
	for string in strings {
		let stringParts: Vec<&str> = string.split_whitespace().collect();
		let number = stringParts[0];
		let coordinates = str::replace(stringParts[2], ":", "");
		let coordinateParts: Vec<&str> = coordinates.split(",").collect();
		let inchesFromLeft = coordinateParts[0].parse::<u16>().unwrap();
		let inchesFromTop = coordinateParts[1].parse::<u16>().unwrap();
		let size = stringParts[3];
		let sizeParts: Vec<&str> = size.split("x").collect();
		let width = sizeParts[0].parse::<u16>().unwrap();
		let height = sizeParts[1].parse::<u16>().unwrap();
		
		for li in inchesFromLeft..(inchesFromLeft + width) {
			for ti in inchesFromTop..(inchesFromTop + height) {
				fabric[li as usize][ti as usize] += 1;
			}
		}
	}
	
	let mut count = 0;
	for x in 0..1000 {
		for y in 0..1000 {
			let value = fabric[x as usize][y as usize];
			print!("{}", value);
			if value >= 2 {
				count+= 1;
			}
		}
		println!("")
	}
	
	print!("{}", count);
}