package redhat.member;

public class Member {
	private String name;
	private String uid;
	private String passwd;
	
	public String getName(){
		return name;
	}
	
	public void setName(String name){
		this.name= name;
	}
	
	public String getUid(){
		return uid;
	}
	
	public void setUid(String id) {
		this.uid = id;
	}
	
	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

}
