/*
 * Modulo Josephus:
 *
 * Programma per risolvere il problema ispirato da Giuseppe Flavio
 * nella rielaborazione di Donald Knuth (metodo statico)
 *
 * Ultimo aggiornamento: 25/03/2021
 */
public class Test {
  public static IntSList josephus(int n) {
    RoundTable rt = new RoundTable(n); // configurazione iniziale

    while (rt.numberOfKnights() > 2) { // finche' c'e' piu' di un commensale a tavola
      RoundTable ext = rt.serveNeighbour(); // un commensale viene servito ed esce
      rt = ext.passJug(); // la brocca viene passata di mano
    }
    return rt.servingKnights(); // alla fine rimane un cavaliere con la brocca
  }

  public static void main(String args[]) {
    // int n = Integer.parseInt(args[0]);
    // for (int k = 1; k <= n; k = k + 1) {
    //   System.out.println(josephus(k));
    // }

    System.out.println("Josephus 2: " + josephus(2)); // (1, 2)
    System.out.println("Josephus 3: " + josephus(3)); // (1, 2)
    System.out.println("Josephus 4: " + josephus(4)); // (4, 1)
    System.out.println("Josephus 5: " + josephus(5)); // (2, 4)
    System.out.println("Josephus 6: " + josephus(6)); // (5, 1)
    System.out.println("Josephus 7: " + josephus(7)); // (1, 4)
    System.out.println("Josephus 8: " + josephus(8)); // (4, 7)
    System.out.println("Josephus 12: " + josephus(12)); // (5, 10)
    System.out.println("Josephus 1500: " + josephus(1500)); // (338, 905)
  }
} // class Josephus
