package Lab1;

public class ex5 {
    private static boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' || c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U';
    }

    public static void main(String[] args) {
        String text = "I Love My Home Country";
        int textLength = text.length();
        System.out.println("A:");
        System.out.println("Original Text: " + text);
        System.out.println("Text length is: " + textLength + "\n");
        // =================================================
        System.out.println("B:");
        text = "I love my little country";
        String wordToRemove = "I love ";

        if (text.contains(wordToRemove)) {
            String newText = text.substring(0, text.indexOf(wordToRemove)) +
                    text.substring(text.indexOf(wordToRemove) + wordToRemove.length());

            System.out.println("Original Text: " + text);
            System.out.println("Text to remove: " + wordToRemove);
            System.out.println("Result: " + newText);
        } else {
            System.out.println("'" + wordToRemove + "' not found in the text.");
        }
        System.out.println("");
        // =================================================
        System.out.println("C:");
        text = "Hi Students!";

        System.out.println("Original Text: " + text);
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            if (isVowel(c)) {
                System.out.println("'" + c + "' is at index: " + i);
            }
        }
        //==================================================
        System.out.println("\nD:");
        String text1 = "Hi Students!";
        String text2 = "Students";
        String text3 = "Hi Students!";

        System.out.println("text1: " + text1);
        System.out.println("text2: " + text2);
        System.out.println("text3: " + text3 + "\n");
        System.out.println("text1 is equal to text2: " + text1.equals(text2));
        System.out.println("text1 is equal to text3: " + text1.equals(text3));
        //==================================================
        System.out.println("\nE:");
        text1 = "Hi Students!";
        text2 = "Students";
        text3 = "Teacher";

        System.out.println("text1: " + text1);
        System.out.println("text2: " + text2);
        System.out.println("text3: " + text3 + "\n");
        System.out.println("text1 contains text2: " + text1.contains(text2));
        System.out.println("text1 contains text3: " + text1.contains(text3));
    }
}