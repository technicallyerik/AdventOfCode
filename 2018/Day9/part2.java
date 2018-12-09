import java.util.LinkedList;
import java.math.BigInteger; 
import java.util.*;

class Part2 {
	public static void main(String[] args) {
		
		int numPlayers = 458;
		int lastMarblePoints = 7201900;

		LinkedList<Integer> marbles = new LinkedList<>();
		marbles.add(0);	
		BigInteger playerScores[] = new BigInteger[numPlayers]; 

		ListIterator<Integer> currentMarblePosition = marbles.listIterator();
		int currentMarbleNumber = 1;

		while (currentMarbleNumber <= lastMarblePoints) {
			
			for (int currentPlayer = 0; currentPlayer < numPlayers; currentPlayer++) {
				
				if (currentMarbleNumber % 23 == 0) {
							
					int valueAtIterator = 0;
					for (int z = 0; z < 7; z++) {
						if (currentMarblePosition.hasPrevious()) {
							valueAtIterator = currentMarblePosition.previous();
						} else {
							currentMarblePosition = marbles.listIterator(marbles.size());
							valueAtIterator = currentMarblePosition.previous();
						}
					}
					
					BigInteger cbi = playerScores[currentPlayer];
					if(cbi == null) {
						cbi = new BigInteger("0");
					}
					
					playerScores[currentPlayer] = cbi.add(BigInteger.valueOf(currentMarbleNumber)).add(BigInteger.valueOf(valueAtIterator));
					currentMarblePosition.remove();

				} else {

					for (int z = 0; z < 2; z++) {
						if (currentMarblePosition.hasNext()) {
							currentMarblePosition.next();
						} else {
							currentMarblePosition = marbles.listIterator();
							currentMarblePosition.next();
						}
					}

					currentMarblePosition.add(currentMarbleNumber);
					currentMarblePosition.previous();
				}

				currentMarbleNumber++;

				if (currentMarbleNumber > lastMarblePoints) {
					break;
				}

				//System.out.println(marbles.toString());
				System.out.println(currentMarbleNumber);
			}
		}
		
		BigInteger max = new BigInteger("0");
		for(int i = 0; i < playerScores.length; i++) {
				if(playerScores[i].compareTo(max) == 1) {
					max = playerScores[i];
				}
		}
		
		System.out.println(max);
	}
}