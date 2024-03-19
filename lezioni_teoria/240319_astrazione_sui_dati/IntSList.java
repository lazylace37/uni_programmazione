package AstrazioneSuiDati;
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
}
