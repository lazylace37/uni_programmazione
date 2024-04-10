public class StringSList {

  public static final StringSList NULL_STRINGLIST = new StringSList();

  private String first;
  private StringSList rest;

  public StringSList() {
    this.first = null;
    this.rest = null;
  }

  public StringSList(String e, StringSList sl) {
    this.first = e;
    this.rest = sl;
  }

  public boolean isNull() {
    return first == null;
  }

  public String car() {
    return first;
  }

  public StringSList cdr() {
    return rest;
  }

  public StringSList cons(String e) {
    return new StringSList(e, this);
  }

  public int length() {
    if (isNull()) return 0;
    return this.cdr().length() + 1;
  }

  public String listRef(int k) {
    if (k == 0) return this.car();
    return this.cdr().listRef(k - 1);
  }

  public boolean equals(StringSList sl) {
    if (this.length() != sl.length()) return false;
    if (this.car() != sl.car()) return false;
    return this.cdr().equals(sl.cdr());
  }

  public StringSList append(StringSList sl) {
    if (this.isNull()) return sl;
    return this.cdr().append(sl).cons(this.car());
  }

  public StringSList reverse() {
    return this.reverseRec(NULL_STRINGLIST);
  }

  private StringSList reverseRec(StringSList rev) {
    if (this.isNull()) return rev;
    return this.cdr().reverseRec(rev.cons(this.car()));
  }

  public String toString() {
    if (isNull()) {
      return "()";
    } else {
      String lst = "(" + this.car();
      StringSList r = this.cdr();
      while (!r.isNull()) {
        lst += " " + r.car();
        r = r.cdr();
      }
      return lst + ")";
    }
  }
}
