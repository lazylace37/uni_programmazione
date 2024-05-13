public class Test {
  public static void main(String[] args) {
    int[] res = Huffman.chrFreq("Test.java");
    Node tree = Huffman.huffmanTree(res);
    String[] r = Huffman.huffmanTable(tree);

    for (int i = 0; i < res.length; i++) {
      if (res[i] != 0) {
        System.out.println((char) i + "(" + i + ") " + res[i] + " " + r[i]);
      }
    }
  }
}
