/**
 * Liste nello stile di Scheme
 *
 * <p>SList() // null
 *
 * <p>s.isNull() // (null? s)
 *
 * <p>s.car() // (car s)
 *
 * <p>s.cdr() // (cdr s)
 *
 * <p>s.cons(i) // (cons i s)
 */
public class SList<T> {
  private final boolean empty;
  private final T first;
  private final SList<T> rest;

  public SList() {
    empty = true;
    first = null;
    rest = null;
  }

  public SList(T e, SList<T> r) {
    empty = false;
    first = e;
    rest = r;
  }

  public boolean isNull() {
    return empty;
  }

  public T car() {
    return first;
  }

  public SList<T> cdr() {
    return rest;
  }

  public SList<T> cons(T e) {
    return new SList<T>(e, this);
  }

  public String toString() {
    if (isNull()) {
      return "()";
    } else {
      String lst = "(" + car();
      SList<T> r = cdr();
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

  public T listRef(int i) {
    if (i == 0) return car();
    return cdr().listRef(i - 1);
  }

  public boolean equals(SList<T> s) {
    if (isNull()) {
      return s.isNull();
    } else if (s.isNull()) {
      return false;
    } else if (car().equals(s.car())) {
      return cdr().equals(s.cdr());
    } else {
      return false;
    }
  }

  public SList<T> append(SList<T> s) {
    if (this.isNull()) return s;
    return this.cdr().append(s).cons(car());
  }

  public SList<T> reverse() {
    return this.reverseRec(new SList<T>());
  }

  private SList<T> reverseRec(SList<T> rev) {
    if (this.isNull()) return rev;
    return this.cdr().reverseRec(rev.cons(this.car()));
  }
}
