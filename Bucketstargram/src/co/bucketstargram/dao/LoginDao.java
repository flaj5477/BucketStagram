//package co.bucketstargram.dao;
//
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//
//import javax.naming.Context;
//import javax.naming.InitialContext;
//import javax.sql.DataSource;
//
//public class LoginDao {
//	private DataSource ds = null;
//	private Context context = null;
//	private Connection conn = null;
//	private PreparedStatement psmt = null;
//	private ResultSet rs = null;
//	
//	public LoginDao() {
//		// TODO Auto-generated constructor stub
//		try {
//			context = new InitialContext();
//			ds = (DataSource) context.lookup("java:comp/env/jdbc/Oracle11g");
//			conn = ds.getConnection();
//		} catch (Exception e) {
//			// TODO: handle exception
//			e.printStackTrace();
//		}
//	}
//	
//	public boolean select(String formID, String formPW) {
//		// TODO Auto-generated method stub
//		boolean loginSuccess = false;
//		//String sql = "SELECT * FROM border";//
//		String sql = "SELECT * FROM member_info_tb WHERE member_id = ?";
//		String dbID = null;
//		String dbPW = null;
//		
//		try {
//			psmt = conn.prepareStatement(sql);
//			psmt.setString(1, formID);
//			rs = psmt.executeQuery();
//			if (rs.next()) {
//				dbID = rs.getString("member_id");
//				dbPW = rs.getString("member_pw");
//			}
//
//			if ((dbID != null && dbID.equals(formID)) && (dbPW != null && dbPW.equals(formPW))) {
//				loginSuccess = true;
//				//update(formID, "login");
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}finally {
//			close();
//		}
//		//System.out.println("DAO | loginSuccess = " + loginSuccess);
//
//		return loginSuccess;
//	}
//	
//	private void close() {
//		// TODO Auto-generated method stub
//		try {
//			if(rs != null) rs.close();
//			if(psmt != null) psmt.close();
//			if(conn != null) conn.close();
//		} catch (SQLException e) {
//			// TODO: handle exception
//			e.printStackTrace();
//		}
//	}
//}
package co.bucketstargram.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDao {
    Connection conn = null; // DB연결된 상태(세션)을 담은 객체
    PreparedStatement psmt = null;  // SQL 문을 나타내는 객체
    ResultSet rs = null;  // 쿼리문을 날린것에 대한 반환값을 담을 객체
    
    public LoginDao() {
    	try {
            String user = "lee"; 
            String pw = "1234";
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            
            Class.forName("oracle.jdbc.driver.OracleDriver");        
            conn = DriverManager.getConnection(url, user, pw);
            
        } catch (ClassNotFoundException cnfe) {
            System.out.println("DB 드라이버 로딩 실패 :"+cnfe.toString());
        } catch (SQLException sqle) {
            System.out.println("DB 접속실패 : "+sqle.toString());
        } catch (Exception e) {
            System.out.println("Unkonwn error");
            e.printStackTrace();
        }
    }
    
	public boolean select(String formID, String formPW) {
		// TODO Auto-generated method stub
		boolean loginSuccess = false;
		String dbID = null;
		String dbPW = null;
		String sql = "SELECT * FROM member_info_tb WHERE member_id = ?";
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, formID);
			rs = psmt.executeQuery();
			if (rs.next()) {
				dbID = rs.getString("member_id");
				dbPW = rs.getString("member_pw");
			}

			if ((dbID != null && dbID.equals(formID)) && (dbPW != null && dbPW.equals(formPW))) {
				loginSuccess = true;
				//update(formID, "login");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		return loginSuccess;
	} 
    
	private void close() {
		// TODO Auto-generated method stub
		try {
			if(rs != null) rs.close();
			if(psmt != null) psmt.close();
			if(conn != null) conn.close();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
	
