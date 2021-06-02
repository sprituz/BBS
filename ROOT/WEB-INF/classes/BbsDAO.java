package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection myConn;
	private ResultSet rs;

	public BbsDAO(){
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
		String SQL= "SELECT PostID FROM POST ORDER BY PostID DESC";
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

	public int write(String Title, String ID, String Content){
		String SQL= "INSERT INTO POST VALUES (?, ? , sysdate , ? ,? , ?)";
		try{
			PreparedStatement pstmt = myConn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, Title);
			pstmt.setString(3, Content);
			pstmt.setInt(4, 1);
			pstmt.setString(5, ID);
			return pstmt.executeUpdate();
			}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� �������� ����
	}

	public ArrayList<Bbs> getList(int pageNumber){
		String SQL= "SELECT * FROM (SELECT * FROM POST WHERE PostID<? AND Available=1) WHERE ROWNUM<10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try{
			PreparedStatement pstmt = myConn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1)* 10);
			rs= pstmt.executeQuery();
			while(rs.next()){
				Bbs bbs =new Bbs();
				bbs.setPostID(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setPostDate(rs.getString(3));
				bbs.setContent(rs.getString(4));
				bbs.setAvailable(rs.getString(5));
				bbs.setID(rs.getString(6));
				list.add(bbs);
			}
			pstmt.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}

	public boolean nextPage(int pageNumber){
		String SQL= "SELECT * FROM (SELECT * FROM POST WHERE PostID<? AND Available=1) where rownum <= 10";
		try{
			PreparedStatement pstmt = myConn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1)* 10);
			rs= pstmt.executeQuery();
			if(rs.next()){
			return true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	public Bbs getBbs(int PostID){
		String SQL= "SELECT * FROM POST WHERE PostID= ?";
		try{
			PreparedStatement pstmt = myConn.prepareStatement(SQL);
			pstmt.setInt(1, PostID);
			rs= pstmt.executeQuery();
			if(rs.next()){
				Bbs bbs =new Bbs();
				bbs.setPostID(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setPostDate(rs.getString(3));
				bbs.setContent(rs.getString(4));
				bbs.setAvailable(rs.getString(5));
				bbs.setID(rs.getString(6));
				return bbs;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

	public int update(int PostID, String Title, String Content){
		String SQL= "UPDATE POST SET TITLE=? , CONTENT=? WHERE PostID = ?";
		try{
			PreparedStatement pstmt = myConn.prepareStatement(SQL);
			pstmt.setString(1, Title);
			pstmt.setString(2, Content);
			pstmt.setInt(3, PostID);
			return pstmt.executeUpdate();
			}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� �������� ����
	}

	public int delete(int PostID){
		String SQL= "UPDATE POST SET Available =0 where PostID = ?";
		try{
			PreparedStatement pstmt = myConn.prepareStatement(SQL);
			pstmt.setInt(1, PostID);
			return pstmt.executeUpdate();
			}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� �������� ����
	}
}
