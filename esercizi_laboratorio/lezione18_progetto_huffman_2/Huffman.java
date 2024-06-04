import huffman_toolkit.*;

public class Huffman {
  // public static int[] chrFreq(String src) {
  //  InputTextFile in = new InputTextFile(src);
  //
  //  int[] freq = new int[InputTextFile.CHARS];
  //  for (int c = 0; c < freq.length; c++) freq[c] = 0;
  //
  //  while (in.bitsAvailable()) {
  //    char c = in.readChar();
  //    freq[c]++;
  //  }
  //
  //  in.close();
  //
  //  return freq;
  // }

  public static int[] statsChrFreq() {
    int[] freq = new int[InputTextFile.CHARS];
    int totalNumberOfChars = 100000;

    // Default
    for (int i = 0; i < freq.length; i++) {
      freq[i] = 1;
    }

    // Lettere minuscole
    freq[(int) 'a'] = (int) (8.167 * totalNumberOfChars / 100);
    freq[(int) 'b'] = (int) (1.492 * totalNumberOfChars / 100);
    freq[(int) 'c'] = (int) (2.782 * totalNumberOfChars / 100);
    freq[(int) 'd'] = (int) (4.253 * totalNumberOfChars / 100);
    freq[(int) 'e'] = (int) (12.702 * totalNumberOfChars / 100);
    freq[(int) 'f'] = (int) (2.228 * totalNumberOfChars / 100);
    freq[(int) 'g'] = (int) (2.015 * totalNumberOfChars / 100);
    freq[(int) 'h'] = (int) (6.094 * totalNumberOfChars / 100);
    freq[(int) 'i'] = (int) (6.966 * totalNumberOfChars / 100);
    freq[(int) 'j'] = (int) (0.153 * totalNumberOfChars / 100);
    freq[(int) 'k'] = (int) (0.772 * totalNumberOfChars / 100);
    freq[(int) 'l'] = (int) (4.025 * totalNumberOfChars / 100);
    freq[(int) 'm'] = (int) (2.406 * totalNumberOfChars / 100);
    freq[(int) 'n'] = (int) (6.749 * totalNumberOfChars / 100);
    freq[(int) 'o'] = (int) (7.507 * totalNumberOfChars / 100);
    freq[(int) 'p'] = (int) (1.929 * totalNumberOfChars / 100);
    freq[(int) 'q'] = (int) (0.095 * totalNumberOfChars / 100);
    freq[(int) 'r'] = (int) (5.987 * totalNumberOfChars / 100);
    freq[(int) 's'] = (int) (6.327 * totalNumberOfChars / 100);
    freq[(int) 't'] = (int) (9.056 * totalNumberOfChars / 100);
    freq[(int) 'u'] = (int) (2.758 * totalNumberOfChars / 100);
    freq[(int) 'v'] = (int) (0.978 * totalNumberOfChars / 100);
    freq[(int) 'w'] = (int) (2.361 * totalNumberOfChars / 100);
    freq[(int) 'x'] = (int) (0.150 * totalNumberOfChars / 100);
    freq[(int) 'y'] = (int) (1.974 * totalNumberOfChars / 100);
    freq[(int) 'z'] = (int) (0.074 * totalNumberOfChars / 100);

    // Maiuscole: 1 per frase, cioè 1 per 24.5*5.1 = 124.95 lettere.
    // Allora il 0.8% delle lettere sono maiuscole
    int totalNumberOfCharsUppercase = (int) (totalNumberOfChars * 0.8 / 100);
    freq[(int) 'A'] = (int) (8.167 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'B'] = (int) (1.492 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'C'] = (int) (2.782 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'D'] = (int) (4.253 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'E'] = (int) (12.702 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'F'] = (int) (2.228 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'G'] = (int) (2.015 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'H'] = (int) (6.094 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'I'] = (int) (6.966 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'J'] = (int) (0.153 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'K'] = (int) (0.772 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'L'] = (int) (4.025 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'M'] = (int) (2.406 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'N'] = (int) (6.749 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'O'] = (int) (7.507 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'P'] = (int) (1.929 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'Q'] = (int) (0.095 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'R'] = (int) (5.987 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'S'] = (int) (6.327 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'T'] = (int) (9.056 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'U'] = (int) (2.758 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'V'] = (int) (0.978 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'W'] = (int) (2.361 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'X'] = (int) (0.150 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'Y'] = (int) (1.974 * totalNumberOfCharsUppercase / 100);
    freq[(int) 'Z'] = (int) (0.074 * totalNumberOfCharsUppercase / 100);

    // Punti: 1 per frase, cioè 1 per 24.5*5.1 = 124.95 lettere.
    int punctuationSymbols = (int) (100000 / 124.95);
    freq[(int) '.'] = (int) punctuationSymbols;
    freq[(int) ','] = (int) (45 * punctuationSymbols / 100);
    freq[(int) '\''] = (int) (40 * punctuationSymbols / 100);
    freq[(int) ':'] = (int) (5 * punctuationSymbols / 100);
    freq[(int) ';'] = (int) (5 * punctuationSymbols / 100);
    freq[(int) '"'] = (int) (5 * punctuationSymbols / 100);

    // Spazi: 1 ogni 5.1 lettere
    freq[(int) ' '] = (int) (100000 / 5.1);

    return freq;
  }

  public static Node huffmanTree(int[] freq) {
    NodeQueue queue = new NodeQueue();
    for (int i = 0; i < freq.length; i++) {
      // if (freq[i] > 0) {
      Node n = new Node((char) i, freq[i]);
      queue.add(n);
      // }
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

  // private static String flatTree(Node n) {
  //  if (n.isLeaf()) {
  //    char c = n.symbol();
  //    if (c == '@' || c == '\\') return "\\" + c;
  //    return "" + n.symbol();
  //  } else {
  //    return "@" + flatTree(n.left()) + flatTree(n.right());
  //  }
  // }

  public static Node compress(String src, String dst) {
    InputTextFile in = new InputTextFile(src);
    int numberOfChars = 0;
    while (in.textAvailable()) {
      char c = in.readChar();
      numberOfChars++;
    }
    in.close();

    // int[] freq = chrFreq(src);
    int[] freq = statsChrFreq();
    Node tree = huffmanTree(freq);
    String[] tab = huffmanTable(tree);

    in = new InputTextFile(src);
    OutputTextFile out = new OutputTextFile(dst);

    out.writeTextLine("" + numberOfChars);
    // out.writeTextLine(flatTree(tree));

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

  // private static Node restoreTree(InputTextFile in) {
  //  char c = in.readChar();
  //  if (c == '@') {
  //    return new Node(restoreTree(in), restoreTree(in));
  //  } else {
  //    if (c == '\\') c = in.readChar();
  //    return new Node(c, 0);
  //  }
  // }

  public static void decompress(String src, String dst) {
    InputTextFile in = new InputTextFile(src);
    OutputTextFile out = new OutputTextFile(dst);

    int count = Integer.parseInt(in.readTextLine());

    int[] freq = statsChrFreq();
    Node root = huffmanTree(freq);

    // Node root = restoreTree(in);
    // in.readTextLine();

    for (int i = 0; i < count; i++) {
      char c = restoreChar(in, root);
      out.writeChar(c);
    }
    in.close();
    out.close();
  }
}
