package dal;

import model.Account;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import dal.SendMail;

public class AccountDAL extends DBContext {

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    public List<Account> getAllAccounts() {
        String sql = " select * from Accounts";
        List<Account> l = new ArrayList<>();
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account a = new Account(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7));
                l.add(a);
            }
            return l;
        } catch (Exception e) {
        }
        return null;
    }

    public Account getAccountByUsername(String username) {
        String xSql = "select * from Accounts where username=?";
        try {
            PreparedStatement ps = con.prepareStatement(xSql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account a = new Account(rs.getString("username"), rs.getString("password"), rs.getString("fullname"), rs.getString("email"), rs.getString("phone"), rs.getString("address"), rs.getInt("role"));
                ps.close();
                rs.close();
                return a;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Account getAccountByUsername2(String username) {
        String xSql = "select a.username,a.password,a.fullname,a.email,a.phone,a.address,a.role,round(SUM(b.total),2) as total \n"
                + "from Accounts a join Bills b on a.username=b.username where a.username=? "
                + "group by a.username,a.password,a.fullname,a.email,a.phone,a.address,a.role";
        try {
            PreparedStatement ps = con.prepareStatement(xSql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account a = new Account(rs.getString("username"), rs.getString("password"), rs.getString("fullname"), rs.getString("email"), rs.getString("phone"), rs.getString("address"), rs.getInt("role"), rs.getDouble("total"));
                ps.close();
                rs.close();
                return a;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Account checkAccount(String user, String pass) {

        String xSql = "select * from Accounts where username=? AND password=?";
        try {
            PreparedStatement ps = con.prepareStatement(xSql);
            ps.setString(1, user);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account a = new Account(rs.getString("username"), rs.getString("password"), rs.getString("fullname"), rs.getString("email"), rs.getString("phone"), rs.getString("address"), rs.getInt("role"));
                ps.close();
                rs.close();
                return a;
            }
            ps.close();
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean checkAccount2(String user) {

        String xSql = "select * from Accounts where username=? ";
        try {
            PreparedStatement ps = con.prepareStatement(xSql);
            ps.setString(1, user);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ps.close();
                rs.close();
                return true;
            }
            ps.close();
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addAccount(String username, String password, String fullname, String email, String phone, String address) {
        String xSql = "insert into Accounts(username, password, fullname, email, phone, address, role) values (?, ?, ?, ?, ?, ?, 2)";
        try {
            PreparedStatement ps = con.prepareStatement(xSql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, fullname);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setString(6, address);
            ps.executeUpdate();
            ps.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static String generateRandomString(int length) {
        Random random = new Random();
        StringBuilder stringBuilder = new StringBuilder();

        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(CHARACTERS.length());
            char randomChar = CHARACTERS.charAt(randomIndex);
            stringBuilder.append(randomChar);
        }

        return stringBuilder.toString();
    }

    public String signup1(String username, String password, String fullname, String email, String phone, String address) {
        String sql = "insert into Accounts(username, password, fullname, email, phone, address, role, active) VALUES (?, ?, ?, ?, ?, ?, 2, 0)";
        String key = generateRandomString(10);
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, fullname);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setString(6, address);
            ps.executeUpdate();
            SendMail.send(email, "Hello " + username, "<h2>Welcome to my website</h2>" + "<a href = \"http://localhost:9999/Project_ban_sach_Phucdvhe170157/verifyAccount?email=" + email + "&key=" + key + "\">Click here to verify your account</a>");
            //<a href = /"http://localhost:9999/Assignment_Prj301_HotelSearch/verifyaccount?email=" + email + "&key=" + key + " \">Click here to verify your account</a>");
            return key;
        } catch (Exception e) {
            // Xử lý ngoại lệ
            return null;
        }
    }

    public boolean updateAccount(String email) {
        String sql = "UPDATE users SET [active] = 1 WHERE email = +?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            // Xử lý ngoại lệ
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateAccount(String username, String email, String phone, String address, String newpass) {
        String xSql = "update Accounts set password=?, email=?, phone=?, [address]=? where username=?";
        try {
            PreparedStatement ps = con.prepareStatement(xSql);
            ps.setString(1, newpass);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setString(5, username);
            ps.executeUpdate();
            ps.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updatePassword(String username, String password) {
        String xsql = "update Accounts set password= ? where username = ?";
        try {
            PreparedStatement ps = con.prepareStatement(xsql);
            ps.setString(1, password);
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public int getRoleByUser(String username, String password) {
        String xSql = "select role from Accounts where username=? AND password=?";
        try {
            PreparedStatement ps = con.prepareStatement(xSql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int a = rs.getInt("role");
                return a;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 2;
    }

    public void deleteAccountByUserName(String username) {
        String sql = "delete from Accounts where username = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        AccountDAL dao = new AccountDAL();
//        Account a = dao.getAccountByUsername2("user1");
//        System.out.println(a.getTotal());
//        System.out.println(dao.checkAccount("admin", "123"));
//        List<Account> a = dao.getAllAccounts();
//        for (Account account : a) {
//            System.out.println(account.getRole());
//        }
        //System.out.println(dao.signup1("vinhphuc2", "phuc2003", "phuc", "phucdvhe170157@fpt.edu.vn", "0829787976", "ha noi"));
        dao.deleteAccountByUserName("vinhphuc2");

    }
}
