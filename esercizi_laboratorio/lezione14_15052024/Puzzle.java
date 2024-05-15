import java.util.Random;

public class Puzzle {
  /**
   * 1..(n*n)-1 are the pieces
   *
   * <p>0 is the empty space
   */
  private int[] arrangement;

  /**
   * Construct a random puzzle of size n
   *
   * @param n Size of the puzzle
   */
  public Puzzle(int n) {
    this.arrangement = new int[n * n];
    for (int i = 0; i < this.arrangement.length; i++) this.arrangement[i] = i;
    shuffleArrangement(this.arrangement);
  }

  /**
   * Construct a puzzle from a arrangement
   *
   * @param seed The arrangement to setup the puzzle with
   */
  public Puzzle(int[] seed) {
    this.arrangement = seed;
  }

  /**
   * Get the current arrangement
   *
   * @return the arrangement
   */
  public int[] getArrangement() {
    return this.arrangement;
  }

  /**
   * @return true if the puzzle is ordered
   */
  public boolean isOrdered() {
    if (this.arrangement[this.arrangement.length - 1] != 0) return false;
    for (int i = 0; i < this.arrangement.length - 1; i++) {
      if (this.arrangement[i] != i + 1) return false;
    }
    return true;
  }

  /**
   * @param k The piece to move
   * @return true if k can be moved
   */
  public boolean canBeMoved(int k) {
    int indexOfSpace = -1;
    for (int i = 0; i < this.arrangement.length; i++) {
      if (this.arrangement[i] == 0) {
        indexOfSpace = i;
      }
    }

    int n = (int) Math.sqrt(this.arrangement.length);

    // Piece above of the space
    if (indexOfSpace >= n && this.arrangement[indexOfSpace - n] == k) return true;
    // Piece left of the space
    if (indexOfSpace % n > 0 && this.arrangement[indexOfSpace - 1] == k) return true;
    // Piece right of the space
    if (indexOfSpace % n < n - 1 && this.arrangement[indexOfSpace + 1] == k) return true;
    // Piece below of the space
    if (indexOfSpace <= this.arrangement.length - n && this.arrangement[indexOfSpace + n] == k)
      return true;

    return false;
  }

  /**
   * @param k The piece to move, assuming it can be moved
   */
  public void move(int k) {
    int indexOfSpace = -1, indexOfK = -1;
    for (int i = 0; i < this.arrangement.length; i++) {
      if (this.arrangement[i] == 0) {
        indexOfSpace = i;
      } else if (this.arrangement[i] == k) {
        indexOfK = i;
      }
    }

    this.arrangement[indexOfSpace] = k;
    this.arrangement[indexOfK] = 0;
  }

  /**
   * @return The current configuration
   */
  public String config() {
    int n = (int) Math.sqrt(this.arrangement.length);

    String config = "";
    for (int i = 0; i < this.arrangement.length; i++) {
      if (i % n == 0) config += "[";
      config += " " + this.arrangement[i];
      if (i % n == n - 1) config += " ]\n";
    }
    return config;
  }

  private static void shuffleArrangement(int[] arrangement) {
    Random random = new Random();
    for (int i = arrangement.length - 1; i > 0; i--) {
      int swapIndex = random.nextInt(i + 1);

      int tmp = arrangement[i];
      arrangement[i] = arrangement[swapIndex];
      arrangement[swapIndex] = tmp;
    }
  }
}
