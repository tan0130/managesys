package ssm.test;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import ssm.controller.UserController;

/**
 * create by tan on 2018-05-08
 * UserController单元测试类
 * */
// 让测试运行于spring环境
@RunWith(SpringJUnit4ClassRunner.class)
// 加载数据库g配置
@ContextConfiguration({"classpath:/spring/springservlet-mvc.xml","classpath:/applicationContext.xml"})
public class UserControllerTest {
   // 注入UserController
    @Autowired
    private UserController userController;

    private MockMvc mockMvc;

    @Before
    public void setUp() {
        mockMvc = MockMvcBuilders.standaloneSetup(userController).build();
    }

     // 测试查找所有用户信息
    @Test
    public void Ctest() throws Exception {
        ResultActions resultActions = this.mockMvc.perform(MockMvcRequestBuilders.get("/user/getUserById?id=" + 80));
        MvcResult mvcResult = resultActions.andReturn();
        String result = mvcResult.getResponse().getContentAsString();
        System.out.println(".........客户端获得的数据位:" + result);

       // Assert.assertEquals("123", "124");
    }
}
