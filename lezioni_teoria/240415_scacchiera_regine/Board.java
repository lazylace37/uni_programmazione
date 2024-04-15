import java.util.function.*;

/**
 * Board b = new Board();
 *
 * <p>b.size() : int
 *
 * <p>b.queensOn() : int
 *
 * <p>b.underAttack(i, j) : boolean
 *
 * <p>b.addQueen(i, j) : Board
 *
 * <p>b.arrangement() : String
 */
public class Board {

  private static final String ROWS = " 123456789ABCDEF";
  private static final String COLS = " abcdefghijklmno";

  private final int size;
  private final int queens;
  private final BiPredicate<Integer, Integer> attack;
  private final String config;

  public Board(int n) {
    this.size = n;
    this.queens = 0;
    this.attack = (x, y) -> false; // (lambda (x y) false)
    this.config = " ";
  }

  private Board(Board b, int i, int j) {
    this.size = b.size();
    this.queens = b.queensOn() + 1;
    this.attack =
        (x, y) -> x == i || y == j || x - y == i - j || x + y == i + j || b.underAttack(x, y);
    this.config = b.arrangement() + COLS.charAt(j) + ROWS.charAt(i) + " ";
  }

  public int size() {
    return this.size;
  }

  public int queensOn() {
    return this.queens;
  }

  public boolean underAttack(int i, int j) {
    return attack.test(i, j); // (attack i j)
  }

  public Board addQueen(int i, int j) {
    return new Board(this, i, j);
  }

  public String arrangement() {
    return this.config;
  }

  public String toString() {
    return "[" + this.arrangement() + "]";
  }
}
