/**
 * Board b = new Board();
 *
 * <p>b.size() : int
 *
 * <p>b.queensOn() : int
 *
 * <p>b.underAttack(i, j) : boolean
 *
 * <p>b.addQueen(i, j) : void
 *
 * <p>b.arrangement() : String
 */
public class Board {

  private static final String ROWS = " 123456789ABCDEF";
  private static final String COLS = " abcdefghijklmno";

  private final int size;
  private int queens;
  private String config;

  private int[] rowUnderAttack;
  private int[] colUnderAttack;
  private int[] dg1UnderAttack;
  private int[] dg2UnderAttack;

  public Board(int n) {
    this.size = n;
    this.queens = 0;

    this.rowUnderAttack = new int[n];
    this.colUnderAttack = new int[n];
    this.dg1UnderAttack = new int[2 * n - 1];
    this.dg2UnderAttack = new int[2 * n - 1];
    for (int i = 0; i < n; i++) {
      this.rowUnderAttack[i] = 0;
      this.colUnderAttack[i] = 0;
    }
    for (int i = 0; i < 2 * n - 1; i++) {
      this.dg1UnderAttack[i] = 0;
      this.dg2UnderAttack[i] = 0;
    }

    this.config = " ";
  }

  public int size() {
    return this.size;
  }

  public int queensOn() {
    return this.queens;
  }

  public boolean underAttack(int i, int j) {
    int n = this.size;
    return rowUnderAttack[i - 1] > 0
        || colUnderAttack[j - 1] > 0
        || dg1UnderAttack[i - j + n - 1] > 0
        || dg2UnderAttack[i + j - 2] > 0;
  }

  public void addQueen(int i, int j) {
    int n = this.size;
    rowUnderAttack[i - 1]++;
    colUnderAttack[j - 1]++;
    dg1UnderAttack[i - j + n - 1]++;
    dg2UnderAttack[i + j - 2]++;

    queens++;
    config += "" + COLS.charAt(j) + ROWS.charAt(i) + " ";
  }

  public void removeQueen(int i, int j) {
    int n = this.size;
    rowUnderAttack[i - 1]--;
    colUnderAttack[j - 1]--;
    dg1UnderAttack[i - j + n - 1]--;
    dg2UnderAttack[i + j - 2]--;

    queens--;

    String pair = "" + COLS.charAt(j) + ROWS.charAt(i);
    int k = config.indexOf(pair);
    config = config.substring(0, k) + config.substring(k + 3);
  }

  public String arrangement() {
    return this.config;
  }

  public String toString() {
    return "[" + this.arrangement() + "]";
  }
}
