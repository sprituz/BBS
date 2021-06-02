package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection myConn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO(){
		try{
			String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
			String user="ST2018112017"; // ���� ���̵�(ex.ST0000000000)
			String passwd="ST2018112017"; // ���� �н�����(ex.ST0000000000)
			String dbdriver = "oracle.jdbc.driver.OracleDriver";
			Class.forName(dbdriver);
			myConn = DriverManager.getConnection (dburl, user, passwd);
		} catch(Exception e){
			e.printStackTrace();
		}
		}
		
	public int login(String id, String password){
		String SQL = "select Password from user_info where ID = ?";
		try{
			pstmt=myConn.prepareStatement(SQL);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()){
				if(rs.getString(1).equals(password)){
					return 1; //�α��� ������ ���
				}
				else
					return 0; // ��й�ȣ ���� �ʴ� ���
			}
			return -1; //���̵� ���� ���
		}catch(Exception e){
			e.printStackTrace();
		}
		return -2; //�����������
	}
	public int join(User user){
		String SQL="INSERT INTO USER_INFO VALUES (? , ?, ? , ? ,?)";
		try{
			pstmt=myConn.prepareStatement(SQL);
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getEmail());
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� �������� ���
	}
}
