import huffman_toolkit.*;

public class Huffman {
  public static int[] chrFreq(String src) {
    InputTextFile in = new InputTextFile(src);

    int[] freq = new int[InputTextFile.CHARS];
    for (int c = 0; c < freq.length; c++) freq[c] = 0;

    while (in.bitsAvailable()) {
      char c = in.readChar();
      freq[c]++;
    }

    in.close();

    return freq;
  }

  public static Node huffmanTree(int[] freq) {
    NodeQueue queue = new NodeQueue();
    for (int i = 0; i < freq.length; i++) {
      if (freq[i] > 0) {
        Node n = new Node((char) i, freq[i]);
        queue.add(n);
      }
    }

    while (queue.size() > 1) {
      Node l = queue.poll();
      Node r = queue.poll();

      Node n = new Node(l, r);
      queue.add(n);
    }
    return queue.poll();
  }

  public static String[] huffmanTable(Node root) {
    String[] tab = new String[InputTextFile.CHARS];
    Huffman.fillTable(root, "", tab);
    return tab;
  }

  private static void fillTable(Node n, String hc, String[] tab) {
    if (n.isLeaf()) {
      tab[n.symbol()] = hc;
    } else {
      fillTable(n.left(), hc + "0", tab);
      fillTable(n.right(), hc + "1", tab);
    }
  }

  private static String flatTree(Node n) {
    if (n.isLeaf()) {
      char c = n.symbol();
      if (c == '@' || c == '\\') return "\\" + c;
      return "" + n.symbol();
    } else {
      return "@" + flatTree(n.left()) + flatTree(n.right());
    }
  }

  public static Node compress(String src, String dst) {
    int[] freq = chrFreq(src);
    Node tree = huffmanTree(freq);
    String[] tab = huffmanTable(tree);

    InputTextFile in = new InputTextFile(src);
    OutputTextFile out = new OutputTextFile(dst);

    out.writeTextLine("" + tree.weight());
    out.writeTextLine(flatTree(tree));

    while (in.textAvailable()) {
      char c = in.readChar();
      out.writeCode(tab[c]);
    }
    in.close();
    out.close();

    return tree;
  }

  /* Decompression */

  private static char restoreChar(InputTextFile in, Node n) {
    do {
      int bit = in.readBit();
      if (bit == 0) n = n.left();
      else n = n.right();
    } while (!n.isLeaf());
    return n.symbol();
  }

  private static Node restoreTree(InputTextFile in) {
    char c = in.readChar();
    if (c == '@') {
      return new Node(restoreTree(in), restoreTree(in));
    } else {
      if (c == '\\') c = in.readChar();
      return new Node(c, 0);
    }
  }

  public static void decompress(String src, String dst) {
    InputTextFile in = new InputTextFile(src);
    OutputTextFile out = new OutputTextFile(dst);

    int count = Integer.parseInt(in.readTextLine());

    Node root = restoreTree(in);
    in.readTextLine();

    for (int i = 0; i < count; i++) {
      char c = restoreChar(in, root);
      out.writeChar(c);
    }
    in.close();
    out.close();
  }
}
