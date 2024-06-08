import java.util.Arrays;

public class Test {
  // 1
  private static char mostFrequentChar(char[] arr) {
    int[] freq = new int[128];
    for (int i = 0; i < arr.length; i++) {
      freq[(int) arr[i]] += 1;
    }

    int maxFreq = freq[0];
    char maxChar = (char) 0;
    for (int i = 1; i < freq.length; i++) {
      if (freq[i] > maxFreq) {
        maxFreq = freq[i];
        maxChar = (char) i;
      }
    }
    return maxChar;
  }

  // 2

  public static int llisMem(double[] s) {
    int n = s.length;
    double[] v = s.clone();
    Arrays.sort(v);
    int[][] mem = new int[n + 1][n + 1];
    for (int i = 0; i < mem.length; i++) {
      for (int j = 0; j < mem.length; j++) {
        mem[i][j] = UNKNOWN;
      }
    }
    return llcsRec(s, v, 0, 0, mem);
  }

  private static int llcsRec(double[] u, double[] v, int i, int j, int[][] mem) {
    if (mem[i][j] == UNKNOWN) {
      int n = u.length;
      if (i == n || j == n) {
        mem[i][j] = 0;
      } else if (u[i] == v[j]) {
        mem[i][j] = 1 + llcsRec(u, v, i + 1, j + 1, mem);
      } else {
        mem[i][j] = Math.max(llcsRec(u, v, i + 1, j, mem), llcsRec(u, v, i, j + 1, mem));
      }
    }
    return mem[i][j];
  }

  private static final int UNKNOWN = -1;

  // 3
  public static SList<Board> listOfSolutionsIter(int n) {
    Stack<Board> stack = new Stack<Board>();
    stack.push(new Board(n));
    SList<Board> solutions = NULL_BOARDLIST;
    do {
      Board b = stack.pop();
      n = b.size();
      int q = b.queensOn();
      if (q == n) {
        solutions.append(b);
      } else {
        int i = q + 1;
        for (int j = 1; j <= n; j++) {
          if (!b.underAttack(i, j)) stack.push(b.addQueen(i, j));
        }
      }
    } while (!stack.empty());
    return solutions;
  }

  // 4
  public int freeCol() {
    for (int i = 0; i < colAttacked.length; i++) {
      if (colAttacked[i] == 0) return i;
    }
    return -1;
  }

  public static void main(String[] args) {
    {
      char c =
          mostFrequentChar(
              new char[] {
                'a', 'b', 'c', 'b', 'c', 'a', 'a', 'd', 'c', 'd', 'c', 'e', 'f', 'f'
              }); // 'c'
      System.out.println(c);
    }

    {
      int l = llisMem(new double[] {3, 4, 5, 1});
      System.out.println(l);
    }
  }
}
