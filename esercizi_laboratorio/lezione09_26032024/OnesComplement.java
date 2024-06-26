public class OnesComplement {
  public static String OnesComplement(String bin) {
    String res = "";
    for (int i = 0; i < bin.length(); i++) {
      char bit = bin.charAt(i);
      res += bit == '0' ? "1" : "0";
    }
    return res;
  }

  public static void main(String[] args) {
    assert (OnesComplement("0").equals("1"));
    assert (OnesComplement("01").equals("10"));
    assert (OnesComplement("1100").equals("0011"));
    assert (OnesComplement("010101").equals("101010"));
    assert (OnesComplement("1101100110").equals("0010011001"));
  }
}
