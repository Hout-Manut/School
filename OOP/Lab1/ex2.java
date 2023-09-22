package Lab1;

public class ex2 {

  public static void main(String[] args) {
    String lineBreak = "\\n", tabulation = "\\t", singleQuote =
      "\\\'", doubleQuote = "\\\"", slash = "\\\\", doubleSlash =
      "\\\\\\\\", lineComment = "//", blockComment = "/* ... */", textBlock =
      "\"\"\"\n\n\"\"\"";
    System.out.printf("%-30s %s\n", lineBreak, "Line Break.");
    System.out.printf("%-30s %s\n", tabulation, "Tabulation.");
    System.out.printf("%-30s %s\n", singleQuote, "Single Quote.");
    System.out.printf("%-30s %s\n", doubleQuote, "Double Quote");
    System.out.printf("%-30s %s\n", slash, "Slash.");
    System.out.printf("%-30s %s\n", doubleSlash, "Double Slash.");
    System.out.printf("%-30s %s\n", lineComment, "Line Comment.");
    System.out.printf("%-30s %s\n", blockComment, "blockComment.");
    System.out.printf("%-35s %s\n\n", textBlock, "Text Block.");
  }
}
