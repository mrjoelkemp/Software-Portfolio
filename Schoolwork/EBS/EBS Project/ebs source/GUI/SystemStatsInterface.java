package GUI;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;

import javax.swing.JLabel;
import javax.swing.JPanel;

public class SystemStatsInterface extends JPanel {

	private static final long serialVersionUID = 1L;

	private JLabel jLabelNumOfOUs = null;

	private JLabel jLabelNumOfOUsValue = null;

	private JLabel jLabelItemsTotal = null;

	private JLabel jLabelItemsTotalValue = null;

	private JLabel jLabelTransactionsTotal = null;

	private JLabel jLabelTransactionsTotalValue = null;

	private JLabel jLabelComplaintsTotal = null;

	private JLabel jLabelComplaintsTotalValue = null;

	private JPanel jPanelUsers = null;

	private JLabel jLabelUsers = null;

	private JPanel jPanelTransactions = null;

	private JPanel jPanelItems = null;

	private JPanel jPanelComplaints = null;

	private JLabel jLabelItems = null;

	private JLabel jLabelTransactions = null;

	private JLabel jLabelComplaints = null;

	private JLabel jLabelItemsFinished = null;

	private JLabel jLabelItemsFinishedValue = null;

	private JLabel jLabelItemsActive = null;

	private JLabel jLabelItemsActiveValue = null;

	private JLabel jLabelItemsArchived = null;

	private JLabel jLabelItemsArchivedValue = null;

	private JLabel jLabelItemsWithdrawn = null;

	private JLabel jLabelItemsWithdrawnValue = null;

	private JLabel jLabelUsersPending = null;

	private JLabel jLabelUsersPendingValue = null;

	private JLabel jLabelUsersApproved = null;

	private JLabel jLabelUsersApprovedValue = null;

	private JLabel jLabelUsersBlocked = null;

	private JLabel jLabelUsersBlockedValue = null;

	private JLabel jLabelComplaintsPending = null;

	private JLabel jLabelComplaintsPendingValue = null;

	private JLabel jLabelComplaintsApproved = null;

	private JLabel jLabelComplaintsApprovedValue = null;

	private JLabel jLabelItemsPending = null;

	private JLabel jLabelItemsPendingValue = null;

	public SystemStatsInterface() {
		add(getJPanelItems());
		add(getJPanelUsers());
		add(getJPanelComplaints());
		add(getJPanelTransactions());
	}

	private JLabel getJLabelNumOfOUs() {
		if (jLabelNumOfOUs == null) {
			jLabelNumOfOUs = new JLabel();
			jLabelNumOfOUs.setText("Total:");
		}
		return jLabelNumOfOUs;
	}

	private JLabel getJLabelNumOfOUsValue() {
		if (jLabelNumOfOUsValue == null) {
			jLabelNumOfOUsValue = new JLabel();
			jLabelNumOfOUsValue.setText(String.valueOf(TheMain.global_db
					.select("users", null, "", "").length));
		}
		return jLabelNumOfOUsValue;
	}

	private JLabel getJLabel() {
		if (jLabelItemsTotal == null) {
			jLabelItemsTotal = new JLabel();
			jLabelItemsTotal.setText("Total:");
		}
		return jLabelItemsTotal;
	}

	private JLabel getJLabelNumOfItemsValue() {
		if (jLabelItemsTotalValue == null) {
			jLabelItemsTotalValue = new JLabel();
			jLabelItemsTotalValue.setText(String.valueOf(TheMain.global_db
					.select("items", null, "", "").length));
		}
		return jLabelItemsTotalValue;
	}

	private JLabel getJLabelNumOfTrans() {
		if (jLabelTransactionsTotal == null) {
			jLabelTransactionsTotal = new JLabel();
			jLabelTransactionsTotal.setText("Total:");
		}
		return jLabelTransactionsTotal;
	}

	private JLabel getJLabelNumOfTransValue() {
		if (jLabelTransactionsTotalValue == null) {
			jLabelTransactionsTotalValue = new JLabel();
			jLabelTransactionsTotalValue.setText(String
					.valueOf(TheMain.global_db.select("transactions", null, "",
							"").length));
		}
		return jLabelTransactionsTotalValue;
	}

	private JLabel getJLabelNumOfComplaints() {
		if (jLabelComplaintsTotal == null) {
			jLabelComplaintsTotal = new JLabel();
			jLabelComplaintsTotal.setText("Total:");
		}
		return jLabelComplaintsTotal;
	}

