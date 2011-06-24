package GUI;

import java.awt.Dimension;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JPanel;
import javax.swing.JTabbedPane;

public class ApproveInterface extends JPanel {

	private static final long serialVersionUID = 1L;

	private JPanel jContentPane = null;

	private JButton jButApproveUser = null;

	private JButton jButApproveItem = null;

	private JButton jButApproveComplaint = null;

	private JTabbedPane jTabbedPane = null;

	ImageIcon authorizeImage = new ImageIcon("./images/person3.jpg");

	public ApproveInterface(String approveType) {

		if (approveType.equalsIgnoreCase("users"))
			add(getApproveUsersPanel());
		else if (approveType.equalsIgnoreCase("items"))
			add(getApproveItemsPanel());
		else if (approveType.equalsIgnoreCase("complaints"))
			add(getApproveComplaintsPanel());
		// add(getJContentPane());
	}

	private JTabbedPane getJTabbedPane() {
		if (jTabbedPane != null) {

			jTabbedPane = new JTabbedPane();
			jTabbedPane.addTab("Approve Users", authorizeImage,
					getApproveUsersPanel(),
					"Approve pending user accounts here");
			jTabbedPane.addTab("Approve Items", authorizeImage,
					getApproveItemsPanel(), "Approve pending items here");
			jTabbedPane.addTab("Approve Complaints", authorizeImage,
					getApproveComplaintsPanel(),
					"Approve pending complaints here");
		}
		return jTabbedPane;
	}

	/**
	 * This method initializes jContentPane
	 * 
	 * @return javax.swing.JPanel
	 */
	private JPanel getJContentPane() {
		if (jContentPane == null) {
			jContentPane = new JPanel();
			// jContentPane.add(getJTabbedPane());
			// jContentPane.setLayout(new GridLayout(3,1));
			// jContentPane.add(getApproveUsersPanel());
			// jContentPane.add(getApproveItemsPanel());
			// jContentPane.add(getApproveComplaintsPanel());
		}
		setMinimumSize(new Dimension(900, 600));
		return jContentPane;
	}

	private JPanel getApproveUsersPanel() {
		return new BrowseInterface("users", "status", "Pending",
				getJButApproveUser());
	}

	private JPanel getApproveItemsPanel() {
		return new BrowseInterface("items", "status", "Pending",
				getJButtonApproveItem());
	}

	private JPanel getApproveComplaintsPanel() {
		return new BrowseInterface("complaints", "status", "Pending",
				getJButtonApproveComplaint());
	}

	private JButton getJButApproveUser() {
		if (jButApproveUser == null) {
			jButApproveUser = new JButton("Approve User");
		}
		return jButApproveUser;

	}

	private JButton getJButtonApproveItem() {
		if (jButApproveItem == null) {
			jButApproveItem = new JButton("Approve Item");
		}
		return jButApproveItem;
	}

	private JButton getJButtonApproveComplaint() {
		if (jButApproveComplaint == null) {
			jButApproveComplaint = new JButton("Approve Complaint");
		}
		return jButApproveComplaint;

	}

}
