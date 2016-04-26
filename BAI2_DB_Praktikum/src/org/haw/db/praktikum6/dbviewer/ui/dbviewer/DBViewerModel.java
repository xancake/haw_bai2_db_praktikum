package org.haw.db.praktikum6.dbviewer.ui.dbviewer;

import java.util.ArrayList;
import java.util.List;

public class DBViewerModel {
	private List<String> myTableNames;
	
	private List<String> myTableHeader;
	private List<List<String>> myTableEntries;
	
	public DBViewerModel() {
		setTableNames(new ArrayList<String>());
	}
	
	public List<String> getTableNames() {
		return myTableNames;
	}
	
	public void setTableNames(List<String> tableNames) {
		myTableNames = tableNames;
	}
	
	public List<String> getTableHeader() {
		return myTableHeader;
	}
	
	public void setTableHeader(List<String> tableHeader) {
		myTableHeader = tableHeader;
	}
	
	public List<List<String>> getTableEntries() {
		return myTableEntries;
	}
	
	public void setTableEntries(List<List<String>> tableEntries) {
		myTableEntries = tableEntries;
	}
}
