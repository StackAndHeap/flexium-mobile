import be.stackandheap.flexiummobile.FlexiumMobile;
import org.junit.*;
import org.junit.Test;
import org.junit.runners.MethodSorters;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class AirAppTest {
    private static FlexiumMobile flexiumMobile;

    @BeforeClass
    public static void setUp() throws Exception{
            flexiumMobile = new FlexiumMobile();
            flexiumMobile.setPause(500);
            flexiumMobile.start(4444);
    }

    @Test
    public void testA_Connection() throws Exception{
        Boolean succes = flexiumMobile.testSocketConnection();
        Assert.assertTrue("No app connected with the server",succes);
    }
    @Test
    public void testB_AddPost() throws Exception{
        flexiumMobile.setText("textInput","First Post");
        flexiumMobile.clickElement("button");
        Boolean succes = flexiumMobile.elementHasItem("list","First Post");
        Assert.assertTrue("Add Post failed, no such post in list",succes);
    }
    @Test
    public void testC_DetailViewPost() throws Exception{
        flexiumMobile.clickItemInElement("list","First Post");
        String title = flexiumMobile.getActiveViewTitle();
        Assert.assertEquals("Wrong title on Active window", "First Post", title);
    }

    @AfterClass
    public static void tearDown(){
        try{
            flexiumMobile.close();
        }catch (Exception e){
            System.out.println("closing server failed: "+e);
        }
    }
}
