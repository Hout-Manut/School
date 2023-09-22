package Lab1;

public class ex3 {

  public static void main(String[] args) {
    System.out.println("A:");
    for (int i = 0; i < 19; i += 2) {
      for (int j = 0; j < i / 2; j++) System.out.print(" ");
      for (int k = 19 - i; k > 0; k--) System.out.print("*");
      System.out.println();
    }
    System.out.println();
    // ======================================================
    System.out.println("B:");
    for (int i = 0; i < 20; i++) System.out.print("*");
    System.out.println();
    for (int i = 0; i < 10; i++) {
      System.out.print("*");
      for (int j = 0; j < 18; j++) System.out.print(" ");
      System.out.println("*");
    }
    for (int i = 0; i < 20; i++) System.out.print("*");
    System.out.println("\n");
    // ======================================================
    System.out.println("C:");
    for (int i = 1; i <= 5; i++) {
      for (int j = i; j <= i + 4; j++) System.out.print(j + " ");
      System.out.println();
    }
  }
}
