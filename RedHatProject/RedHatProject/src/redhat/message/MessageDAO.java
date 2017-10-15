package redhat.message;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import redhat.util.DBManager;

public class MessageDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;	
	Logger logger = LoggerFactory.getLogger(MessageDAO.class);

	public boolean newMsg(Message msg){
		conn = DBManager.getConnection();
		String sql = "insert into enterprise_reply(e_code, uid, reply_content, current) values(?,?,?,now())";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, msg.getE_code());
			pstmt.setString(2, msg.getUid());
			pstmt.setString(3, msg.getReply_content());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
			return false;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;	
	}
	
	public ArrayList<MessageSet> getReplyMessage(String e_code){
		ArrayList<MessageSet> datas = new ArrayList<MessageSet>();
		ArrayList<Message> messages = new ArrayList<Message>();
		conn = DBManager.getConnection();
		String sql = "select uid, reply_content, current from enterprise_reply where e_code=?";
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, e_code);		
			ResultSet rs = pstmt.executeQuery();	

			while(rs.next()){
				MessageSet mst = new MessageSet();
				Message m = new Message();
				
				m.setUid(rs.getString("uid"));
				m.setReply_content(rs.getString("reply_content"));
				m.setCurrent(rs.getString("current"));		
				messages.add(m);
				
				mst.setMessage(m);
				datas.add(mst);
			}	
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return datas;
	}


}
