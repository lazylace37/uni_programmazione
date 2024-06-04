public class BottomUpLIS {

  // Length of Longest Increasing Subsequence (LLIS):
  // Programmazione dinamica bottom-up

  public static int llisDP(int[] s) {

    int n = s.length;

    int[][] mem = new int[n + 1][n + 1];

    // Matrice: valori delle ricorsioni di llisRec
    // relativi a diversi valori degli argomenti

    for (int j = 0; j <= n; j = j + 1) {

      // --------------------------------------------------
      //  Inserisci qui i comandi per registrare i valori
      //  corrispondenti ai casi base della ricorsione
      // --------------------------------------------------
      mem[n][j] = 0;
    }

    for (int i = n - 1; i >= 0; i = i - 1) {
      for (int j = 0; j <= n; j = j + 1) {

        // ------------------------------------------------
        //  Inserisci qui le strutture di controllo
        //  appropriate e i comandi per registrare
        //  i valori corrispondenti ai casi ricorsivi
        // ------------------------------------------------
        int t = j < n ? s[j] : 0;
        if (s[i] > t) {
          mem[i][j] = Math.max(1 + mem[i + 1][i], mem[i + 1][j]);
        } else {
          mem[i][j] = mem[i + 1][j];
        }
      }
    }

    // ----------------------------------------------------
    //  Inserisci di seguito l'elemento della matrice
    //  il cui valore corrisponde a llis(s) :

    return mem[0][n] /* elemento appropriato della matrice */;

    // ----------------------------------------------------
  }

  // Longest Increasing Subsequence (LIS):
  // Programmazione dinamica bottom-up

  public static int[] lisDP(int[] s) {

    int n = s.length;

    int[][] mem = new int[n + 1][n + 1];

    // 1. Matrice: valori delle ricorsioni di llisRec
    //    calcolati esattamente come per llisDP

    // ------------------------------------------------
    //  Replica qui il codice del corpo di llisDP
    //  che registra nella matrice i valori
    //  corrispondenti alle ricorsioni di llisRec
    // ------------------------------------------------
    for (int j = 0; j <= n; j = j + 1) {
      mem[n][j] = 0;
    }

    for (int i = n - 1; i >= 0; i = i - 1) {
      for (int j = 0; j <= n; j = j + 1) {
        int t = j < n ? s[j] : 0;
        if (s[i] > t) {
          mem[i][j] = Math.max(1 + mem[i + 1][i], mem[i + 1][j]);
        } else {
          mem[i][j] = mem[i + 1][j];
        }
      }
    }

    // 2. Cammino attraverso la matrice per ricostruire
    //    un esempio di Longest Increasing Subsequence

    // ----------------------------------------------------
    //  Inserisci di seguito l'elemento della matrice
    //  il cui valore corrisponde a llis(s) :

    int m = mem[0][n] /* elemento appropriato della matrice */;

    // ----------------------------------------------------

    int[] r = new int[m]; // per rappresentare una possibile LIS

    // ----------------------------------------------------
    //  Introduci e inizializza qui gli indici utili
    //  per seguire un cammino attraverso la matrice e
    //  per assegnare gli elementi della sottosequenza r
    // ----------------------------------------------------
    int rIdx = 0;
    int i = 0, j = n;
    while (mem[i][j] > 0) {

      int t = (j == n) ? 0 : s[j];
      // Nota Gioele: questo non mi serve per come ho impostato le cose,
      // perché sono un'iterazione indietro.
      // Cioè questo t è il prossimo elemento di s.
      // Il vantaggio è che s[i] != 0 sempre.

      // --------------------------------------------------
      //  Inserisci qui strutture di controllo e comandi
      //  per scegliere e seguire un percorso appropriato
      //  attraverso la matrice in modo da ricostruire in
      //  r una possibile LIS relativa alla sequenza s
      // --------------------------------------------------
      if (mem[i][j] > mem[i + 1][j]) {
        r[rIdx++] = s[i];
        j = i;
      } else {
        // proviene da destra
      }

      i++;
    }

    return r; // = LIS relativa alla sequenza s
  }
} // class BottomUpLIS
