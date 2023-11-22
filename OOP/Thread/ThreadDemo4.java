class MyRunnable implements Runnable {
    @Override
    public void run() {
        long startTime = System.currentTimeMillis() - ThreadDemo4.start;
        System.out.println(startTime + ": " +Thread.currentThread().getName() + " started.");
        try {
            Thread.sleep(4000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        long endTime = System.currentTimeMillis() - ThreadDemo4.start;
        System.out.println(endTime + ": " + Thread.currentThread().getName() + " ended.");
    }
}

public class ThreadDemo4 {
    public static long start = System.currentTimeMillis();

    public static void main(String[] args) {
        Thread t1 = new Thread(new MyRunnable(), "t1");
        Thread t2 = new Thread(new MyRunnable(), "t2");
        Thread t3 = new Thread(new MyRunnable(), "t3");

        System.out.println((System.currentTimeMillis() - start) +": Program started.");

        t1.start();

        try {
            t1.join(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        t2.start();

        try {
            t1.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        t3.start();

        try {
            t1.join();
            t2.join();
            t3.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        long elapseTime = System.currentTimeMillis() - start;
        System.out.println(elapseTime + ": All threads are done, exiting main thread.");
    }
}
