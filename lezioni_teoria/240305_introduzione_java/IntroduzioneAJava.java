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
}
