package org.haw.db.praktikum6.dbviewer.ui.dbviewer;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.ComboBoxModel;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.SwingUtilities;
import javax.swing.table.DefaultTableModel;

import org.haw.db.praktikum6.dbviewer.ui.mvc.View_A;

public class DBViewerView extends View_A<DBViewerModel, DBViewerListener_I> {
	private JFrame myFrame;
	private JComboBox<String> myTables;
	private JButton myTableAnzeigenButton;
	private JTable myTableTable;
	
	public DBViewerView() {
		initComponents();
		initLayout();
		initListeners();
	}
	
	private void initComponents() {
		myFrame = new JFrame("DBViewer (by LuL)");
		myFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		myTables = new JComboBox<>();
		myTableAnzeigenButton = new JButton("Ausw�hlen");
		myTableTable = new JTable();
	}
	
	private void initLayout() {
		JPanel contentPane = new JPanel();
		contentPane.setLayout(new BorderLayout());
		
		JPanel tableAuswahlPanel = new JPanel();
		tableAuswahlPanel.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
		tableAuswahlPanel.setLayout(new BoxLayout(tableAuswahlPanel, BoxLayout.LINE_AXIS));
		tableAuswahlPanel.add(new JLabel("Tabelle ausw�hlen:"));
		tableAuswahlPanel.add(Box.createHorizontalStrut(5));
		tableAuswahlPanel.add(myTables);
		tableAuswahlPanel.add(Box.createHorizontalStrut(5));
		tableAuswahlPanel.add(myTableAnzeigenButton);
		
		JScrollPane scrollTables = new JScrollPane(myTableTable);
		
		contentPane.add(tableAuswahlPanel, BorderLayout.NORTH);
		contentPane.add(scrollTables, BorderLayout.CENTER);
		
		myFrame.setContentPane(contentPane);
		myFrame.pack();
		myFrame.setSize(800, 600);
		myFrame.setLocationRelativeTo(null);
	}
	
	private void initListeners() {
		myTableAnzeigenButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				myListener.onTabelleAnzeigen((String)myTables.getSelectedItem());
			}
		});
	}
	
	@Override
	public void fillViewWithModel(DBViewerModel model) {
		String[] tableNames = model.getTableNames().toArray(new String[0]);
		ComboBoxModel<String> comboBoxModel = new DefaultComboBoxModel<>(tableNames);
		myTables.setModel(comboBoxModel);
		
		List<String> tableHeader = model.getTableHeader();
		List<List<String>> tableEntries = model.getTableEntries();
		if(tableHeader != null && tableEntries != null) {
			String[][] tableEntriesArray = new String[tableEntries.size()][];
			for(int i=0; i<tableEntries.size(); i++) {
				tableEntriesArray[i] = tableEntries.get(i).toArray(new String[0]);
			}
			
			DefaultTableModel dataModel = new DefaultTableModel(tableEntriesArray, tableHeader.toArray(new String[0]));
			myTableTable.setModel(dataModel);
		}
	}
	
	@Override
	public boolean isVisible() {
		return myFrame.isVisible();
	}
	
	@Override
	public void setVisible(final boolean visible) {
		SwingUtilities.invokeLater(new Runnable() {
			@Override
			public void run() {
				myFrame.setVisible(visible);
			}
		});
	}
}
