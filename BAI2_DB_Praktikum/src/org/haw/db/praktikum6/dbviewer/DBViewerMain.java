package org.haw.db.praktikum6.dbviewer;

import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

import org.haw.db.praktikum6.dbviewer.ui.dbviewer.DBViewerController;

public class DBViewerMain {
	public static void main(String... args) {
		try {
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		} catch(ClassNotFoundException | InstantiationException | IllegalAccessException | UnsupportedLookAndFeelException e) {
			e.printStackTrace();
		}
		new DBViewerController().show();
	}
}
