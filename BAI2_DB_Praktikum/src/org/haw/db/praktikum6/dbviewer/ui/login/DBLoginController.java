package org.haw.db.praktikum6.dbviewer.ui.login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.swing.JOptionPane;

import org.haw.db.praktikum6.dbviewer.ui.mvc.Controller_A;

public class DBLoginController extends Controller_A<DBLoginModel, DBLoginListener_I, DBLoginView> {
	private static final String URL_DEFAULT   = "jdbc:oracle:thin:@ora.informatik.haw-hamburg.de:1521:inf09";
	private static final String USER_DEFAULT = "abs969";
	
	private Connection myConnection;
	
	public Connection login() {
		myConnection = null;
		show();
		// Darauf warten, dass versucht wird sich einzuloggen #login0(String, String, String)
		// Wenn der Login-Vorgang erfolgreich war, ist die Connection nicht mehr 'null'
		// und kann somit zur�ckgegeben werden
		while(myConnection == null) {
			// Etwas schlafen, damit Zeit f�r andere Berechnungen bleibt
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {}
		}
		hide();
		return myConnection;
	}
	
	private void login0(String url, String user, String pass) {
		try {
			myConnection = DriverManager.getConnection(url, user, pass);
		} catch(SQLException e) {
			JOptionPane.showMessageDialog(null, e.getMessage(), "FEHLER", JOptionPane.ERROR_MESSAGE);
		}
	}
	
	@Override
	protected DBLoginListener_I getViewListener() {
		return new DBLoginListener_I() {
			@Override
			public void onURLChanged(String url) {
				getModel().setHost(url);
			}
			
			@Override
			public void onUserChanged(String user) {
				getModel().setUser(user);
			}
			
			@Override
			public void onPassChanged(String pass) {
				getModel().setPassword(pass);
			}
			
			@Override
			public void onActionLogin(String url, String user, String pass) {
				login0(url, user, pass);
			}
			
			@Override
			public void onActionCancel() {
				System.exit(0);
			}
		};
	}
	
	@Override
	protected DBLoginModel createDefaultModel() {
		return new DBLoginModel(URL_DEFAULT, USER_DEFAULT, "");
	}
	
	@Override
	protected DBLoginView createDefaultView() {
		return new DBLoginView(getViewListener());
	}
}
