package Lab2;

public class FB {
    class FBPost{
        String author;
        String content;
        int numberOfLikes;
        int numberOfShares;
        int numberOfComments;
        int date;
    }

    public static void main(String[] args) {
        FB fb = new FB();

        FBPost post1 = fb.new FBPost();
        FBPost post2 = fb.new FBPost();
        FBPost post3 = fb.new FBPost();

        post1.author = "John Doe";
        post1.content = "Hello World!";
        post1.numberOfLikes = 12;
        post1.numberOfShares = 3;
        post1.numberOfComments = 0;
        post1.date = 1696303662;

        post2.author = "Jane Doe";
        post2.content = "Hi everyone.";
        post2.numberOfLikes = 38;
        post2.numberOfShares = 10;
        post2.numberOfComments = 2;
        post2.date = 1696303483;

        post3.author = "Bob Smith";
        post3.content = "Good morning!";
        post3.numberOfLikes = 192402;
        post3.numberOfShares = 20384;
        post3.numberOfComments = 2394;
        post3.date = 1696302890;

        FBPost[] postArray = new FBPost[3];
        postArray[0] = post1;
        postArray[1] = post2;
        postArray[2] = post3;
    }
}