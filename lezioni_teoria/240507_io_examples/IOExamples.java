import huffman_toolkit.*;

public class IOExamples {
  // private static int copyFile(String src, String dst) {
  //   InputTextFile in = new InputTextFile(src);
  //   OutputTextFile out = new OutputTextFile(dst);
  //
  //   int count = 0;
  //   while (in.textAvailable()) {
  //     String line = in.readTextLine();
  //     out.writeTextLine(line);
  //     count++;
  //   }
  //
  //   in.close();
  //   out.close();
  //
  //   return count;
  // }

  // private static int copyFile(String src, String dst) {
  //   InputTextFile in = new InputTextFile(src);
  //   OutputTextFile out = new OutputTextFile(dst);
  //
  //   int count = 0;
  //   while (in.textAvailable()) {
  //     char c = in.readChar();
  //     out.writeChar(c);
  //     count++;
  //   }
  //
  //   in.close();
  //   out.close();
  //
  //   return count;
  // }

  // private static int copyFile(String src, String dst) {
  //   InputTextFile in = new InputTextFile(src);
  //   OutputTextFile out = new OutputTextFile(dst);
  //
  //   int count = 0;
  //   while (in.bitsAvailable()) {
  //     int bit = in.readBit();
  //     out.writeBit(bit);
  //     count++;
  //   }
  //
  //   in.close();
  //   out.close();
  //
  //   return count;
  // }

  private static int copyFile(String src, String dst) {
    InputTextFile in = new InputTextFile(src);
    OutputTextFile out = new OutputTextFile(dst);

    int count = 0;
    while (in.bitsAvailable()) {
      String bits = in.readCode(7);
      out.writeCode(bits);
      count++;
    }

    in.close();
    out.close();

    return count;
  }

  public static void main(String[] args) {
    int c = copyFile("IOExamples.java", "dst.txt");
    System.out.println("Count: " + c);
  }
}
