class TaskThread extends Thread {
    public TaskThread(String name) {
        super(name);
    }

    @Override
    public void run() {
        someTask();
    }

    private void someTask() {
        System.out.println("Task started " + Thread.currentThread().getName());
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("Task completed " + Thread.currentThread().getName());
    }
}

public class ThreadDemo3 {
    public static void main(String[] args) {
        System.out.println("Main program started.");
        Thread t1 = new TaskThread("Thread 1");
        t1.start();
        System.out.println("Main program ended.");
    }
}
