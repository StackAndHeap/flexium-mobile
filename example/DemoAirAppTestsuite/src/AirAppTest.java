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
            flexiumMobile.setPause(500); //time between calls, optional
            flexiumMobile.start(4444);
    }

    @Test
    public void testA_Connection() throws Exception{
        Boolean succes = flexiumMobile.testSocketConnection();
        Assert.assertTrue("No app connected with the server",succes);
    }

    @Test
    public void testB_AddPost() throws Exception{
        flexiumMobile.tapElement("addPostButton");
        String title = flexiumMobile.getActiveViewTitle();
        Assert.assertEquals("Create Post view not opened", "Create Post", title);

        flexiumMobile.setText("titleInput","First Post");
        flexiumMobile.setText("contenTextArea","These are the contents of my first post");
        flexiumMobile.selectElement("publishToggleSwitch","true");
        flexiumMobile.clickElement("submitButton");

        Boolean succes = flexiumMobile.elementHasItem("list","First Post");
        Assert.assertTrue("Add Post failed, no such post in list",succes);
    }
    @Test
    public void testC_DetailViewPost() throws Exception{
        flexiumMobile.clickItemInElement("list","First Post");
        String title = flexiumMobile.getActiveViewTitle();
        flexiumMobile.clickElement("backButton");
        Assert.assertEquals("Wrong title on Active window", "First Post", title);

    }
    @Test
    public void testD_Gestures() throws Exception{
        flexiumMobile.tapElement("gestureButton");
        flexiumMobile.zoom("mySprite",3);
        flexiumMobile.rotate("mySprite",45);
        flexiumMobile.pan("mySprite","up");
        flexiumMobile.pan("mySprite","left");
        flexiumMobile.swipe("mySprite","down");
        flexiumMobile.swipe("mySprite","right");
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
