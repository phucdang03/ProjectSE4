package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Object;
import model.Bill;

public class BillDAL extends DBContext {

    public List<Bill> getAllbills() {
        String sql = " select b.bid,b.username,b.date,p.name,b.amount,round(b.total,2) as total from Bills b join Products p on b.pid=p.pid";
        List<Bill> l = new ArrayList<>();
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bill b = new Bill(rs.getString(1), rs.getString(2), rs.getDate(3), rs.getString(4), rs.getInt(5), rs.getDouble(6));
                l.add(b);
            }
            return l;
        } catch (Exception e) {
        }
        return null;
    }

    public List<Bill> getTop3BestSeller() {
        String xSql = "select top 3 pid,sum(b.amount) countAmount\n"
                + "from Bills b\n"
                + "group by pid\n"
                + "order by countAmount desc ";
        List<Bill> lsBill = new ArrayList<Bill>();
        try {
            PreparedStatement ps = con.prepareStatement(xSql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setPid(rs.getString("pid"));
                bill.setAmount(rs.getInt("countAmount"));
                lsBill.add(bill);
            }
            return lsBill;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Bill> getTop10Username() {
        String xSql = "select top 10 username, round(sum(b.total),2) total\n"
                + "from Bills b \n"
                + "group by username\n"
                + "order by total desc";
        List<Bill> lsBill = new ArrayList<Bill>();
        try {
            PreparedStatement ps = con.prepareStatement(xSql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setUsername(rs.getString("username"));
                bill.setTotal(rs.getFloat("total"));
                lsBill.add(bill);
            }
            return lsBill;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public double revenue() {
        String sql = "select round(SUM(total),2) as total from Bills";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                double revenue = rs.getDouble(1);
                return revenue;
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public List<Object> trend() {
        List<Object> l = new ArrayList<>();
        String sql = "select c.name,coalesce(round((sum(total)),2),0),COALESCE(COUNT(b.pid), 0)"
                + "from Products p left join Bills b  on b.pid=p.pid left join Categories c on p.catid=c.catid "
                + "group by c.name";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String name = rs.getString(1);
                double total = rs.getDouble(2);
                int count = rs.getInt(3);
                Object o = new Object(name, total, count);
                l.add(o);
            }
            return l;
        } catch (Exception e) {
        }
        return null;
    }

    public static void main(String[] args) {
        BillDAL dal = new BillDAL();
//        List<Bill> list = dal.getTop10Username();
//        double revenue = dal.revenue();
//        System.out.println(revenue);
//        List<Object> l = dal.trend();
//        for (Object o : l) {
//            System.out.println(o.getName() + " " + o.getTotal() + " " + o.getQuantity());
//        }
        List<Bill> l = dal.getAllbills();
        for (Bill bill : l) {
            System.out.println(bill.getName());
        }
    }
}
