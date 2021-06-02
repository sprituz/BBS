package reply;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import reply.Reply;

public class ReplyDAO {
	private Connection myConn;
	private ResultSet rs;
	
	public ReplyDAO(){
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
	
	public int getNext(){
		String SQL= "SELECT Reply FROM Reply ORDER BY ReplyID DESC";
		try{
			PreparedStatement pstmt = myConn.prepareStatement(SQL);
			rs= pstmt.executeQuery();
			if(rs.next()){
				return rs.getInt(1)+1;
			}
			return 1; //ù��° �Խù��� ����
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� �������� ����
	}
	
	public int insertReply(String ReplyText, String ID, int PostID){
		String SQL= "INSERT INTO Reply VALUES (sysdate, ?, ? , ? ,? )";
		try{
			PreparedStatement pstmt = myConn.prepareStatement(SQL);
			
			pstmt.setString(1, ReplyText);
			pstmt.setString(2, ID);
			pstmt.setInt(3, PostID);
			pstmt.setInt(4, getNext());
			return pstmt.executeUpdate();
			}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� �������� ����
	}
	
	public ArrayList<Reply> getList(int PostID){
		String SQL= "SELECT * FROM Reply Where PostID=? ORDER BY ReplyID DESC";
		ArrayList<Reply> list = new ArrayList<Reply>();
		try{
			PreparedStatement pstmt = myConn.prepareStatement(SQL);
			pstmt.setInt(1, PostID);
			rs= pstmt.executeQuery();
			
			while(rs.next()){
				Reply reply =new Reply();
				reply.setReplyDate(rs.getString(1));
				reply.setReplyText(rs.getString(2));
				reply.setID(rs.getString(3));
				reply.setPostID(rs.getInt(4));
				reply.setReplyID(rs.getInt(5));
				list.add(reply);
			}
			pstmt.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}



	public int deleteReply(int ReplyID){
		String SQL= "DELETE FROM REPLY WHERE REPLYID=?";
		try{
			PreparedStatement pstmt = myConn.prepareStatement(SQL);
			pstmt.setInt(1, ReplyID);
			return pstmt.executeUpdate();
			}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� �������� ����
	}
}
