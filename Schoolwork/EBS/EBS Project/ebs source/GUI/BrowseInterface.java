package GUI;

import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.util.Observable;
import java.util.Observer;

import javax.swing.JButton;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;

import system.MyTableModel;
import system.complaint;
import system.item;
import system.user;

public class BrowseInterface extends JPanel implements Observer {

	private static final long serialVersionUID = 1L;

	private JPanel panelMain = null;

	private JScrollPane jScrollPaneMain = null;

	private JTable jTableData = null;

	private String[] colNames = null;

	private String[][] data = null;

	private String tableName;

	private String whereField;

	private String lookingFor;

	private JButton actionButton;
	
	private MyTableModel tableModel = null;

	public BrowseInterface(String tableName_in, String whereField_in,
			String lookingFor_in, JButton actionButton_in) {
		TheMain.global_db.addObserver(this);
		tableName = tableName_in;
		whereField = whereField_in;
		lookingFor = lookingFor_in;

		this.actionButton = actionButton_in;
		
		// Setup the JTable

		// Get the data for the JTable before instantiating it
		data = TheMain.global_db.select(tableName_in, whereField_in,
				lookingFor_in, "");

		// Get the column headings for the JTable
		colNames = TheMain.global_db.getArrayOfFieldsFor(tableName_in);

		setLayout(new GridBagLayout());

		GridBagConstraints gridBagConstraints1 = new GridBagConstraints();
		gridBagConstraints1.gridx = 0;
		gridBagConstraints1.gridy = 0;
		gridBagConstraints1.fill = GridBagConstraints.BOTH;

		// Pass button to creation of main panel, rest of GUI
		add(getPanelMain(), gridBagConstraints1);

		gridBagConstraints1.gridy = 1;
		gridBagConstraints1.fill = GridBagConstraints.NONE;
		gridBagConstraints1.anchor = GridBagConstraints.EAST;

		if (actionButton_in != null) {

			actionButton_in.addActionListener(new ApproveButtonListener());
			add(actionButton_in, gridBagConstraints1);

			// Disable the button if there are no objects to approve
//			if (data.length == 0)
//				actionButton_in.setEnabled(false);

		}

		actionButton = actionButton_in;
		setMinimumSize(new Dimension(900, 200));
	}

	public JTable getJTable() {

		return jTableData;
	}

	private JPanel getPanelMain() {
		if (panelMain == null) {
			panelMain = new JPanel();
			panelMain.setSize(new java.awt.Dimension(900, 200));
			panelMain.add(getJScrollPaneMain(), null);
		}
		return panelMain;
	}

	private JScrollPane getJScrollPaneMain() {
		if (jScrollPaneMain == null) {
			jScrollPaneMain = new JScrollPane();
			jScrollPaneMain.setPreferredSize(new Dimension(950, 200));
			jScrollPaneMain.setMinimumSize(new Dimension(800, 200));
			jScrollPaneMain.setViewportView(getJTableData());
		}
		return jScrollPaneMain;
	}

	private JTable getJTableData() {
		if (jTableData == null) {
			tableModel = new MyTableModel(tableName, whereField, lookingFor);
			jTableData = new JTable(tableModel);
			jTableData.setMinimumSize(new Dimension(
					jScrollPaneMain.getHeight() - 20, jScrollPaneMain
							.getWidth() - 20));
			jTableData.getTableHeader().setReorderingAllowed(false);
		}
		return jTableData;
	}

	private class ApproveButtonListener implements ActionListener {

		public void actionPerformed(ActionEvent arg0) {

			// Get the id of the selected row
			int item_id = Integer.parseInt(jTableData.getValueAt(
					jTableData.getSelectedRow(), 0).toString());

			try {

				updateObject(item_id);

			} catch (IOException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private void updateObject(int item_id) throws IOException, Exception {
		Object thingToUpdate = null;

		// Get the object from the db 
		String[][] tempData = TheMain.global_db.select(tableName, "id", ""
				+ item_id, null);

		// Instantiate the object and update its status
		if (tableName.equalsIgnoreCase("users")) {
			thingToUpdate = new user(tempData);
			((user) thingToUpdate).setInfo("status", "Approved");

			((user) thingToUpdate).update();

		} else if (tableName.equalsIgnoreCase("items")) {
			thingToUpdate = new item(tempData);
			((item) thingToUpdate).setInfo("status", "Approved");

			((item) thingToUpdate).update();

		} else if (tableName.equalsIgnoreCase("complaints")) {

			thingToUpdate = new complaint(tempData);
			((complaint) thingToUpdate).setInfo("status", "Approved");

			String user_id = ((complaint) thingToUpdate)
					.getInfo("userOrItem_id");
			user u1 = null;

			u1 = new user(TheMain.global_db.select("users", "id", user_id, ""));

			// Update complaint status
			((complaint) thingToUpdate).update();

			// Mark complaint against user
			u1.incComplaint();

		}//end else if		
	}//end updateObject

	public void update(Observable arg0, Object arg1) {
		tableModel = new MyTableModel(tableName, whereField, lookingFor);

		tableModel.fireTableDataChanged();

		jTableData.setModel(tableModel);
				
	}
}
