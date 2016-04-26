package org.haw.db.praktikum6.dbviewer.ui.login;

import java.awt.Dimension;
import java.awt.Frame;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.InputEvent;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

import javax.swing.AbstractAction;
import javax.swing.Action;
import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.KeyStroke;
import javax.swing.SwingUtilities;

import org.haw.db.praktikum6.dbviewer.ui.mvc.View_A;

public class DBLoginView extends View_A<DBLoginModel, DBLoginListener_I> {
	private JDialog myDialog;
	private JTextField myURLField;
	private JTextField myUserField;
	private JTextField myPassField;
	private JButton myLoginButton;
	private JButton myCancelButton;
	
	public DBLoginView(DBLoginListener_I listener) {
		initComponents();
		initLayout();
		initListeners();
		setViewListener(listener);
	}
	
	private void initComponents() {
		myDialog = new JDialog((Frame)null, "Login", true);
		myDialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		myURLField = new JTextField();
		myUserField = new JTextField();
		myPassField = new JPasswordField();
		myLoginButton = new JButton("Login");
		myCancelButton = new JButton("Cancel");
	}
	
	private void initLayout() {
		JPanel content = new JPanel();
		content.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
		content.setLayout(new BoxLayout(content, BoxLayout.PAGE_AXIS));
		
		myURLField.setPreferredSize(new Dimension(400, myUserField.getPreferredSize().height));
		
		JPanel urlPanel = new JPanel();
		urlPanel.setLayout(new BoxLayout(urlPanel, BoxLayout.LINE_AXIS));
		urlPanel.add(new JLabel("URL:"));
		urlPanel.add(Box.createHorizontalStrut(5));
		urlPanel.add(myURLField);
		
		JPanel userPanel = new JPanel();
		userPanel.setLayout(new BoxLayout(userPanel, BoxLayout.LINE_AXIS));
		userPanel.add(new JLabel("Username:"));
		userPanel.add(Box.createHorizontalStrut(5));
		userPanel.add(myUserField);
		
		JPanel passwordPanel = new JPanel();
		passwordPanel.setLayout(new BoxLayout(passwordPanel, BoxLayout.LINE_AXIS));
		passwordPanel.add(new JLabel("Passwort:"));
		passwordPanel.add(Box.createHorizontalStrut(5));
		passwordPanel.add(myPassField);
		
		JPanel buttonPanel = new JPanel();
		buttonPanel.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
		buttonPanel.setLayout(new BoxLayout(buttonPanel, BoxLayout.LINE_AXIS));
		buttonPanel.add(Box.createHorizontalGlue());
		buttonPanel.add(myLoginButton);
		buttonPanel.add(Box.createHorizontalStrut(5));
		buttonPanel.add(myCancelButton);
		
		content.add(urlPanel);
		content.add(Box.createVerticalStrut(5));
		content.add(userPanel);
		content.add(Box.createVerticalStrut(5));
		content.add(passwordPanel);
		content.add(Box.createVerticalStrut(5));
		content.add(buttonPanel);
		
		myDialog.setContentPane(content);
		myDialog.pack();
		myDialog.setLocationRelativeTo(null);
	}
	
	@SuppressWarnings("serial")
	private void initListeners() {
		myURLField.addKeyListener(new KeyAdapter() {
			@Override
			public void keyTyped(KeyEvent e) {
				myListener.onURLChanged(myURLField.getText());
			}
		});
		myURLField.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				myUserField.requestFocusInWindow();
			}
		});
		myUserField.addKeyListener(new KeyAdapter() {
			@Override
			public void keyTyped(KeyEvent e) {
				myListener.onUserChanged(myUserField.getText());
			}
		});
		myUserField.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				myPassField.requestFocusInWindow();
			}
		});
		myPassField.addKeyListener(new KeyAdapter() {
			@Override
			public void keyTyped(KeyEvent e) {
				myListener.onPassChanged(myPassField.getText());
			}
		});
		myPassField.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				myLoginButton.requestFocusInWindow();
			}
		});
		myLoginButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				myListener.onActionLogin(myURLField.getText(), myUserField.getText(), myPassField.getText());
			}
		});
		myCancelButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				myListener.onActionCancel();
			}
		});
		myDialog.addWindowListener(new WindowAdapter() {
			@Override
			public void windowClosing(WindowEvent e) {
				myListener.onActionCancel();
			}
		});
		setShortcutAction(myLoginButton, JComponent.WHEN_IN_FOCUSED_WINDOW,
				KeyStroke.getKeyStroke(KeyEvent.VK_ENTER, InputEvent.CTRL_DOWN_MASK),
				"LOGIN_ACTION", new AbstractAction() {
			@Override
			public void actionPerformed(ActionEvent e) {
				myListener.onActionLogin(myURLField.getText(), myUserField.getText(), myPassField.getText());
			}
		});
		setShortcutAction(myCancelButton, JComponent.WHEN_IN_FOCUSED_WINDOW,
				KeyStroke.getKeyStroke(KeyEvent.VK_ESCAPE, 0),
				"CANCEL_ACTION", new AbstractAction() {
			@Override
			public void actionPerformed(ActionEvent e) {
				myListener.onActionCancel();
			}
		});
	}
	
	private void setShortcutAction(JComponent component, int condition, KeyStroke keyStroke, String actionKey, Action action) {
		component.getInputMap(condition).put(keyStroke, actionKey);
		component.getActionMap().put(actionKey, action);
	}
	
	@Override
	public void fillViewWithModel(DBLoginModel model) {
		myURLField.setText(model.getHost());
		myUserField.setText(model.getUser());
		myPassField.setText(model.getPassword());
		setFocus();
	}
	
	private void setFocus() {
		if(isEmpty(myURLField)) {
			myURLField.requestFocusInWindow();
		} else if(isEmpty(myUserField)) {
			myUserField.requestFocusInWindow();
		} else if(isEmpty(myPassField)) {
			myPassField.requestFocusInWindow();
		} else {
			myLoginButton.requestFocusInWindow();
		}
	}
	
	private boolean isEmpty(JTextField textfield) {
		return textfield.getText() == null || textfield.getText().isEmpty();
	}

	@Override
	public boolean isVisible() {
		return myDialog.isVisible();
	}

	@Override
	public void setVisible(final boolean visible) {
		SwingUtilities.invokeLater(new Runnable() {
			@Override
			public void run() {
				myDialog.setVisible(visible);
			}
		});
	}
}
