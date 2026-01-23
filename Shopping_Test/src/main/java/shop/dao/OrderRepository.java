package shop.dao;

import java.util.ArrayList;
import java.util.List;
import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
    
    public int insert(Order order) {
        int result = 0;
        String sql = "INSERT INTO `order` (ship_name, zip_code, country, address, date, order_pw, user_id, total_price, phone) VALUES (?,?,?,?,?,?,?,?,?)";
        
        try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, order.getShipName());
            psmt.setString(2, order.getZipCode());
            psmt.setString(3, order.getCountry());
            psmt.setString(4, order.getAddress());
            psmt.setString(5, order.getDate());
            psmt.setString(6, order.getOrderPw());
            psmt.setString(7, order.getUserId());
            psmt.setInt(8, order.getTotalPrice());
            psmt.setString(9, order.getPhone());
            
            result = psmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int lastOrderNo() {
        int no = 0;
        String sql = "SELECT MAX(order_no) FROM `order`";
        
        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery(sql);
            if (rs.next()) {
                no = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return no;
    }

    /**
     * [회원용] 주문 내역 조회
     */
    public List<Product> list(String userId) {
        List<Product> list = new ArrayList<>();
        
        String sql = "SELECT p.*, io.amount, io.order_no "
                   + "FROM product p JOIN product_io io ON p.product_id = io.product_id "
                   + "WHERE io.user_id = ? AND io.type = 'OUT' ORDER BY io.io_date DESC";
        
        try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, userId);
            rs = psmt.executeQuery();
            
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getString("product_id"));
                p.setName(rs.getString("name"));
                p.setUnitPrice(rs.getInt("unit_price"));
                p.setQuantity(rs.getInt("amount"));
                p.setOrderNo(rs.getInt("order_no"));
                list.add(p);
            }
        } catch (Exception e) {
        	System.err.println("주문 내역 조회 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
        return list;
    }

    /**
     * [비회원용] 주문 내역 조회
     */
    public List<Product> list(String phone, String orderPw) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, io.amount, io.order_no "
                   + "FROM product p JOIN product_io io ON p.product_id = io.product_id "
                   + "JOIN `order` o ON io.order_no = o.order_no "
                   + "WHERE o.phone = ? AND o.order_pw = ? AND io.type = 'OUT' ORDER BY io.io_date DESC";
        
        try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, phone);
            psmt.setString(2, orderPw);
            rs = psmt.executeQuery();
            
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getString("product_id"));
                p.setName(rs.getString("name"));
                p.setUnitPrice(rs.getInt("unit_price"));
                p.setQuantity(rs.getInt("amount"));
                p.setOrderNo(rs.getInt("order_no"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}