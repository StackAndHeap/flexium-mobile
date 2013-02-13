#Flexium Mobile

Flexium Mobile is a toolset for testing your Air Mobile apps.
This project has started as an extension for the Flexium project (https://github.com/gert789/flexium)
but we deceided it would be more clearly if we moved it to a new project.

This is very much a work-in-progress so please don't yell at me (yet)

##Contents:
* **DemoAirApp** - A very basic Air app, which we will use to run tests on	
* **DemoAirAppTestsuite** - An example of a testsuite (written in Java), which tests the DemoAirApp 
* **FlexiumMobileAirLib** - The source for FlexiumMobileAirLib.swc, which we include in the Air app
* **FlexiumMobileJavaLib** - The source for FlexiumMobileJavaLib.jar, which is included in the testsuite

## 
##How it works:
####1. Include the FlexiumMobileAirLib.swc in the Air app
* Copy the swc into a folder in your project (eg: 'libs') 
* Add `include-libraries libs/FlexiumMobileAirLib.swc` as a compiler option

####2. Include the FlexiumMobileJavaLib.jar in the Testsuite
* Copy the jar into a folder in your project (eg: 'libs')
* Add a depency to the jar 

####3. Write your first test
note: I used the jUnit test library [Download](https://github.com/junit-team/junit/wiki/Download-and-Install) but you can ofcourse use any other library
```
import be.stackandheap.flexiummobile.FlexiumMobile;
import org.junit.*;

public class AirAppTest {
    private static FlexiumMobile flexiumMobile;

    @BeforeClass
    public static void setUp() throws Exception{
            flexiumMobile = new FlexiumMobile();
            flexiumMobile.setPause(500);
            flexiumMobile.start(4444);
    }

    @Test
    public void testConnection() throws Exception{
        Boolean succes = flexiumMobile.testSocketConnection();
        Assert.assertTrue("No app connected with the server",succes);
    }
    
    @Test
    public void testAddPost() throws Exception{
        flexiumMobile.setText("textInput","First Post");
        flexiumMobile.clickElement("button");
        Boolean succes = flexiumMobile.elementHasItem("list","First Post");
        Assert.assertTrue("Add Post failed, no such post in list",succes);
    }

    @AfterClass
    public static void tearDown() throws Exception{
        flexiumMobile.close();
    }
}
```
