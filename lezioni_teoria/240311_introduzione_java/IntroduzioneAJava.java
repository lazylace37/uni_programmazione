/*
 * Traduzione in Java di semplici procedure ricorsive
 */
public class IntroduzioneAJava {
  public static double supTotCilindro(double r, double h) { // r, h > 0
    return 2 * Math.PI * r * (r + h);
  }

  public static String pluraleSf(String sf) {
    return sf.substring(0, sf.length() - 1) + "e";
  }

  public static String pluraleSm(String sm) {
    return sm.substring(0, sm.length() - 1) + "i";
  }

  public static boolean isFemminile(String s) {
    return s.charAt(s.length() - 1) == 'a';
  }

  public static String plurale(String s) {
    // if (isFemminile(s)) {
    //   return pluraleSf(s);
    // } else {
    //   return pluraleSm(s);
    // }

    return isFemminile(s) ? pluraleSf(s) : pluraleSm(s);
  }

  public static double lun(int k) {
    if (k >= 2) {
      return lun(k - 2) / 2;
    } else if (k == 0) {
      return S0;
    } else {
      return S1;
    }
  }

  public static final double S0 = Math.pow(2, 0.25); // Math.sqrt(Math.sqrt(2));
  public static final double S1 = Math.pow(2, -0.25); // 1 / S0

  public static int btrVal(String btr) {
    int k = btr.length() - 1;
    if (k == 0) {
      return btdVal(btr);
    } else {
      return (btrVal(btr.substring(0, k)) * 3) + (btdVal(btr.substring(k)));
    }
  }

  public static int btdVal(String btd) {
    if (btd.equals("-")) {
      return -1;
    } else if (btd.equals(".")) {
      return 0;
    } else {
      return 1;
    }

    // switch (btd) {
    //   case "-":
    //     return -1;
    //   case ".":
    //     return 0;
    //   case "+":
    //     return 1;
    //   default:
    //     return 0;
    // }
  }

  // public static String btrRep(int n) {
  //   int q = n / 3;
  //   int r = n % 3;
  //   if (Math.abs(n) <= 1) {
  //     return btdRep(r);
  //   }
  // }
}
