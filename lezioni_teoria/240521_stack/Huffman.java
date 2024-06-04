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
    Stack<Coppia> stack = new Stack<Coppia>();
    stack.push(new Coppia(root, ""));

    String[] tab = new String[InputTextFile.CHARS];
    while (!stack.isEmpty()) {
      Coppia c = stack.pop();
      Node n = c.node;
      String path = c.path;

      if (n.isLeaf()) {
        tab[n.symbol()] = path;
      } else {
        stack.push(new Coppia(n.left(), path + "0"));
        stack.push(new Coppia(n.right(), path + "1"));
      }
    }
    return tab;
  }

  private static String flatTree(Node root) {
    Stack<Node> stack = new Stack<Node>();
    stack.push(root);

    String solution = "";

    while (!stack.isEmpty()) {
      Node node = stack.pop();
      if (node.isLeaf()) {
        char c = node.symbol();
        if (c == '@' || c == '\\') solution += "\\" + c;
        solution += "" + node.symbol();
      } else {
        solution += "@";
        stack.push(node.right());
        stack.push(node.left());
      }
    }
    return solution;
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
    Stack<Frame> stack = new Stack<Frame>();
    stack.push(new Frame());

    Node n = null;

    while (!stack.isEmpty()) {
      Frame f = stack.peek();
      if (f.getState() == 0) {
        char c = in.readChar();
        if (c == '@') {
          f.setState(1);
          stack.push(new Frame());
        } else {
          if (c == '\\') c = in.readChar();
          n = new Node(c, 0);
          stack.pop();
        }
      } else if (f.getState() == 1) {
        f.setLeft(n);
        stack.push(new Frame());
        f.setState(2);
      } else {
        f.setRight(n);
        n = new Node(f.getLeft(), f.getRight());
        stack.pop();
      }
    }

    return n;
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
