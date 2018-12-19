 package myudfs;
 import java.io.IOException;
 import org.apache.pig.EvalFunc;
 import org.apache.pig.data.Tuple;

 public class ToFehrenheit 
 {
   public Float exec(Tuple input) throws IOException {
       if (input == null || input.size() == 0 || input.get(0) == null)
            return null;
        try{
           Float x = (Float)input.get(0) * 1.8 + 32;
           return x;
        }catch(Exception e){
            throw new IOException("Caught exception processing input row ", e);
        }
    }
  }