import huffman_toolkit.*;

public class Test {
  private static void makeRandomFile(String src) {
    OutputTextFile outFile = new OutputTextFile(src);

    // 1kB file
    for (int i = 0; i < 1000; i++) {
      char c = (char) (Math.random() * 128);
      outFile.writeChar(c);
    }
    outFile.close();
  }

  private static void testNodeQueue() {
    NodeQueue nodeQueue = new NodeQueue();
    Node node5 = new Node(' ', 5);
    Node node10 = new Node(' ', 10);
    Node node15 = new Node(' ', 15);
    nodeQueue.add(node5);
    nodeQueue.add(node10);
    nodeQueue.add(node15);

    assert nodeQueue.peek().weight() == 5;
    assert nodeQueue.peek().weight() == 5;
    assert nodeQueue.size() == 3;

    Node n = nodeQueue.poll();
    assert nodeQueue.size() == 2;
    assert n.weight() == 5;
    assert nodeQueue.peek().weight() == 10;
  }

  public static void main(String[] args) {
    testNodeQueue();

    makeRandomFile("/tmp/huffman-rnd");

    Node root = Huffman.compress("/tmp/huffman-rnd", "/tmp/huffman-rnd-out");
    Huffman.decompress("/tmp/huffman-rnd-out", "/tmp/huffman-rnd");
  }
}
