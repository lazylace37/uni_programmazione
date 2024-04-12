public class RoundTable {
  private final int knights;
  private final int jug;
  private final IntSList l1;
  private final IntSList l2;

  // costruttore della disposizione iniziale con (int) n ≥ 2 cavalier
  public RoundTable(int n) {
    this.knights = n;
    this.jug = 1;
    this.l1 = intervallo(2, n);
    this.l2 = IntSList.NULL_INTLIST;
  }

  private RoundTable(int n, int jug, IntSList l1, IntSList l2) {
    this.knights = n;
    this.jug = jug;
    this.l1 = l1;
    this.l2 = l2;
  }

  // numero di cavalieri a tavola
  public int numberOfKnights() {
    return this.knights;
  }

  // coppia (lista di due elementi) di cavalieri che possono servire o servirsi
  public IntSList servingKnights() {
    return new IntSList(this.jug, new IntSList(this.l1.car(), IntSList.NULL_INTLIST));
  }

  // disposizione risultante dopo aver servito il prossimo cavaliere, che esce
  public RoundTable serveNeighbour() {
    // System.out.println(this.jug + " - " + this.l1 + this.l2);
    // System.out.println("\nserveNeighbour");
    if (this.l1.isNull()) {
      IntSList r = this.l2.reverse();
      return new RoundTable(
          this.numberOfKnights() - 1, this.jug, r.cdr().cdr().cons(r.car()), IntSList.NULL_INTLIST);
    } else if (this.l1.length() == 1) {
      IntSList r = this.l2.reverse().cons(this.l1.car());
      return new RoundTable(
          this.numberOfKnights() - 1, this.jug, r.cdr().cdr().cons(r.car()), IntSList.NULL_INTLIST);
    } else {
      return new RoundTable(
          this.numberOfKnights() - 1, this.jug, this.l1.cdr().cdr().cons(this.l1.car()), this.l2);
    }
  }

  // disposizione risultante dopo aver passato la brocca
  public RoundTable passJug() {
    // System.out.println(this.jug + " - " + this.l1 + this.l2);
    // System.out.println("\npassJug");
    if (this.numberOfKnights() == 2) return this;
    if (this.l1.length() == 1) {
      IntSList r = this.l2.reverse().cons(this.l1.car());
      return new RoundTable(
          this.numberOfKnights(),
          r.cdr().car(),
          r.cdr().cdr(),
          new IntSList().cons(this.jug).cons(this.l1.car()));
    } else {
      return new RoundTable(
          this.numberOfKnights(),
          this.l1.cdr().car(),
          this.l1.cdr().cdr(),
          this.l2.cons(this.jug).cons(this.l1.car()));
    }
  }

  private static IntSList intervallo(int inf, int sup) {
    if (inf > sup) return new IntSList();
    return intervallo(inf + 1, sup).cons(inf);
  }
}
