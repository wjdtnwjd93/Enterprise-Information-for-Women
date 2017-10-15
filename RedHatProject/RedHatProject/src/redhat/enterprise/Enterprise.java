package redhat.enterprise;

public class Enterprise {
	private String e_code; //private -> public 수정
	private String e_name;
	private boolean e_family;
	
	public String getE_code() {
		return e_code;
	}
	public void setE_code(String e_code) {
		this.e_code = e_code;
	}
	public String getE_name() {
		return e_name;
	}
	public void setE_name(String e_name) {
		this.e_name = e_name;
	}
	public boolean isE_family() {
		return e_family;
	}
	public void setE_family(boolean e_family) {
		this.e_family = e_family;
	}
	
	

}
