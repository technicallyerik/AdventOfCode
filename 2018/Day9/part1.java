import java.util.LinkedList;

class Part1 {
	public static void main(String[] args) {
		
		int numPlayers = 458;
		int lastMarblePoints = 72019;

		LinkedList<Integer> marbles = new LinkedList<>();
		marbles.add(0);	
		int playerScores[] = new int[numPlayers]; 

		int currentMarblePosition = 0;
		int currentMarbleNumber = 1;

		while (currentMarbleNumber <= lastMarblePoints) {
			
			for (int currentPlayer = 0; currentPlayer < numPlayers; currentPlayer++) {
				
				if (currentMarbleNumber % 23 == 0) {
				
					int counterClosewiseMarble = currentMarblePosition - 7;
					if (counterClosewiseMarble < 0) {
						counterClosewiseMarble = (marbles.size() + counterClosewiseMarble);
					}
					
					playerScores[currentPlayer] = playerScores[currentPlayer] + currentMarbleNumber + marbles.get(counterClosewiseMarble);

					marbles.remove(counterClosewiseMarble);
					currentMarblePosition = counterClosewiseMarble;

				} else {

					int nextMarblePosition = currentMarblePosition + 2;

					if (nextMarblePosition > marbles.size()) {
						nextMarblePosition = nextMarblePosition - marbles.size();
					}

					marbles.add(nextMarblePosition, currentMarbleNumber);
					currentMarblePosition = nextMarblePosition;
				}

				currentMarbleNumber++;

				if (currentMarbleNumber > lastMarblePoints) {
					break;
				}

				//System.out.println(marbles.toString());
				System.out.println(currentMarbleNumber);
			}
		}
		
		int max = Integer.MIN_VALUE;
		for(int i = 0; i < playerScores.length; i++) {
				if(playerScores[i] > max) {
					max = playerScores[i];
				}
		}
		
		System.out.println(max);
	}
}