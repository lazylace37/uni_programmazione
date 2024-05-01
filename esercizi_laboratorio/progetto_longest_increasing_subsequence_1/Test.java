public class Test {
  public static void main(String[] args) {
    assert LLIS.llis(new int[] {5, 4, 3, 2, 1}) == 1;
    assert LLIS.llis(new int[] {2, 7, 5, 7, 4}) == 3;
    assert LLIS.llis(new int[] {47, 38, 39, 25, 44}) == 3;
    assert LLIS.llis(new int[] {27, 90, 7, 29, 49, 8, 53, 1, 28, 6}) == 4;
    assert LLIS.llis(new int[] {9, 46, 54, 71, 60, 47, 1, 32, 25, 61}) == 5;
    assert LLIS.llis(new int[] {54, 52, 42, 33, 14, 40, 37, 61, 53, 1}) == 3;
    assert LLIS.llis(new int[] {10, 8, 9, 5, 6, 7, 1, 2, 3, 4}) == 4;
    assert LLIS.llis(new int[] {10, 11, 12, 6, 7, 8, 9, 1, 2, 3, 4, 5}) == 5;
    assert LLIS.llis(new int[] {7, 8, 9, 10, 4, 5, 6, 2, 3, 1}) == 4;
    assert LLIS.llis(new int[] {8, 9, 10, 11, 12, 4, 5, 6, 7, 1, 2, 3}) == 5;
    assert LLIS.llis(new int[] {6, 1, 7, 2, 8, 3, 9, 4, 10, 5}) == 5;
    assert LLIS.llis(new int[] {6, 1, 7, 2, 8, 3, 9, 4, 10, 5, 6}) == 6;

    assert LLIS.llisTopDown(new int[] {5, 4, 3, 2, 1}) == 1;
    assert LLIS.llisTopDown(new int[] {2, 7, 5, 7, 4}) == 3;
    assert LLIS.llisTopDown(new int[] {47, 38, 39, 25, 44}) == 3;
    assert LLIS.llisTopDown(new int[] {27, 90, 7, 29, 49, 8, 53, 1, 28, 6}) == 4;
    assert LLIS.llisTopDown(new int[] {9, 46, 54, 71, 60, 47, 1, 32, 25, 61}) == 5;
    assert LLIS.llisTopDown(new int[] {54, 52, 42, 33, 14, 40, 37, 61, 53, 1}) == 3;
    assert LLIS.llisTopDown(new int[] {10, 8, 9, 5, 6, 7, 1, 2, 3, 4}) == 4;
    assert LLIS.llisTopDown(new int[] {10, 11, 12, 6, 7, 8, 9, 1, 2, 3, 4, 5}) == 5;
    assert LLIS.llisTopDown(new int[] {7, 8, 9, 10, 4, 5, 6, 2, 3, 1}) == 4;
    assert LLIS.llisTopDown(new int[] {8, 9, 10, 11, 12, 4, 5, 6, 7, 1, 2, 3}) == 5;
    assert LLIS.llisTopDown(new int[] {6, 1, 7, 2, 8, 3, 9, 4, 10, 5}) == 5;
    assert LLIS.llisTopDown(new int[] {6, 1, 7, 2, 8, 3, 9, 4, 10, 5, 6}) == 6;
  }
}
