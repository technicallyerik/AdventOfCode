fun main(args: Array<String>) {
	
	val iterations = 920831;
	var recepies = "37";
	var elf1position = 0;
	var elf2position = 1;
	
	while (recepies.length < iterations + 10) {		
		var nextRecepie = recepies[elf1position].toString().toInt() + recepies[elf2position].toString().toInt();
		recepies += nextRecepie;
		elf1position = (elf1position + 1 + recepies[elf1position].toString().toInt()) % recepies.length;
		elf2position = (elf2position + 1 + recepies[elf2position].toString().toInt()) % recepies.length;
	}
	
	var substring = recepies.substring(recepies.length - 10, recepies.length);
	println(substring);
	
}