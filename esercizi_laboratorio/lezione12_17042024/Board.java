public class Board {
  private static final String ROWS = " 123456789ABCDEF";
  private static final String COLS = " abcdefghijklmno";

  private final int size;
  private final int queens;
  private final IntSList rows;
  private final IntSList cols;
  private final IntSList diagonalInc;
  private final IntSList diagonalDec;
  private final String config;

  public Board(int n) {
    this.size = n;
    this.queens = 0;
    this.rows = IntSList.NULL_INTLIST;
    this.cols = IntSList.NULL_INTLIST;
    this.diagonalInc = IntSList.NULL_INTLIST;
    this.diagonalDec = IntSList.NULL_INTLIST;
    this.config = " ";
  }

  public Board(
      Board b,
      int i,
      int j,
      IntSList rows,
      IntSList cols,
      IntSList diagonalInc,
      IntSList diagonalDec) {
    this.size = b.size();
    this.queens = b.queensOn() + 1;
    this.rows = rows;
    this.cols = cols;
    this.diagonalInc = diagonalInc;
    this.diagonalDec = diagonalDec;
    this.config = b.arrangement() + COLS.charAt(j) + ROWS.charAt(i) + " ";
  }

  public int size() {
    return this.size;
  }

  public int queensOn() {
    return this.queens;
  }

  public boolean underAttack(int i, int j) {
    IntSList rows_ = this.rows;
    while (!rows_.isNull()) {
      if (rows_.car() == i) return true;
      rows_ = rows_.cdr();
    }

    IntSList cols_ = this.cols;
    while (!cols_.isNull()) {
      if (cols_.car() == j) return true;
      cols_ = cols_.cdr();
    }

    IntSList diagonalInc_ = this.diagonalInc;
    while (!diagonalInc_.isNull()) {
      if (diagonalInc_.car() == i - j) return true;
      diagonalInc_ = diagonalInc_.cdr();
    }

    IntSList diagonalDec_ = this.diagonalDec;
    while (!diagonalDec_.isNull()) {
      if (diagonalDec_.car() == i + j) return true;
      diagonalDec_ = diagonalDec_.cdr();
    }

    return false;
  }

  public Board addQueen(int i, int j) {
    return new Board(
        this,
        i,
        j,
        this.rows.cons(i),
        this.cols.cons(j),
        this.diagonalInc.cons(i - j),
        this.diagonalDec.cons(i + j));
  }

  public String arrangement() {
    return this.config;
  }

  public String toString() {
    return "[" + this.arrangement() + "]";
  }
}
