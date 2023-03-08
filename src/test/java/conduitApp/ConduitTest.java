package conduitApp;
import com.intuit.karate.junit5.Karate;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class ConduitTest {

    
    @Karate.Test
    Karate testAll(){
        return Karate.run().relativeTo(getClass());
    }

    //  @Karate.Test
    // Karate testTags(){
    //     return Karate.run().tags("@debug").relativeTo(getClass());
    // }

}

//mvn test -Dtest=ConduitTest#testTags   ==run specific test
//mvn test -Dkarate.options="--tags @debug" 
//mvn test -Dkarate.options="--tags ~@skipme" 
//mvn test -Dkarate.options="classpath:conduitApp/feature/HomePage.feature:7" 