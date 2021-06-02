package todo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import todo.Todo;

public class TodoDAO {
	private Connection myConn;
	private ResultSet rs;
	
	public TodoDAO(){
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
		String SQL= "SELECT TODOID FROM TODO ORDER BY TODOID DESC";
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
	
	public int insertTodo(String Title, String Description, String IsDone, String TargetDate,String ID){
		String SQL= "INSERT INTO TODO VALUES (?, ? , ? , ? ,? , ?)";
		try{
			PreparedStatement pstmt = myConn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, Description);
			pstmt.setString(3, IsDone);
			pstmt.setString(4, TargetDate);
			pstmt.setString(5, Title);
			pstmt.setString(6, ID );
			return pstmt.executeUpdate();
			}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� �������� ����
	}
	
	public ArrayList<Todo> getList(String id){
		String SQL= "SELECT * FROM Todo Where ID=? ORDER BY TodoID DESC";
		ArrayList<Todo> list = new ArrayList<Todo>();
		try{
			PreparedStatement pstmt = myConn.prepareStatement(SQL);
			pstmt.setString(1, id);
			rs= pstmt.executeQuery();
			
			while(rs.next()){
				Todo todo =new Todo();
				
				todo.setTodoID(rs.getInt(1));
				todo.setDescription(rs.getString(2));
				todo.setIsDone(rs.getString(3));
				todo.setTargetDate(rs.getString(4));
				todo.setTitle(rs.getString(5));
				todo.setID(rs.getString(6));
				list.add(todo);
			}
			pstmt.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}

	public Todo getTodo(int TodoID){
		String SQL= "SELECT * FROM TODO WHERE TodoID= ?";
		try{
			PreparedStatement pstmt = myConn.prepareStatement(SQL);
			pstmt.setInt(1, TodoID);
			rs= pstmt.executeQuery();
			if(rs.next()){
				Todo todo =new Todo();
				todo.setTodoID(rs.getInt(1));
				todo.setDescription(rs.getString(2));
				todo.setIsDone(rs.getString(3));
				todo.setTargetDate(rs.getString(4));
				todo.setTitle(rs.getString(5));
				todo.setID(rs.getString(6));
				return todo;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public int updateTodo(int TodoID, String Title, String Description, String IsDone, String TargetDate ){
		String SQL= "UPDATE TODO SET TITLE=? , DESCRIPTION=?, isDone= ? , TargetDate= ? WHERE TodoID = ?";
		try{
			PreparedStatement pstmt = myConn.prepareStatement(SQL);
			pstmt.setString(1, Title);
			pstmt.setString(2, Description);
			pstmt.setString(3, IsDone);
			pstmt.setString(4, TargetDate);
			return pstmt.executeUpdate();
			}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� �������� ����
	}

	public int deleteTodo(int TodoID){
		String SQL= "DELETE FROM TODO WHERE TODOID=?";
		try{
			PreparedStatement pstmt = myConn.prepareStatement(SQL);
			pstmt.setInt(1, TodoID);
			return pstmt.executeUpdate();
			}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� �������� ����
	}
}
	
