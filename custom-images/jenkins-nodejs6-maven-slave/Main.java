import java.util.concurrent.TimeUnit;
public class Main
{
     public static void main(String[] args) {
       try {
         while(true) {
            TimeUnit.SECONDS.sleep(1);  
            System.out.println("Hello, World");
         }
       } catch (Exception e) {
          
       }
       System.out.println("Hello, World");
    }
}
