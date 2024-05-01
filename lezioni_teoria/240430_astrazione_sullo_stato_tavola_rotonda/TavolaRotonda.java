/**
 * TavolaRotonda: con i commensali presenti, di cui uno ha con se una brocca di sidro.
 *
 * <p>TavolaRotonda tr = new TavolaRotonda(n);
 *
 * <p>tr.quantiCavalieri() : int
 *
 * <p>tr.chiHaLaBrocca() : int
 *
 * <p>tr.serve() : void
 *
 * <p>tr.passa() : void
 */
public class TavolaRotonda {

  private int quanti;
  private int[] cavalieri;
  private int brocca;

  public TavolaRotonda(int n) {
    this.quanti = n;
    this.brocca = 0;
    this.cavalieri = new int[2 * n - 1];
    for (int i = 1; i <= n; i++) {
      cavalieri[i - 1] = i;
    }
  }

  public int quantiCavalieri() {
    return quanti;
  }

  public int chiHaLaBrocca() {
    return cavalieri[brocca];
  }

  public void serve() {
    if (quanti > 1) {
      cavalieri[brocca + 1] = cavalieri[brocca];
      brocca = brocca + 1;
      quanti--;
    }
  }

  public void passa() {
    if (quanti > 1) {
      cavalieri[brocca + quanti] = cavalieri[brocca];
      brocca = brocca + 1;
    }
  }
}
