package org.haw.db.praktikum6.dbviewer.ui.dbviewer;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JOptionPane;

import org.haw.db.praktikum6.dbviewer.ui.login.DBLoginController;
import org.haw.db.praktikum6.dbviewer.ui.mvc.Controller_A;

public class DBViewerController extends Controller_A<DBViewerModel, DBViewerListener_I, DBViewerView> {
	private static final String QUERY_SELECT_TABLE = "SELECT * FROM ";
	private static final String QUERY_ALLE_TABELLEN = QUERY_SELECT_TABLE + "user_tables";
	
	private Connection myConnection;
	
	@Override
	public void show() {
		super.show();
		myConnection = new DBLoginController().login();
		frageTabellenAb();
	}
	
	private void frageTabellenAb() {
		try {
			Statement stmt = myConnection.createStatement();
			ResultSet rs = stmt.executeQuery(QUERY_ALLE_TABELLEN);
			
			List<String> tableNames = new ArrayList<>();
			while(rs.next()) {
				tableNames.add(rs.getString(1));
			}
			getModel().setTableNames(tableNames);
			update();
		} catch(SQLException e) {
			JOptionPane.showMessageDialog(null, e.getMessage(), "FEHLER", JOptionPane.ERROR_MESSAGE);
		}
	}
	
	private void tabelleAnzeigen(String tabelle) {
		try {
			Statement stmt = myConnection.createStatement();
			ResultSet rs = stmt.executeQuery(QUERY_SELECT_TABLE + tabelle);
			
			List<String> tableHeaders = new ArrayList<>();
			ResultSetMetaData meta = rs.getMetaData();
			for(int i=1; i<meta.getColumnCount(); i++) {
				tableHeaders.add(meta.getColumnName(i));
			}
			
			List<List<String>> tableEntries = new ArrayList<>();
			while(rs.next()) {
				List<String> tupel = new ArrayList<>();
				for(int i=1; i<rs.getMetaData().getColumnCount(); i++) {
					tupel.add(rs.getString(i));
				}
				tableEntries.add(tupel);
			}
			
			getModel().setTableHeader(tableHeaders);
			getModel().setTableEntries(tableEntries);
			update();
		} catch(SQLException e) {
			JOptionPane.showMessageDialog(null, e.getMessage(), "FEHLER", JOptionPane.ERROR_MESSAGE);
		}
	}
	
	@Override
	protected DBViewerListener_I getViewListener() {
		return new DBViewerListener_I() {
			@Override
			public void onTabelleAnzeigen(String tabelle) {
				tabelleAnzeigen(tabelle);
			}
		};
	}
	
	@Override
	protected DBViewerModel createDefaultModel() {
		return new DBViewerModel();
	}
	
	@Override
	protected DBViewerView createDefaultView() {
		return new DBViewerView();
	}
}