	private JLabel getJLabelNumOfComplaintsValue() {
		if (jLabelComplaintsTotalValue == null) {
			jLabelComplaintsTotalValue = new JLabel();
			jLabelComplaintsTotalValue.setText(String.valueOf(TheMain.global_db
					.select("complaints", null, "", "").length));
		}
		return jLabelComplaintsTotalValue;
	}

	private JPanel getJPanelUsers() {
		if (jPanelUsers == null) {
			GridBagConstraints gridBagConstraints61 = new GridBagConstraints();
			gridBagConstraints61.gridx = 1;
			gridBagConstraints61.gridy = 4;
			jLabelUsersBlockedValue = new JLabel();
			jLabelUsersBlockedValue.setText(String.valueOf(TheMain.global_db
					.select("users", "status", "Blocked", "").length));
			GridBagConstraints gridBagConstraints51 = new GridBagConstraints();
			gridBagConstraints51.gridx = 0;
			gridBagConstraints51.gridy = 4;
			jLabelUsersBlocked = new JLabel();
			jLabelUsersBlocked.setText("Blocked:");
			GridBagConstraints gridBagConstraints41 = new GridBagConstraints();
			gridBagConstraints41.gridx = 1;
			gridBagConstraints41.gridy = 3;
			jLabelUsersApprovedValue = new JLabel();
			jLabelUsersApprovedValue.setText(String.valueOf(TheMain.global_db
					.select("users", "status", "Approved", "").length));
			GridBagConstraints gridBagConstraints31 = new GridBagConstraints();
			gridBagConstraints31.gridx = 0;
			gridBagConstraints31.gridy = 3;
			jLabelUsersApproved = new JLabel();
			jLabelUsersApproved.setText("Approved:");
			GridBagConstraints gridBagConstraints21 = new GridBagConstraints();
			gridBagConstraints21.gridx = 1;
			gridBagConstraints21.gridy = 2;
			jLabelUsersPendingValue = new JLabel();
			jLabelUsersPendingValue.setText(String.valueOf(TheMain.global_db
					.select("users", "status", "Pending", "").length));
			GridBagConstraints gridBagConstraints110 = new GridBagConstraints();
			gridBagConstraints110.gridx = 0;
			gridBagConstraints110.gridy = 2;
			jLabelUsersPending = new JLabel();
			jLabelUsersPending.setText("Pending:");
			GridBagConstraints gridBagConstraints2 = new GridBagConstraints();
			gridBagConstraints2.gridx = 1;
			gridBagConstraints2.gridy = 1;
			GridBagConstraints gridBagConstraints1 = new GridBagConstraints();
			gridBagConstraints1.gridx = 0;
			gridBagConstraints1.gridy = 1;
			GridBagConstraints gridBagConstraints = new GridBagConstraints();
			gridBagConstraints.gridx = 0;
			gridBagConstraints.gridwidth = 2;
			gridBagConstraints.gridy = 0;
			jPanelUsers = new JPanel();
			jPanelUsers.setLayout(new GridBagLayout());
			jPanelUsers.setSize(new java.awt.Dimension(208, 213));
			jPanelUsers.add(getJLabelUsers(), gridBagConstraints);
			jPanelUsers.add(getJLabelNumOfOUs(), gridBagConstraints1);
			jPanelUsers.add(getJLabelNumOfOUsValue(), gridBagConstraints2);
			jPanelUsers.add(jLabelUsersPending, gridBagConstraints110);
			jPanelUsers.add(jLabelUsersPendingValue, gridBagConstraints21);
			jPanelUsers.add(jLabelUsersApproved, gridBagConstraints31);
			jPanelUsers.add(jLabelUsersApprovedValue, gridBagConstraints41);
			jPanelUsers.add(jLabelUsersBlocked, gridBagConstraints51);
			jPanelUsers.add(jLabelUsersBlockedValue, gridBagConstraints61);
		}
		return jPanelUsers;
	}

	private JLabel getJLabelUsers() {
		if (jLabelUsers == null) {
			jLabelUsers = new JLabel();
			jLabelUsers.setText("Users");
		}
		return jLabelUsers;
	}

	private JPanel getJPanelTransactions() {
		if (jPanelTransactions == null) {
			GridBagConstraints gridBagConstraints11 = new GridBagConstraints();
			gridBagConstraints11.gridx = 1;
			gridBagConstraints11.gridy = 1;
			GridBagConstraints gridBagConstraints10 = new GridBagConstraints();
			gridBagConstraints10.gridx = 0;
			gridBagConstraints10.gridy = 1;
			GridBagConstraints gridBagConstraints3 = new GridBagConstraints();
			gridBagConstraints3.gridx = 0;
			gridBagConstraints3.gridwidth = 2;
			gridBagConstraints3.gridy = 0;
			jPanelTransactions = new JPanel();
			jPanelTransactions.setLayout(new GridBagLayout());
			jPanelTransactions.setSize(new java.awt.Dimension(191, 212));
			jPanelTransactions
					.add(getJLabelTransactions(), gridBagConstraints3);
			jPanelTransactions.add(getJLabelNumOfTrans(), gridBagConstraints10);
			jPanelTransactions.add(getJLabelNumOfTransValue(),
					gridBagConstraints11);
		}
		return jPanelTransactions;
	}

