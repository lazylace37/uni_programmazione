public class Test {
  public static void main(String[] args) {
    Node root = Huffman.compress("Test.java", "C.txt");
    Huffman.decompress("C.txt", "D.txt");
  }
}
