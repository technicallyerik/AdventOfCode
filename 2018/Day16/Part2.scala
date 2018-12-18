import scala.io.Source
import scala.util.matching.Regex

object Part2 {
	val commandRegex: Regex = "(\\d+) (\\d+) (\\d+) (\\d+)".r

	def main(args: Array[String]): Unit = {		
		val filename = "part2-input.txt"
		var registers: List[Int] = List(0, 0, 0, 0)
		for (command <- Source.fromFile(filename).getLines) {
			val commandMatch = commandRegex.findAllIn(command).subgroups.toList.map(_.toInt)
			commandMatch(0) match {
				case 3 => registers = new gtri().perform(commandMatch, registers)
				case 4 => registers = new gtrr().perform(commandMatch, registers)
				case 8 => registers = new eqir().perform(commandMatch, registers)
				case 5 => registers = new eqrr().perform(commandMatch, registers)
				case 13 => registers = new eqri().perform(commandMatch, registers)
				case 7 => registers = new gtir().perform(commandMatch, registers)
				case 14 => registers = new banr().perform(commandMatch, registers)
				case 2 => registers = new bani().perform(commandMatch, registers)
				case 1 => registers = new seti().perform(commandMatch, registers)
				case 9 => registers = new mulr().perform(commandMatch, registers)
				case 15 => registers = new setr().perform(commandMatch, registers)
				case 12 => registers = new bori().perform(commandMatch, registers)
				case 11 => registers = new borr().perform(commandMatch, registers)
				case 10 => registers = new addr().perform(commandMatch, registers)
				case 6 => registers = new addi().perform(commandMatch, registers)
				case 0 => registers = new muli().perform(commandMatch, registers)
			}
		}
		println(registers)
	}
}

trait opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int]
}

//addr (add register) stores into register C the result of adding register A and register B.
class addr extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		return data.updated(operation(3), data(operation(1)) + data(operation(2)))
	}
}

//addi (add immediate) stores into register C the result of adding register A and value B.
class addi extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		return data.updated(operation(3), data(operation(1)) + operation(2))
	}
}

//mulr (multiply register) stores into register C the result of multiplying register A and register B.
class mulr extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		return data.updated(operation(3), data(operation(1)) * data(operation(2)))
	}
}

//muli (multiply immediate) stores into register C the result of multiplying register A and value B.
class muli extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		return data.updated(operation(3), data(operation(1)) * operation(2))
	}
}

//banr (bitwise AND register) stores into register C the result of the bitwise AND of register A and register B.
class banr extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		return data.updated(operation(3), data(operation(1)) & data(operation(2)))
	}
}

//bani (bitwise AND immediate) stores into register C the result of the bitwise AND of register A and value B.
class bani extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		return data.updated(operation(3), data(operation(1)) & operation(2))
	}
}

//borr (bitwise OR register) stores into register C the result of the bitwise OR of register A and register B.
class borr extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		return data.updated(operation(3), data(operation(1)) | data(operation(2)))
	}
}

//bori (bitwise OR immediate) stores into register C the result of the bitwise OR of register A and value B.
class bori extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		return data.updated(operation(3), data(operation(1)) | operation(2))
	}
}

//setr (set register) copies the contents of register A into register C. (Input B is ignored.)
class setr extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		return data.updated(operation(3), data(operation(1)))
	}
}

//seti (set immediate) stores value A into register C. (Input B is ignored.)
class seti extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		return data.updated(operation(3), operation(1))
	}
}

//gtir (greater-than immediate/register) sets register C to 1 if value A is greater than register B. Otherwise, register C is set to 0.
class gtir extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		val valueA = operation(1)
		val registerB = data(operation(2))
		if (valueA > registerB) {
			return data.updated(operation(3), 1)
		}
		return data.updated(operation(3), 0)
	}
}

//gtri (greater-than register/immediate) sets register C to 1 if register A is greater than value B. Otherwise, register C is set to 0.
class gtri extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		val registerA = data(operation(1))
		val valueB = operation(2)
		if (registerA > valueB) {
			return data.updated(operation(3), 1)
		}
		return data.updated(operation(3), 0)	
	}	
}

//gtrr (greater-than register/register) sets register C to 1 if register A is greater than register B. Otherwise, register C is set to 0.
class gtrr extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		val registerA = data(operation(1))
		val registerB = data(operation(2))
		if (registerA > registerB) {
			return data.updated(operation(3), 1)
		}
		return data.updated(operation(3), 0)		
	}
}

//eqir (equal immediate/register) sets register C to 1 if value A is equal to register B. Otherwise, register C is set to 0.
class eqir extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		val valueA = operation(1)
		val registerB = data(operation(2))
		if (valueA == registerB) {
			return data.updated(operation(3), 1)
		}
		return data.updated(operation(3), 0)	
	}
}

//eqri (equal register/immediate) sets register C to 1 if register A is equal to value B. Otherwise, register C is set to 0.
class eqri extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		val registerA = data(operation(1))
		val valueB = operation(2)
		if (registerA == valueB) {
			return data.updated(operation(3), 1)
		}
		return data.updated(operation(3), 0)		
	}
}

//eqrr (equal register/register) sets register C to 1 if register A is equal to register B. Otherwise, register C is set to 0.
class eqrr extends opcode {
	def perform(operation: List[Int], data: List[Int]): List[Int] = {
		val registerA = data(operation(1))
		val registerB = data(operation(2))
		if (registerA == registerB) {
			return data.updated(operation(3), 1)
		}
		return data.updated(operation(3), 0)	
	}
}