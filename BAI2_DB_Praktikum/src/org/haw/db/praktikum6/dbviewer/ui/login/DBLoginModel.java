package org.haw.db.praktikum6.dbviewer.ui.login;

public class DBLoginModel {
	private String myHost;
	private String myUser;
	private String myPass;
	
	public DBLoginModel() {}
	
	public DBLoginModel(String host, String user, String pass) {
		setHost(host);
		setUser(user);
		setPassword(pass);
	}
	
	public String getHost() {
		return myHost;
	}
	
	public void setHost(String host) {
		myHost = host;
	}
	
	public String getUser() {
		return myUser;
	}
	
	public void setUser(String user) {
		myUser = user;
	}
	
	public String getPassword() {
		return myPass;
	}
	
	public void setPassword(String pass) {
		myPass = pass;
	}
}
