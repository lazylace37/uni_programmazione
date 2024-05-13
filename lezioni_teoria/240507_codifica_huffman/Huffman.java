import huffman_toolkit.*;
import java.util.*;

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
    PriorityQueue<Node> queue = new PriorityQueue<Node>();
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
}
