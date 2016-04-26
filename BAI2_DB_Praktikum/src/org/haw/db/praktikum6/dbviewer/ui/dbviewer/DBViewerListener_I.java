package org.haw.db.praktikum6.dbviewer.ui.dbviewer;

import org.haw.db.praktikum6.dbviewer.ui.mvc.ViewListener_I;

public interface DBViewerListener_I extends ViewListener_I {
	void onTabelleAnzeigen(String tabelle);
}
