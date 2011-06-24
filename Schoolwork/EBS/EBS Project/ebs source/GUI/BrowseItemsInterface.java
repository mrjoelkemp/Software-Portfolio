package GUI;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTable;
import javax.swing.ListSelectionModel;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;

public class BrowseItemsInterface extends JPanel {

	private static final long serialVersionUID = 1L;

	private JPanel browseItemsPanel = null;

	private JPanel detailedItemPanel = null;

	private JTable workingTable = null;

	public BrowseItemsInterface(String type) {
		setLayout(new GridBagLayout());
		GridBagConstraints gbc = new GridBagConstraints();
		gbc.gridx = 0;
		gbc.gridy = 0;
		add(new JLabel("Please select an item and bid below"), gbc);
		gbc.gridy = 1;
		add(getBrowseItemsPanel(type), gbc);
		gbc.gridy = 2;
		add(getDetailedItemsPanel(), gbc);

		// Table selection listener setup
		workingTable = ((BrowseInterface) browseItemsPanel).getJTable();
		ListSelectionModel rowSM = workingTable.getSelectionModel();
		rowSM.addListSelectionListener(new BrowseItemsSelectionListener());

	}

	public class BrowseItemsSelectionListener implements ListSelectionListener {

		public void valueChanged(ListSelectionEvent e) {
			// Ignore extra messages
			if (e.getValueIsAdjusting())
				return;
			ListSelectionModel lsm = (ListSelectionModel) e.getSource();

			// make sure that something's selected
			if (!lsm.isSelectionEmpty()) {
				// get the selected row number
				int selectedRow = lsm.getMinSelectionIndex();
				// get the item id
				int item_id = Integer.parseInt(workingTable.getValueAt(
						selectedRow, 0).toString());
				((DetailedItemInterface) detailedItemPanel)
						.setCurrentItem(item_id);
			}
		}// end valueChanged
	}// end BrowseItemsSelectionListener

	private JPanel getBrowseItemsPanel(String type) {
		if (browseItemsPanel == null) {
			// Show all the items for the SA
			if (TheMain.global_user.getInfo("SA").equalsIgnoreCase("true"))
				browseItemsPanel = new BrowseInterface("items", null, null,
						null);
			// The user is an OU
			else {
				// Show all active items
				if (type.equalsIgnoreCase("active"))
					browseItemsPanel = new BrowseInterface("items", "status",
							"Approved", null);
				// Show all items owned by this user
				else if (type.equalsIgnoreCase("personal"))
					browseItemsPanel = new BrowseInterface("items", "user_id",
							TheMain.global_user.getInfo("id"), null);
			}
		}
		return browseItemsPanel;
	}

	private JPanel getDetailedItemsPanel() {
		if (detailedItemPanel == null) {
			detailedItemPanel = new DetailedItemInterface();
		}
		return detailedItemPanel;

	}
}
