import huffman_toolkit.*;

public class Test {
  public static void main(String[] args) {
    String text = args[0];
    Node root = Huffman.compress(text, text + ".huf");
    Huffman.decompress(text + ".huf", text + ".out");
  }
}
