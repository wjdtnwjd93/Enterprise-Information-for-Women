package redhat.message;

import redhat.enterprise.Enterprise;

public class Message {
	//private int reply_num;
	private String e_code;
	private String reply_content;
	private String uid;
	private String current;	
	Enterprise enterprise = new Enterprise();
	/*public int getReply_num() {
		return reply_num;
	}
	public void setReply_num(int reply_num) {
		this.reply_num = reply_num;
	}*/
	public String getE_code() {
		//return e_code;
		return enterprise.getE_code();
	}
	public void setE_code(String e_code) {
		this.e_code = e_code;
		enterprise.setE_code(this.e_code);
	}

	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getCurrent() {
		return current;
	}
	public void setCurrent(String current) {
		this.current = current;
	}
	

}