	private JPanel getJPanelItems() {
		if (jPanelItems == null) {
			GridBagConstraints gridBagConstraints26 = new GridBagConstraints();
			gridBagConstraints26.gridx = 2;
			gridBagConstraints26.gridy = 6;
			jLabelItemsPendingValue = new JLabel();
			jLabelItemsPendingValue.setText(String.valueOf(TheMain.global_db
					.select("items", "status", "Pending", "").length));
			GridBagConstraints gridBagConstraints25 = new GridBagConstraints();
			gridBagConstraints25.gridx = 1;
			gridBagConstraints25.gridy = 6;
			jLabelItemsPending = new JLabel();
			jLabelItemsPending.setText("Pending:");
			GridBagConstraints gridBagConstraints19 = new GridBagConstraints();
			gridBagConstraints19.gridx = 2;
			gridBagConstraints19.gridy = 5;
			jLabelItemsWithdrawnValue = new JLabel();
			jLabelItemsWithdrawnValue.setText(String.valueOf(TheMain.global_db
					.select("items", "status", "Withdrawn", "").length));
			GridBagConstraints gridBagConstraints18 = new GridBagConstraints();
			gridBagConstraints18.gridx = 1;
			gridBagConstraints18.gridy = 5;
			jLabelItemsWithdrawn = new JLabel();
			jLabelItemsWithdrawn.setText("Withdrawn:");
			GridBagConstraints gridBagConstraints17 = new GridBagConstraints();
			gridBagConstraints17.gridx = 2;
			gridBagConstraints17.gridy = 4;
			jLabelItemsArchivedValue = new JLabel();
			jLabelItemsArchivedValue.setText(String.valueOf(TheMain.global_db
					.select("items", "status", "Archived", "").length));
			GridBagConstraints gridBagConstraints16 = new GridBagConstraints();
			gridBagConstraints16.gridx = 1;
			gridBagConstraints16.gridy = 4;
			jLabelItemsArchived = new JLabel();
			jLabelItemsArchived.setText("Archived:");
			GridBagConstraints gridBagConstraints15 = new GridBagConstraints();
			gridBagConstraints15.gridx = 2;
			gridBagConstraints15.gridy = 3;
			jLabelItemsActiveValue = new JLabel();
			jLabelItemsActiveValue.setText(String.valueOf(TheMain.global_db
					.select("items", "status", "Approved", "").length));
			GridBagConstraints gridBagConstraints14 = new GridBagConstraints();
			gridBagConstraints14.gridx = 1;
			gridBagConstraints14.gridy = 3;
			jLabelItemsActive = new JLabel();
			jLabelItemsActive.setText("Active:");
			GridBagConstraints gridBagConstraints13 = new GridBagConstraints();
			gridBagConstraints13.gridx = 2;
			gridBagConstraints13.gridy = 2;
			jLabelItemsFinishedValue = new JLabel();
			jLabelItemsFinishedValue.setText(String.valueOf(TheMain.global_db
					.select("items", "status", "Finished", "").length));
			GridBagConstraints gridBagConstraints12 = new GridBagConstraints();
			gridBagConstraints12.gridx = 1;
			gridBagConstraints12.gridy = 2;
			jLabelItemsFinished = new JLabel();
			jLabelItemsFinished.setText("Finished:");
			GridBagConstraints gridBagConstraints7 = new GridBagConstraints();
			gridBagConstraints7.gridx = 2;
			gridBagConstraints7.gridy = 1;
			GridBagConstraints gridBagConstraints6 = new GridBagConstraints();
			gridBagConstraints6.gridx = 1;
			gridBagConstraints6.gridy = 1;
			GridBagConstraints gridBagConstraints5 = new GridBagConstraints();
			gridBagConstraints5.gridx = 1;
			gridBagConstraints5.gridwidth = 2;
			gridBagConstraints5.gridy = 0;
			jPanelItems = new JPanel();
			jPanelItems.setLayout(new GridBagLayout());
			jPanelItems.setSize(new java.awt.Dimension(204, 214));
			jPanelItems.add(getJLabelItems(), gridBagConstraints5);
			jPanelItems.add(getJLabel(), gridBagConstraints6);
			jPanelItems.add(getJLabelNumOfItemsValue(), gridBagConstraints7);
			jPanelItems.add(jLabelItemsFinished, gridBagConstraints12);
			jPanelItems.add(jLabelItemsFinishedValue, gridBagConstraints13);
			jPanelItems.add(jLabelItemsActive, gridBagConstraints14);
			jPanelItems.add(jLabelItemsActiveValue, gridBagConstraints15);
			jPanelItems.add(jLabelItemsArchived, gridBagConstraints16);
			jPanelItems.add(jLabelItemsArchivedValue, gridBagConstraints17);
			jPanelItems.add(jLabelItemsWithdrawn, gridBagConstraints18);
			jPanelItems.add(jLabelItemsWithdrawnValue, gridBagConstraints19);
			jPanelItems.add(jLabelItemsPending, gridBagConstraints25);
			jPanelItems.add(jLabelItemsPendingValue, gridBagConstraints26);
		}
		return jPanelItems;
	}

