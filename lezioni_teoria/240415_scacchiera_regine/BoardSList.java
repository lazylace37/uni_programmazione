public class BoardSList {
  public static final BoardSList NULL_BOARDLIST = new BoardSList();

  private final boolean empty;
  private final Board first;
  private final BoardSList rest;

  public BoardSList() {
    empty = true;
    first = null;
    rest = null;
  }

  public BoardSList(Board e, BoardSList r) {
    empty = false;
    first = e;
    rest = r;
  }

  public boolean isNull() {
    return empty;
  }

  public Board car() {
    return first;
  }

  public BoardSList cdr() {
    return rest;
  }

  public BoardSList cons(Board e) {
    return new BoardSList(e, this);
  }

  public String toString() {
    if (isNull()) {
      return "()";
    } else {
      String lst = "(" + car();
      BoardSList r = cdr();
      while (!r.isNull()) {
        lst += " " + r.car();
        r = r.cdr();
      }
      return lst + ")";
    }
  }

  public int length() {
    if (isNull()) return 0;
    return 1 + cdr().length();
  }

  public Board listRef(int i) {
    if (i == 0) return car();
    return cdr().listRef(i - 1);
  }

  public boolean equals(BoardSList s) {
    if (isNull()) {
      return s.isNull();
    } else if (s.isNull()) {
      return false;
    } else if (car() == s.car()) {
      return cdr().equals(s.cdr());
    } else {
      return false;
    }
  }

  public BoardSList append(BoardSList s) {
    if (this.isNull()) return s;
    return this.cdr().append(s).cons(car());
  }

  public BoardSList reverse() {
    return this.reverseRec(NULL_BOARDLIST);
  }

  private BoardSList reverseRec(BoardSList rev) {
    if (this.isNull()) return rev;
    return this.cdr().reverseRec(rev.cons(this.car()));
  }
}
