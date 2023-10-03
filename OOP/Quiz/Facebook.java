public class Facebook {

    class FacebookPost {
        int id;
        String authorName;
        String content;
        double date;
        int numberOfLike, numberOfShare;
    }

    static void printPost(FacebookPost[] postArray) {
        for (FacebookPost post : postArray) {
            System.out.println(post.authorName);
            System.out.println(post.id);
            System.out.println(post.date);
            System.out.println(post.content);
            System.out.println("Like:" + post.numberOfLike);
            System.out.println("Share:" + post.numberOfShare);
            System.out.println();
        }
    }

    public static void main(String[] args) {
        Facebook obj = new Facebook();
        FacebookPost post1 = obj.new FacebookPost();
        FacebookPost post2 = obj.new FacebookPost();
        FacebookPost post3 = obj.new FacebookPost();

        post1.id = 8748392;
        post1.authorName = "Hout Manut";
        post1.content = "Hello World!";
        post1.date = 1696303662;
        post1.numberOfLike = 12;
        post1.numberOfShare = 3;

        post2.id = 8748393;
        post2.authorName = "Harut";
        post2.content = "Hi everyone.";
        post2.date = 1696303483;
        post2.numberOfLike = 38;
        post2.numberOfShare = 10;

        post3.id = 8748394;
        post3.authorName = "Marut";
        post3.content = "Good morning";
        post3.date = 1696302890;
        post3.numberOfLike = 192402;
        post3.numberOfShare = 20384;

        FacebookPost[] postArray = new FacebookPost[3];
        postArray[0] = post1;
        postArray[1] = post2;
        postArray[2] = post3;

        printPost(postArray);
    }
}