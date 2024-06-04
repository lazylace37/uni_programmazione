import puzzleboard.PuzzleBoard;

public class Test {
  private static void test() {
    Puzzle puzzle = new Puzzle(new int[] {1, 6, 2, 3, 13, 0, 7, 4, 8, 5, 11, 15, 14, 9, 10, 12});
    System.out.println(puzzle.config());

    boolean canMove = puzzle.canBeMoved(1);
    assert canMove == false;
    canMove = puzzle.canBeMoved(3);
    assert canMove == false;
    canMove = puzzle.canBeMoved(8);
    assert canMove == false;
    canMove = puzzle.canBeMoved(15);
    assert canMove == false;
    canMove = puzzle.canBeMoved(14);
    assert canMove == false;
    canMove = puzzle.canBeMoved(9);
    assert canMove == false;
    canMove = puzzle.canBeMoved(12);
    assert canMove == false;

    canMove = puzzle.canBeMoved(6);
    assert canMove == true;
    canMove = puzzle.canBeMoved(13);
    assert canMove == true;
    canMove = puzzle.canBeMoved(7);
    assert canMove == true;
    canMove = puzzle.canBeMoved(5);
    assert canMove == true;

    puzzle.move(5);
    System.out.println(puzzle.config());

    canMove = puzzle.canBeMoved(5);
    assert canMove == true;
    canMove = puzzle.canBeMoved(8);
    assert canMove == true;
    canMove = puzzle.canBeMoved(9);
    assert canMove == true;
    canMove = puzzle.canBeMoved(11);
    assert canMove == true;
  }

  public static void main(String[] args) {
    test();

    int n = 2;
    PuzzleBoard gui = new PuzzleBoard(n);
    Puzzle puzzle = new Puzzle(n);
    // Puzzle puzzle = new Puzzle(new int[] {1, 6, 2, 3, 13, 0, 7, 4, 8, 5, 11, 15, 14, 9, 10, 12});
    plotPuzzle(puzzle, gui);

    while (!puzzle.isOrdered()) {
      int k = gui.get();

      if (puzzle.canBeMoved(k)) {
        System.out.println("Move " + k);
        puzzle.move(k);
      } else {
        System.err.println("Cannot move " + k);
      }

      plotPuzzle(puzzle, gui);
    }
    System.out.println("Game over!");
  }

  private static void plotPuzzle(Puzzle puzzle, PuzzleBoard gui) {
    int[] arrangement = puzzle.getArrangement();
    int n = (int) Math.sqrt(arrangement.length);
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (arrangement[i * n + j] == 0) gui.clear(i + 1, j + 1);
        else gui.setNumber(i + 1, j + 1, arrangement[i * n + j]);
      }
    }
  }
}
