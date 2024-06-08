import java.util.Arrays;
import java.util.Stack;

public class Test {
  // 2
  private static char longestContiguousRepeat(char[] arr) {
    char bestC = arr[0];
    int bestCount = 1;
    if (arr.length == 1) return bestC;

    char currentC = arr[0];
    int currentCount = 1;

    for (int i = 1; i < arr.length; i++) {
      if (arr[i] == currentC) {
        currentCount++;
      } else {
        if (currentCount > bestCount) {
          bestC = currentC;
          bestCount = currentCount;
        }

        currentC = arr[i];
        currentCount = 1;
      }

      if (currentCount > bestCount) {
        bestC = currentC;
        bestCount = currentCount;
      }
    }
    return bestC;
  }

  // 3
  public static int llisDP(double[] s) {
    int n = s.length;
    double[] v = s.clone();
    Arrays.sort(v);
    int[][] mem = new int[n + 1][n + 1];
    for (int k = 0; k <= n; k = k + 1) {
      mem[k][n] = 0;
      mem[n][k] = 0;
    }
    for (int i = n - 1; i >= 0; i--) {
      for (int j = n - 1; j >= 0; j--) {
        if (s[i] == v[j]) {
          mem[i][j] = 1 + mem[i + 1][j + 1];
        } else {
          mem[i][j] = Math.max(mem[i + 1][j], mem[i][j + 1]);
        }
      }
    }
    return mem[0][0];
  }

  // 4
  public static Board queensSolutionIter(int n) {
    Stack<Board> stack = new Stack<Board>();
    stack.push(new Board(n));
    do {
      Board b = stack.pop();
      n = b.size();
      int q = b.queensOn();
      if (q == n) {
        return b;
      } else {
        int i = q + 1;
        int j = 1 + (int) (n * Math.random());
        for (int k = 0; k < n; k++) {
          if (!b.underAttack(i, j)) {
            stack.push(b.addQueen(i, j));
          }
        }
      }
    } while (!stack.empty());
    return null;
  }

  public static void main(String[] args) {
    {
      char best =
          longestContiguousRepeat(
              new char[] {'a', 'b', 'b', 'a', 'a', 'b', 'c', 'c', 'c', 'c', 'b', 'b'});
      ; // 'c'
      System.out.println(best);
    }

    {
      int l = llisDP(new double[] {3, 4, 5, 6, 7, 1});
      System.out.println(l);
    }
  }
}
