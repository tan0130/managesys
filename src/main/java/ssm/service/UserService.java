package ssm.service;

import ssm.entity.User;

import java.util.List;

/**
 * create by tan on 2018-05-08
 *用户操作业务逻辑层接口
 * */
public interface UserService {
    public List<User> getAllUser(); // 查询所有用户信息
    public User getUserById(int id); // 根据id查询用户信息
    public User getUserByIdAndPwd(int id, String password); // 根据id和密码查询用户信息
}
