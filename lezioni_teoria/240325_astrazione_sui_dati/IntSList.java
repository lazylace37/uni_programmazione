/**
 * Liste di interi nello stile di Scheme
 *
 * IntSList()       // null
 * s.isNull()       // (null? s)
 * s.car()          // (car s)
 * s.cdr()          // (cdr s)
 * s.cons(i)        // (cons i s)
 */
public class IntSList {

  public static final IntSList NULL_INTLIST = new IntSList();

  private final boolean empty;
  private final int first;
  private final IntSList rest;

  public IntSList() {
    empty = true;
    first = 0;
    rest = null;
  }

  public IntSList(int e, IntSList r) {
    empty = false;
    first = e;
    rest = r;
  }

  public boolean isNull() {
    return empty;
  }

  public int car() {
    return first;
  }

  public IntSList cdr() {
    return rest;
  }

  public IntSList cons(int e) {
    return new IntSList(e, this);
  }

  public String toString() {
    if (isNull()) {
      return "()";
    } else {
      String lst = "(" + car();
      IntSList r = cdr();
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

  public int listRef(int i) {
    if (i == 0) return car();
    return cdr().listRef(i - 1);
  }

  public boolean equals(IntSList s) {
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

  public IntSList append(IntSList s) {
    if (this.isNull()) return s;
    return this.cdr().append(s).cons(car());
  }

  public IntSList reverse() {
    return this.reverseRec(NULL_INTLIST);
  }

  private IntSList reverseRec(IntSList rev) {
    if (this.isNull()) return rev;
    return this.cdr().reverseRec(rev.cons(this.car()));
  }
}
