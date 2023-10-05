package Lab3;

public class Youtube {
    class User {
        String name;
        long subscriber;
        long totalView;
        long joinedDate;
        int uploadCount = 0;
        Video[] videoes = new Video[100];

        void addVideo(Video video) {
            videoes[uploadCount] = video;
            uploadCount++;
            totalView += video.viewCount;
        }

        void displayProfile() {
            System.out.println(name + "'s profile: ");
            System.out.println("Subscriber: " + subscriber);
            System.out.println("Total View: " + totalView);
            System.out.println("Joined Date: " + joinedDate);
            System.out.println();
        }

        void displayVideoes() {
            System.out.println("Uploaded videoes:\n");
            for (int i = 0; i < uploadCount; i++) {
                System.out.println("Title: " + videoes[i].title);
                System.out.println("Duration: " + videoes[i].duration);
                System.out.println("Like Count: " + videoes[i].likeCount);
                System.out.println("View Count: " + videoes[i].viewCount);
                System.out.println("Uploaded Date: " + videoes[i].uploadedDate);
                System.out.println();
            }
        }
    }

    class Video {
        String title;
        int duration;
        int likeCount;
        long viewCount;
        long uploadedDate;

    }

    public static void main(String[] args) {
        Youtube youtube = new Youtube();
        User user1 = youtube.new User();
        user1.name = "Miina";
        user1.subscriber = 435;
        user1.joinedDate = 2016;
        user1.totalView = 0;
        user1.uploadCount = 0;

        User user2 = youtube.new User();
        user2.name = "SnowieChii";
        user2.subscriber = 1190;
        user2.joinedDate = 2018;
        user2.totalView = 0;
        user2.uploadCount = 0;

        User user3 = youtube.new User();
        user3.name = "D-D-Dice Official";
        user3.subscriber = 111960;
        user3.joinedDate = 2014;
        user3.totalView = 0;
        user3.uploadCount = 0;

        Video video1 = youtube.new Video();
        video1.title = "Raven's Pride / Miina feat. Haramoriyoshina";
        video1.duration = 291;
        video1.likeCount = 965;
        video1.viewCount = 2739;
        video1.uploadedDate = 2023;

        Video video2 = youtube.new Video();
        video2.title = "??? first try + story";
        video2.duration = 328;
        video2.likeCount = 28;
        video2.viewCount = 523;
        video2.uploadedDate = 2023;

        Video video3 = youtube.new Video();
        video3.title = "Abstruse Dilemma / Ashrount vs. D-D-Dice";
        video3.duration = 161;
        video3.likeCount = 5238;
        video3.viewCount = 210434;
        video3.uploadedDate = 2023;

        Video video4 = youtube.new Video();
        video4.title = "World's end loneliness (full ver.) / D-D-Dice";
        video4.duration = 268;
        video4.likeCount = 2945;
        video4.viewCount = 182977;
        video4.uploadedDate = 2023;

        user1.addVideo(video1);
        user2.addVideo(video2);
        user3.addVideo(video3);
        user3.addVideo(video4);

        User[] userArr = new User[3];
        userArr[0] = user1;
        userArr[1] = user2;
        userArr[2] = user3;

        for (User user : userArr) {
            user.displayProfile();
            user.displayVideoes();
            System.out.println("=======================================\n");
        }
    }
}