	private JPanel getJPanelComplaints() {
		if (jPanelComplaints == null) {
			GridBagConstraints gridBagConstraints24 = new GridBagConstraints();
			gridBagConstraints24.gridx = 1;
			gridBagConstraints24.gridy = 3;
			jLabelComplaintsApprovedValue = new JLabel();
			jLabelComplaintsApprovedValue.setText(String
					.valueOf(TheMain.global_db.select("complaints", "status",
							"Approved", "").length));
			GridBagConstraints gridBagConstraints23 = new GridBagConstraints();
			gridBagConstraints23.gridx = 0;
			gridBagConstraints23.gridy = 3;
			jLabelComplaintsApproved = new JLabel();
			jLabelComplaintsApproved.setText("Approved:");
			GridBagConstraints gridBagConstraints22 = new GridBagConstraints();
			gridBagConstraints22.gridx = 1;
			gridBagConstraints22.gridy = 2;
			jLabelComplaintsPendingValue = new JLabel();
			jLabelComplaintsPendingValue.setText(String
					.valueOf(TheMain.global_db.select("items", "status",
							"Pending", "").length));
			GridBagConstraints gridBagConstraints20 = new GridBagConstraints();
			gridBagConstraints20.gridx = 0;
			gridBagConstraints20.gridy = 2;
			jLabelComplaintsPending = new JLabel();
			jLabelComplaintsPending.setText("Pending:");
			GridBagConstraints gridBagConstraints9 = new GridBagConstraints();
			gridBagConstraints9.gridx = 0;
			gridBagConstraints9.gridy = 1;
			GridBagConstraints gridBagConstraints8 = new GridBagConstraints();
			gridBagConstraints8.gridx = 1;
			gridBagConstraints8.gridy = 1;
			GridBagConstraints gridBagConstraints4 = new GridBagConstraints();
			gridBagConstraints4.gridx = 0;
			gridBagConstraints4.gridwidth = 2;
			gridBagConstraints4.gridy = 0;
			jPanelComplaints = new JPanel();
			jPanelComplaints.setLayout(new GridBagLayout());
			jPanelComplaints.setSize(new java.awt.Dimension(214, 213));
			jPanelComplaints.add(getJLabelComplaints(), gridBagConstraints4);
			jPanelComplaints.add(getJLabelNumOfComplaintsValue(),
					gridBagConstraints8);
			jPanelComplaints.add(getJLabelNumOfComplaints(),
					gridBagConstraints9);
			jPanelComplaints.add(jLabelComplaintsPending, gridBagConstraints20);
			jPanelComplaints.add(jLabelComplaintsPendingValue,
					gridBagConstraints22);
			jPanelComplaints
					.add(jLabelComplaintsApproved, gridBagConstraints23);
			jPanelComplaints.add(jLabelComplaintsApprovedValue,
					gridBagConstraints24);
		}
		return jPanelComplaints;
	}

	private JLabel getJLabelItems() {
		if (jLabelItems == null) {
			jLabelItems = new JLabel();
			jLabelItems.setText("Items");
		}
		return jLabelItems;
	}

	private JLabel getJLabelTransactions() {
		if (jLabelTransactions == null) {
			jLabelTransactions = new JLabel();
			jLabelTransactions.setText("Transactions");
		}
		return jLabelTransactions;
	}

	private JLabel getJLabelComplaints() {
		if (jLabelComplaints == null) {
			jLabelComplaints = new JLabel();
			jLabelComplaints.setText("Complaints");
		}
		return jLabelComplaints;
	}

}
