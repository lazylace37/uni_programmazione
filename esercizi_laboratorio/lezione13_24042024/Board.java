public class Board {
  private static final String ROWS = " 123456789ABCDEF";
  private static final String COLS = " abcdefghijklmno";

  private final int size;
  private final int queens;
  private final SList<SList<Integer>> coords;
  private final String config;

  public Board(int n) {
    this.size = n;
    this.queens = 0;
    this.coords = new SList<SList<Integer>>();
    this.config = " ";
  }

  public Board(Board b, int i, int j, SList<SList<Integer>> coords) {
    this.size = b.size();
    this.queens = b.queensOn() + 1;
    this.coords = coords;
    this.config = b.arrangement() + COLS.charAt(j) + ROWS.charAt(i) + " ";
  }

  public int size() {
    return this.size;
  }

  public int queensOn() {
    return this.queens;
  }

  public boolean underAttack(int i, int j) {
    SList<SList<Integer>> cell = this.coords;
    while (!cell.isNull()) {
      Integer x = cell.car().car();
      Integer y = cell.car().cdr().car();
      if (x == i || y == j || i - j == x - y || i + j == x + y) return true;
      cell = cell.cdr();
    }
    return false;
  }

  public Board addQueen(int i, int j) {
    SList<SList<Integer>> newList = this.coords.cons(new SList<Integer>(j, null).cons(i));
    return new Board(this, i, j, newList);
  }

  public String arrangement() {
    return this.config;
  }

  public String toString() {
    return "[" + this.arrangement() + "]";
  }
}
