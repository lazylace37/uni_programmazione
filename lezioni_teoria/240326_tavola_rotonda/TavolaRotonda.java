/**
 * TavolaRotonda: con i commensali presenti,
 * di cui uno ha con se una brocca di sidro.
 *
 *  TavolaRotonda tr = new TavolaRotonda(n);
 *
 *  tr.quantiCavalieri() : int
 *
 *  tr.chiHaLaBrocca() : int
 *
 *  tr.serve() : TavolaRotonda
 *
 *  tr.passa() : TavolaRotonda
 */
public class TavolaRotonda {
  
  private final int quanti;
  private final int brocca;
  private final IntSList altri;

  public TavolaRotonda(int n) {
    this.quanti = n;
    this.brocca = 1;
    this.altri = intervallo(2, n);
  }

  private TavolaRotonda(int q, int b, IntSList a) {
    this.quanti = q;
    this.brocca = b;
    this.altri = a;
  }

  public int quantiCavalieri() {
    return quanti;
  }

  public int chiHaLaBrocca() {
    return brocca;
  }

  public TavolaRotonda serve() {
    return new TavolaRotonda(quanti - 1, brocca, altri.cdr());
  }

  public TavolaRotonda passa() {
    if (altri.isNull()) return this;
    IntSList coda = IntSList.NULL_INTLIST.cons(brocca);
    IntSList nuova = altri.cdr().append(coda);
    return new TavolaRotonda(quanti, altri.car(), nuova);
  }

  private static IntSList intervallo(int inf, int sup) {
    if (inf > sup) return new IntSList();
    return intervallo(inf + 1, sup).cons(inf);
  }
}
