fun main(args: Array<String>) {
	
	val targetScore = "920831";
	val recepies = StringBuilder()
	recepies.append("37");
	var elf1position = 0;
	var elf2position = 1;
	
	for (i in 0..100000000) {
		var nextRecepie = recepies[elf1position].toString().toInt() + recepies[elf2position].toString().toInt();
		recepies.append(nextRecepie);
		elf1position = (elf1position + 1 + recepies[elf1position].toString().toInt()) % recepies.length;
		elf2position = (elf2position + 1 + recepies[elf2position].toString().toInt()) % recepies.length;
	}
	
	println(recepies.indexOf(targetScore));
	
}