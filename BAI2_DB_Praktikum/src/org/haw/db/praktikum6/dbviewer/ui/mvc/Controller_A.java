package org.haw.db.praktikum6.dbviewer.ui.mvc;

public abstract class Controller_A<M, L extends ViewListener_I, V extends View_I<M, L>> {
	private M myModel;
	private V myView;
	
	public Controller_A() {
		setModel(createDefaultModel());
		setView(createDefaultView());
	}
	
	/**
	 * Gibt das von diesem Controller verwaltete Model zur�ck.
	 * @return Das Model
	 */
	protected final M getModel() {
		return myModel;
	}
	
	/**
	 * Registriert das �bergebene Model an diesem Controller.
	 * Sollte zu diesem Controller schon eine {@link View_I} registriert sein, wird die {@link View_I} mit dem Model bef�llt.
	 * @param model Das zu verwaltende Model
	 * @see View_I#fillViewWithModel(Object)
	 */
	protected final void setModel(M model) {
		myModel = model;
		update();
	}
	
	/**
	 * Gibt die von diesem Controller verwaltete {@link View_I} zur�ck.
	 * @return Die {@link View_I}
	 */
	protected final V getView() {
		return myView;
	}
	
	/**
	 * Registriert die �bergebene {@link View_I} an diesem Controller.
	 * Dabei registriert dieser Controller wiederum einen {@link ViewListener_I} auf der {@link View_I}
	 * und unregestriert sich an einer gebenenfalls vorher registrierten {@link View_I}.
	 * Sollte zu diesem Controller schon ein Model registriert sein, wird die {@link View_I} mit dem Model bef�llt.
	 * @param view Die zu verwaltende {@link View_I}
	 * @see #getViewListener()
	 * @see View_I#fillViewWithModel(Object)
	 */
	protected final void setView(V view) {
		unregisterOnView(myView);
		myView = view;
		registerOnView(myView);
		update();
	}
	
	private void unregisterOnView(V view) {
		if(view != null) {
			view.setViewListener(null);
		}
	}
	
	private void registerOnView(V view) {
		if(view != null) {
			view.setViewListener(getViewListener());
		}
	}
	
	/**
	 * Zeigt die View an.
	 */
	public void show() {
		myView.setVisible(true);
	}
	
	/**
	 * Versteckt die View.
	 */
	public void hide() {
		myView.setVisible(false);
	}
	
	/**
	 * Aktualisiert die Oberfl�che mit den aktuellen Daten aus dem Model.
	 */
	protected void update() {
		fillViewWithModel(myView, myModel);
	}
	
	private void fillViewWithModel(V view, M model) {
		if(view != null && model != null) {
			view.fillViewWithModel(model);
		}
	}
	
	/**
	 * Erzeugt ein standard-Model, mit dem der Controller initialisiert wird.
	 * @return Ein Model
	 */
	protected abstract M createDefaultModel();
	
	/**
	 * Erzeugt eine Standard-View, mit der der Controller initialisiert wird.
	 * @return Eine View
	 */
	protected abstract V createDefaultView();
	
	/**
	 * Gibt den {@link ViewListener_I} zur�ck, der auf der {@link View_I} die von diesem Controller verwaltet werden soll registriert wird.
	 * Es muss gew�hrleistet werden, dass diese Methode immer den selben {@link ViewListener_I} zur�ckgibt.
	 * @return Der {@link ViewListener_I}
	 */
	protected abstract L getViewListener();
}
