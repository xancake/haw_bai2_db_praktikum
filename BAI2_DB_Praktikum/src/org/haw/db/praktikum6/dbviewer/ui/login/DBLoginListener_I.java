package org.haw.db.praktikum6.dbviewer.ui.login;

import org.haw.db.praktikum6.dbviewer.ui.mvc.ViewListener_I;

public interface DBLoginListener_I extends ViewListener_I {
	void onURLChanged(String url);
	void onUserChanged(String user);
	void onPassChanged(String pass);
	void onActionLogin(String url, String user, String pass);
	void onActionCancel();
}
