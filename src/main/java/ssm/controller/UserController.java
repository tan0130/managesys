package ssm.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import ssm.entity.User;
import ssm.service.UserService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * create by tan on 2018-05-08
 * 用户操作控制层
 * */
@Controller
@RequestMapping("/user")
public class UserController {
    private final String ADMIN_PAGE = "admin/";
    private final String PAGE_PATH = "pages/";

    @Autowired
    private UserService userService;

    // 查询所有用户信息
    @RequestMapping(value = "/getAllUser", method =RequestMethod.GET)
    @ResponseBody
    public String getAllUser() {
        try {
            List<User> userList = userService.getAllUser();
            Map<String, Object> jsonMap = new HashMap<String, Object>();
            jsonMap.put("rows", userList);
            jsonMap.put("total", userList.size());
            ObjectMapper mapper = new ObjectMapper();
            String json = mapper.writeValueAsString(jsonMap); // user对象转换成json类型的数据
            return json;
        } catch(Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 根据id查询用户信息
    @RequestMapping(value = "/getUserById", method = RequestMethod.GET)
    @ResponseBody
    public String getUserById(int id) {
        try {
            if(userService.getUserById(id) == null) {
                return "false";
            } else {
                return "true";
            }
        } catch(Exception e) {
            return "error";
        }
    }

    // 根据id和密码查询用户信息
    @RequestMapping(value = "/getUserByIdAndPwd", method = RequestMethod.GET)
    @ResponseBody
    public String getUserByIdAndPwd(int id, String password) {
        try {
            if(userService.getUserByIdAndPwd(id, password) == null) {
                return "false";
            } else {
                return "true";
            }
        } catch(Exception e) {
            return "error";
        }
    }

    // id和密码正确实现页面跳转
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {


        return "menu";
    }

    // 页面跳转 admin文件夹下
    @RequestMapping(value = "/toPage")
    public String toPage(String page) {
        return ADMIN_PAGE + page;
    }

    // 页面跳转 pages文件夹下
    @RequestMapping(value = "/toPage1")
    public String toPage1(String page) {
        return "/pages/password";
    }
}
