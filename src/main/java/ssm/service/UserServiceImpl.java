package ssm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ssm.dao.UserDAO;
import ssm.entity.User;

import java.util.List;

/**
 * create by tan on 2018-05-08
 * 用户操作业务逻辑层实现
 * */
@Service
public class UserServiceImpl implements UserService{
    // 注入dao
    @Autowired
    private UserDAO userDAO;

    @Override
    public List<User> getAllUser() {
        return userDAO.getAllUser();
    }

    @Override
    public User getUserById(int id) {
        return userDAO.getUserById(id);
    }

    @Override
    public User getUserByIdAndPwd(int id, String password) {
        return userDAO.getUserByIdAndPwd(id, password);
    }
}
