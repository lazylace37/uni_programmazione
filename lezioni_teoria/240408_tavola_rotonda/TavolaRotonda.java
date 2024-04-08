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
  private final IntSList lista1;
  private final IntSList lista2;

  public TavolaRotonda(int n) {
    this.quanti = n;
    this.brocca = 1;
    this.lista1 = intervallo(2, n);
    this.lista2 = IntSList.NULL_INTLIST;
  }

  private TavolaRotonda(int q, int b, IntSList l1, IntSList l2) {
    this.quanti = q;
    this.brocca = b;
    this.lista1 = l1;
    this.lista2 = l2;
  }

  public int quantiCavalieri() {
    return quanti;
  }

  public int chiHaLaBrocca() {
    return brocca;
  }

  public TavolaRotonda serve() {
    if (lista1.isNull()) {
      IntSList r = lista2.reverse();
      return new TavolaRotonda(quanti - 1, brocca, r.cdr(), IntSList.NULL_INTLIST);
    } else {
      return new TavolaRotonda(quanti - 1, brocca, lista1.cdr(), lista2);
    }
  }

  public TavolaRotonda passa() {
    if (quanti == 1) return this;
    else if (lista1.isNull()) {
      IntSList r = lista2.cons(brocca).reverse();
      return new TavolaRotonda(quanti, r.car(), r.cdr(), IntSList.NULL_INTLIST);
    } else {
      return new TavolaRotonda(quanti, lista1.car(), lista1.cdr(), lista2.cons(brocca));
    }
  }

  private static IntSList intervallo(int inf, int sup) {
    if (inf > sup) return new IntSList();
    return intervallo(inf + 1, sup).cons(inf);
  }
}
