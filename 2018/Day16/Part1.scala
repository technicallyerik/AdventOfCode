import scala.io.Source
import scala.util.matching.Regex

object Part1 {
	val beforeRegex: Regex = "^Before: \\[(\\d), (\\d), (\\d), (\\d)\\]$".r
	val commandRegex: Regex = "(\\d+) (\\d+) (\\d+) (\\d+)".r
	val afterRegex: Regex = "After:  \\[(\\d), (\\d), (\\d), (\\d)\\]".r

 	val operations: List[opcode] = List(
		new addr(),
		new addi(),
		new mulr(),
		new muli(),
		new banr(),
		new bani(),
		new borr(),
		new bori(),
		new setr(),
		new seti(),
		new gtir(),
		new gtri(),
		new gtrr(),
		new eqir(),
		new eqri(),
		new eqrr()
	)
	
	var operationMapper: Map[Int, List[String]] = Map()
	
	def main(args: Array[String]): Unit = {		
		val filename = "part1-input.txt"
		var ambiguousAlgorithms = 0
		for (List(before, command, after, space) <- Source.fromFile(filename).getLines.grouped(4)) {
			val beforeMatch = beforeRegex.findAllIn(before).subgroups.toList.map(_.toInt)
			val commandMatch = commandRegex.findAllIn(command).subgroups.toList.map(_.toInt)
			val afterMatch = afterRegex.findAllIn(after).subgroups.toList.map(_.toInt)
			
			var matches = 0
			var matchOperations: List[String] = List()
			for (operation <- operations) {
				var operationResult = operation.perform(commandMatch, beforeMatch)
				if(operationResult == afterMatch) {
					matches = matches + 1;
					matchOperations = matchOperations :+ operation.getClass.getName.toString
				}
			}
			
			if (operationMapper.contains(commandMatch(0))) {
				val existingOperations = operationMapper(commandMatch(0))
				operationMapper = operationMapper + (commandMatch(0) -> existingOperations.intersect(matchOperations))
			} else {
				operationMapper = operationMapper + (commandMatch(0) -> matchOperations)
			}
			
			if (matches >= 3) {
				ambiguousAlgorithms = ambiguousAlgorithms + 1
			}
		}
		println(ambiguousAlgorithms)
		
		var a = 0
		for(a <- 0 until 16) {
			val singleOperation = operationMapper.find({case (k, v) => v.length == 1}).head
			val singleKey = singleOperation._1
			val singleValue = singleOperation._2(0)
			println(singleKey + ": " + singleValue)
			operationMapper = operationMapper.filter({case (k, v) => k != singleKey})
			for((k, v) <- operationMapper) {
				operationMapper = operationMapper + (k -> v.filter(_ != singleValue))
			}
		}
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