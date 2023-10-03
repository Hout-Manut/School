package Lab2;

import java.util.Scanner;

public class ex7 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String sentence = new String();
        int vowelCount = 0, consonantCount = 0, spaceCount = 0;

        System.out.print("Enter a sentence: ");
        sentence = scanner.nextLine();
        
        for (int i = 0; i < sentence.length(); i++) {
            char letter = sentence.charAt(i);
            if (letter == 'a' || letter == 'e' || letter == 'i' || letter == 'o' || letter == 'u') {
                vowelCount++;
            } else if (letter == ' ') {
                spaceCount++;
            } else {
                consonantCount++;
            }
        }

        System.out.println("Count of vowels: " + vowelCount);
        System.out.println("Count of consonants: " + consonantCount);
        System.out.println("Count of spaces: " + spaceCount);

        scanner.close();
    }  
}
