package ssm.entity;
/**
 * create by tan on 2018-05-08
 * 用户实体类
 * */
public class User {
    private  int id; // 用户编号
    private String nickName; // 用户昵称
    private String userName; // 用户名称
    private String password; // 用户密码
    private String sex; // 用户性别
    private String tel; // 用户电话
    private String email; // 用户邮箱
    private String mark; // 备注说明

    public User(int id, String nickName, String userName, String password, String sex, String tel, String email, String mark) {
        this.id = id;
        this.nickName = nickName;
        this.userName = userName;
        this.password = password;
        this.sex = sex;
        this.tel = tel;
        this.email = email;
        this.mark = mark;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", nickName='" + nickName + '\'' +
                ", userName='" + userName + '\'' +
                ", password='" + password + '\'' +
                ", sex='" + sex + '\'' +
                ", tel='" + tel + '\'' +
                ", email='" + email + '\'' +
                ", mark='" + mark + '\'' +
                '}';
    }
}
