package Midterm;

class a {
    public a(){
        System.out.println("a");
    }
}
class  b extends a{
    public b(){
        System.out.println("b");
    }
}
class c extends b{
    public c(){
        System.out.println("c");
    }
}
public class Class {
    public static void main(String[] args) {
        c obj = new c();
    
    }
}
