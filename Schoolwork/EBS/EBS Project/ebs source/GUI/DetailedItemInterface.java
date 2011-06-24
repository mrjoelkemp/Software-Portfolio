package GUI;

import java.awt.Dimension;
import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.awt.Insets;

import javax.swing.ImageIcon;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JTextField;

import com.sun.org.apache.xalan.internal.xsltc.compiler.util.TestGenerator;

import system.*;

import java.awt.GridBagConstraints;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.util.Calendar;

public class DetailedItemInterface extends JPanel {

	private static final long serialVersionUID = 1L;

	private JPanel pnlButton = null;

	private JButton btnPlaceBid = null;

	private JButton btnWithdrawItem = null;

	private JButton btnRepostItem = null;

	private JButton btnArchive = null;

	private JPanel pnlBid = null;

	private JLabel lblNumberOfBids = null;

	private JLabel lblNumberOfBidsValue = null;

	private JLabel lblCurrentPrice = null;

	private JLabel lblCurrentPriceValue = null;

	private JTextField txtBidAmount = null;

	private JLabel lblYourBid = null;

	private JPanel pnlItemDetails = null;

	private JLabel lblTitle = null;

	private JLabel lblDescription = null;

	private JLabel lblTitleValue = null;

	private JLabel lblDescriptionValue = null;

	private JButton btnImage = null;

	private item currentItem = null;

	private JLabel lblStartingPrice = null;

	private JLabel lblStartingPriceValue = null;

	private JButton btnSubmitComplaint = null;

	private JLabel jLabelNotice = null;

	private JPanel jPanelContainer = null;

	private JLabel jLabelNotice2 = null;

	private JButton btnSell = null;  //  @jve:decl-index=0:visual-constraint="553,17"

	public DetailedItemInterface() {
		setLayout(new GridBagLayout());
		GridBagConstraints gbc = new GridBagConstraints();

		gbc.gridx = 0;
		gbc.gridy = 0;
		add(getPnlItemDetails(), gbc);
		gbc.gridy = 1;
		add(getJPanelContainer(), gbc);

		setPreferredSize(new Dimension(900, 200));

	}

	private class complaintButtonListener implements ActionListener {
		public void actionPerformed(ActionEvent arg0) {
			TheMain.showComplaintInterface(currentItem.getInfo("user_id"),
					currentItem.getInfo("id"));
		}
	}// end complaintButtonListener

	private class archiveButtonListener implements ActionListener {

		public void actionPerformed(ActionEvent arg0) {
			currentItem.setInfo("status", "Archived");
			try {
				currentItem.update();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
//			 Reload the item information after a sucessful bid
			setCurrentItem(Integer.parseInt(currentItem.getInfo("id")));

			
		}
	}// end archiveButtonListener

	private class sellButtonListener implements ActionListener {

		public void actionPerformed(ActionEvent arg0) {
			currentItem.setInfo("status", "Finished");
			try {
				currentItem.update();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
//			 Reload the item information after a sucessful bid
			setCurrentItem(Integer.parseInt(currentItem.getInfo("id")));

		}
	}// end archiveButtonListener

	private class repostButtonListener implements ActionListener {

		public void actionPerformed(ActionEvent arg0) {
			// Change start time to now, end time to 7 days
			// Change currentPrice to starting price
			long tempStartTime = Calendar.getInstance().getTimeInMillis();
			long tempEndTime = tempStartTime + (7 * 86400000);
			currentItem.setInfo("startTime", String.valueOf(tempStartTime));
			currentItem.setInfo("endTime", String.valueOf(tempEndTime));
			currentItem.setInfo("currentPrice", currentItem
					.getInfo("startPrice"));

			// Set type of all the item's bids to status = "Bid (Item
			// Withdrawn)"
			currentItem.setInfo("status", "Approved");
			try {
				currentItem.update();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
//			 Reload the item information after a sucessful bid
			setCurrentItem(Integer.parseInt(currentItem.getInfo("id")));

		}
	}// end repostButtonListener

	private class withdrawButtonListener implements ActionListener {
		public void actionPerformed(ActionEvent arg0) {
			currentItem.setInfo("status", "Withdrawn");
			try {
				currentItem.update();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}

			// Change status of bids
			String[] updateFields = { "type" };
			String[] updateValues = { "Bid (Item Withdrawn)" };

			try {
				updateManyObjects("transaction", "item_id", currentItem
						.getInfo("id"), updateFields, updateValues);

			} catch (IOException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
//			 Reload the item information after a sucessful bid
			setCurrentItem(Integer.parseInt(currentItem.getInfo("id")));

		}// end actionPerformed
	}// end withdrawButtonListener

	private class placeBidButtonListener implements ActionListener {
		public void actionPerformed(ActionEvent arg0) {

			// Make sure that the input is a whole number
			long currentTime = Calendar.getInstance().getTimeInMillis();
			long itemEndTime = Long.parseLong(currentItem.getInfo("endTime"));
			String input = txtBidAmount.getText();
			long currentPrice = Long.parseLong(currentItem
					.getInfo("currentPrice"));

			// If it's not all digits or larger than 999999999999999999 (max
			// long is 9223372036854775807)
			if (!input.matches("\\d{1,18}")) {
				JOptionPane
						.showMessageDialog(
								null,
								"Please enter a whole dollar value without punctuation less than 999999999999999999. E.G.: \"4\" or \"246\".");
				txtBidAmount.setText("");
			}
			// Make sure the bid is higher than the current price for the item
			else if (Long.parseLong(input) <= currentPrice) {
				JOptionPane.showMessageDialog(null,
						"Please enter a bid larger than the current price.");
				txtBidAmount.setText("");
			}
			// CHeck that the item hasn't ended yet
			else if (itemEndTime < currentTime) {
				JOptionPane.showMessageDialog(null,
						"This item is no longer available.");
				txtBidAmount.setText("");
			} else {
				// Get the bid into the right type
				@SuppressWarnings("unused")
				long attemptedBid = Long.valueOf(input);

				try {
					currentItem.bid(Long.valueOf(txtBidAmount.getText()));
				} catch (NumberFormatException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}

				// Reload the item information after a sucessful bid
				setCurrentItem(Integer.parseInt(currentItem.getInfo("id")));

			} // END if
		}// end actionPerformed
	}// end placeBidButtonListener

	private void clearFields() {
		lblTitleValue.setText("");
		lblDescriptionValue.setText("");
		lblNumberOfBidsValue.setText("");
		lblStartingPriceValue.setText("");
		lblCurrentPriceValue.setText("");
		txtBidAmount.setText("");
	}

	private void hideAllButtons() {
		btnArchive.setVisible(false);
		btnPlaceBid.setEnabled(false);
		btnImage.setIcon(new ImageIcon());
		btnRepostItem.setVisible(false);
		btnSubmitComplaint.setVisible(false);
		btnWithdrawItem.setVisible(false);
	}

	public void setCurrentItem(int item_id) {
		// clear everything all the time
		clearFields();
		hideAllButtons();

		if (item_id == 0) {
		} else {
			// get the current item
			currentItem = new item(TheMain.global_db.select("items", "id", ""
					+ item_id, ""));

//			 Display the current item's details
			lblTitleValue.setText(currentItem.getInfo("title"));
			lblDescriptionValue.setText(currentItem.getInfo("description"));
			lblStartingPriceValue.setText("$ "
					+ currentItem.getInfo("startPrice"));
			lblCurrentPriceValue.setText("$ "
					+ currentItem.getInfo("currentPrice"));

			// Get the current number of bids for the item
			String[][] numOfBidsResult = TheMain.global_db.select(
					"transactions", "item_id", "" + item_id, "");
			lblNumberOfBidsValue.setText("" + numOfBidsResult.length);

			btnImage.setIcon(new ImageIcon(currentItem
					.getInfo("pictureFileName")));
			
			// Set visibility of buttons
			// Bid button inactive when the auction has ended
			long currentTimeStamp = Calendar.getInstance().getTimeInMillis();
			long itemEndTimeStamp = Long.parseLong(currentItem
					.getInfo("endTime"));

			String currentItemOwner = currentItem.getInfo("user_id");
			String currentUser = TheMain.global_user.getInfo("id");
			
			boolean currentUserIsOwner;
			boolean itemHasEnded;
			
			if ( currentUser.equalsIgnoreCase(currentItemOwner))
				currentUserIsOwner = true;
			else 
				currentUserIsOwner = false;

			if (itemEndTimeStamp > currentTimeStamp) 
				itemHasEnded = false;
			else
				itemHasEnded = true;
			
			String itemStatus = currentItem.getInfo("status");
			int numOfBids = Integer.parseInt(lblNumberOfBidsValue.getText());
			boolean userIsSA = false;
			
			// Check if the current user is SA
			if ( TheMain.global_user.getInfo("SA").equalsIgnoreCase("true"))
				 userIsSA = true;
			
			// Submit complaint always available unless the user is the owner of the item
			btnSubmitComplaint.setVisible(true);
			if ( currentUserIsOwner )
				btnSubmitComplaint.setVisible(false);
			
			// Withdraw is available when the item is Approved and the item is current
			// If the item is finished
			btnWithdrawItem.setVisible(false);
			if (itemStatus.equalsIgnoreCase("Approved") && currentUserIsOwner && !itemHasEnded  )
				btnWithdrawItem.setVisible(true);
			
			// Sell is available only

			btnSell.setVisible(false);
			if ( itemStatus.equalsIgnoreCase("Approved") && currentUserIsOwner && !itemHasEnded && (numOfBids > 0))
				btnSell.setVisible(true);
			
//				btnArchive available at all times to SA
			btnArchive.setVisible(false);
			if (userIsSA)
				btnArchive.setVisible(true);
				
			
//			btnRepostItem
			btnRepostItem.setVisible(false);
			if ( itemStatus.equalsIgnoreCase("Withdrawn") && currentUserIsOwner )
				btnRepostItem.setVisible(true);

			//				btnPlaceBid
			btnPlaceBid.setEnabled(false);
			if ( !currentUserIsOwner && !itemHasEnded && itemStatus.equalsIgnoreCase("Approved") )
				btnPlaceBid.setEnabled(true);
		}
	}

	private JPanel getPnlButton() {
		if (pnlButton == null) {
			pnlButton = new JPanel();
			pnlButton.setLayout(new GridBagLayout());
			GridBagConstraints gbc = new GridBagConstraints();
			gbc.gridx = 0;
			gbc.gridy = 0;
			gbc.insets = new Insets(5, 5, 5, 5);
			gbc.fill = GridBagConstraints.NONE;
			pnlButton.setSize(new java.awt.Dimension(194, 181));
			
			pnlButton.add(getBtnSell(), gbc);
			gbc.gridy = 1;
			pnlButton.add(getBtnSubmitComplaint(), gbc);
			gbc.gridy = 2;
			pnlButton.add(getBtnWithdrawItem(), gbc);
			gbc.gridy = 3;
			pnlButton.add(getBtnArchive(), gbc);
			gbc.gridy = 4;
			pnlButton.add(getBtnRepostItem(), gbc);
		}
		return pnlButton;
	}

	private JButton getBtnPlaceBid() {
		if (btnPlaceBid == null) {
			btnPlaceBid = new JButton();
			btnPlaceBid.setText("Place Bid");
			btnPlaceBid.setEnabled(false);
			btnPlaceBid.addActionListener(new placeBidButtonListener());
		}
		return btnPlaceBid;
	}

	private JButton getBtnWithdrawItem() {
		if (btnWithdrawItem == null) {
			btnWithdrawItem = new JButton();
			btnWithdrawItem.setText("Withdraw Item");
			btnWithdrawItem.setPreferredSize(new Dimension(150, 30));
			btnWithdrawItem.addActionListener(new withdrawButtonListener());
			btnWithdrawItem.setVisible(false);
		}
		return btnWithdrawItem;
	}

	private JButton getBtnRepostItem() {
		if (btnRepostItem == null) {
			btnRepostItem = new JButton();
			btnRepostItem.setText("Repost Item");
			btnRepostItem.setPreferredSize(new Dimension(150, 30));
			btnRepostItem.addActionListener(new repostButtonListener());
			btnRepostItem.setVisible(false);
		}
		return btnRepostItem;
	}

	private JButton getBtnArchive() {
		if (btnArchive == null) {
			btnArchive = new JButton();
			btnArchive.setText("Archive Item");
			btnArchive.setPreferredSize(new Dimension(150, 30));
			btnArchive.addActionListener(new archiveButtonListener());
			btnArchive.setVisible(false);
		}
		return btnArchive;
	}

	private JPanel getPnlBid() {
		if (pnlBid == null) {
			GridBagConstraints gridBagConstraints23 = new GridBagConstraints();
			gridBagConstraints23.gridx = 0;
			gridBagConstraints23.gridwidth = 11;
			gridBagConstraints23.gridy = 1;
			jLabelNotice2 = new JLabel();
			jLabelNotice2.setText("greater than the current price");
			GridBagConstraints gridBagConstraints13 = new GridBagConstraints();
			gridBagConstraints13.gridx = 0;
			gridBagConstraints13.gridwidth = 11;
			gridBagConstraints13.gridy = 0;
			GridBagConstraints gridBagConstraints22 = new GridBagConstraints();
			gridBagConstraints22.gridx = 4;
			gridBagConstraints22.gridy = 3;
			gridBagConstraints22.anchor = GridBagConstraints.LINE_START;
			GridBagConstraints gridBagConstraints12 = new GridBagConstraints();
			gridBagConstraints12.gridx = 0;
			gridBagConstraints12.gridy = 3;
			gridBagConstraints12.anchor = GridBagConstraints.LINE_END;
			gridBagConstraints12.insets = new Insets(0, 10, 0, 0);
			GridBagConstraints gridBagConstraints5 = new GridBagConstraints();
			gridBagConstraints5.gridx = 5;
			gridBagConstraints5.gridwidth = 6;
			gridBagConstraints5.gridy = 8;
			GridBagConstraints gridBagConstraints4 = new GridBagConstraints();
			gridBagConstraints4.gridy = 8;
			gridBagConstraints4.weightx = 1.0;
			gridBagConstraints4.gridwidth = 1;
			gridBagConstraints4.gridx = 4;
			gridBagConstraints4.anchor = GridBagConstraints.LINE_START;
			GridBagConstraints gridBagConstraints21 = new GridBagConstraints();
			gridBagConstraints21.gridx = 0;
			gridBagConstraints21.gridy = 8;
			gridBagConstraints21.anchor = GridBagConstraints.LINE_END;
			GridBagConstraints gridBagConstraints11 = new GridBagConstraints();
			gridBagConstraints11.gridx = 4;
			gridBagConstraints11.gridy = 4;
			gridBagConstraints11.anchor = GridBagConstraints.LINE_START;
			GridBagConstraints gridBagConstraints2 = new GridBagConstraints();
			gridBagConstraints2.gridx = 0;
			gridBagConstraints2.gridy = 4;
			gridBagConstraints2.anchor = GridBagConstraints.LINE_END;
			GridBagConstraints gridBagConstraints1 = new GridBagConstraints();
			gridBagConstraints1.gridx = 4;
			gridBagConstraints1.gridy = 2;
			gridBagConstraints1.anchor = GridBagConstraints.LINE_START;
			GridBagConstraints gridBagConstraints = new GridBagConstraints();
			gridBagConstraints.gridx = 0;
			gridBagConstraints.gridy = 2;
			gridBagConstraints.anchor = GridBagConstraints.LINE_END;
			pnlBid = new JPanel();
			pnlBid.setLayout(new GridBagLayout());
			pnlBid.setSize(new java.awt.Dimension(288, 200));
			pnlBid.setPreferredSize(new Dimension(200, 150));
			pnlBid.add(getJLabelNotice(), gridBagConstraints13);
			pnlBid.add(getLblNumberOfBids(), gridBagConstraints);
			pnlBid.add(getLblNumberOfBidsValue(), gridBagConstraints1);
			pnlBid.add(getLblCurrentPrice(), gridBagConstraints2);
			pnlBid.add(getLblCurrentPriceValue(), gridBagConstraints11);
			pnlBid.add(getLblYourBid(), gridBagConstraints21);
			pnlBid.add(getTxtBidAmount(), gridBagConstraints4);
			pnlBid.add(getBtnPlaceBid(), gridBagConstraints5);
			pnlBid.add(getLblStartingPrice(), gridBagConstraints12);
			pnlBid.add(getLblStartingPriceValue(), gridBagConstraints22);
			pnlBid.add(jLabelNotice2, gridBagConstraints23);
		}
		return pnlBid;
	}

	private JLabel getLblNumberOfBids() {
		if (lblNumberOfBids == null) {
			lblNumberOfBids = new JLabel();
			lblNumberOfBids.setText("# Bids:  ");
		}
		return lblNumberOfBids;
	}

	private JLabel getLblNumberOfBidsValue() {
		if (lblNumberOfBidsValue == null) {
			lblNumberOfBidsValue = new JLabel();
			lblNumberOfBidsValue.setText("");
		}
		return lblNumberOfBidsValue;
	}

	private JLabel getLblCurrentPrice() {
		if (lblCurrentPrice == null) {
			lblCurrentPrice = new JLabel();
			lblCurrentPrice.setText("Current Price:  ");
		}
		return lblCurrentPrice;
	}

	private JLabel getLblCurrentPriceValue() {
		if (lblCurrentPriceValue == null) {
			lblCurrentPriceValue = new JLabel();
			lblCurrentPriceValue.setText("");
		}
		return lblCurrentPriceValue;
	}

	private JTextField getTxtBidAmount() {
		if (txtBidAmount == null) {
			txtBidAmount = new JTextField();
			txtBidAmount.setPreferredSize(new Dimension(60, 20));
			txtBidAmount.setSize(new Dimension(80, 20));
		}
		return txtBidAmount;
	}

	private JLabel getLblYourBid() {
		if (lblYourBid == null) {
			lblYourBid = new JLabel();
			lblYourBid.setText("Your Bid:  ");
		}
		return lblYourBid;
	}

	private JPanel getPnlItemDetails() {
		if (pnlItemDetails == null) {
			GridBagConstraints gridBagConstraints8 = new GridBagConstraints();
			gridBagConstraints8.gridx = 1;
			gridBagConstraints8.gridy = 1;
			gridBagConstraints8.anchor = GridBagConstraints.LINE_START;
			GridBagConstraints gridBagConstraints7 = new GridBagConstraints();
			gridBagConstraints7.gridx = 1;
			gridBagConstraints7.gridy = 0;
			gridBagConstraints7.anchor = GridBagConstraints.LINE_START;
			GridBagConstraints gridBagConstraints6 = new GridBagConstraints();
			gridBagConstraints6.gridx = 0;
			gridBagConstraints6.gridy = 1;
			gridBagConstraints6.anchor = GridBagConstraints.LINE_END;
			GridBagConstraints gridBagConstraints3 = new GridBagConstraints();
			gridBagConstraints3.gridx = 0;
			gridBagConstraints3.gridy = 0;
			gridBagConstraints3.anchor = GridBagConstraints.LINE_END;
			pnlItemDetails = new JPanel();
			pnlItemDetails.setLayout(new GridBagLayout());
			pnlItemDetails.setSize(new java.awt.Dimension(900, 80));
			pnlItemDetails.setPreferredSize(new java.awt.Dimension(900, 80));
			pnlItemDetails.setMinimumSize(new Dimension(900, 80));
			pnlItemDetails.add(getLblTitle(), gridBagConstraints3);
			pnlItemDetails.add(getLblDescription(), gridBagConstraints6);
			pnlItemDetails.add(getLblTitleValue(), gridBagConstraints7);
			pnlItemDetails.add(getLblDescriptionValue(), gridBagConstraints8);
		}
		return pnlItemDetails;
	}

	private JLabel getLblTitle() {
		if (lblTitle == null) {
			lblTitle = new JLabel();
			lblTitle.setText("Title:  ");
		}
		return lblTitle;
	}

	private JLabel getLblDescription() {
		if (lblDescription == null) {
			lblDescription = new JLabel();
			lblDescription.setText("Description:  ");
		}
		return lblDescription;
	}

	private JLabel getLblTitleValue() {
		if (lblTitleValue == null) {
			lblTitleValue = new JLabel();
			lblTitleValue.setText("");
			lblTitleValue.setPreferredSize(new Dimension(650, 20));
		}
		return lblTitleValue;
	}

	private JLabel getLblDescriptionValue() {
		if (lblDescriptionValue == null) {
			lblDescriptionValue = new JLabel();
			lblDescriptionValue.setText("");
		}
		return lblDescriptionValue;
	}

	private JButton getBtnImage() {
		if (btnImage == null) {
			btnImage = new JButton();
			btnImage.setIcon(new ImageIcon());
			btnImage.setMinimumSize(new java.awt.Dimension(300, 120));
			btnImage.disable();
		}
		return btnImage;
	}

	private JLabel getLblStartingPrice() {
		if (lblStartingPrice == null) {
			lblStartingPrice = new JLabel();
			lblStartingPrice.setText("Starting Price:  ");
		}
		return lblStartingPrice;
	}

	private JLabel getLblStartingPriceValue() {
		if (lblStartingPriceValue == null) {
			lblStartingPriceValue = new JLabel();
			lblStartingPriceValue.setText("");
		}
		return lblStartingPriceValue;
	}

	private JButton getBtnSubmitComplaint() {
		if (btnSubmitComplaint == null) {
			btnSubmitComplaint = new JButton();
			btnSubmitComplaint.setText("Submit Complaint");
			btnSubmitComplaint.setPreferredSize(new Dimension(150, 30));
			btnSubmitComplaint.setVisible(false);
			btnSubmitComplaint.addActionListener(new complaintButtonListener());
		}
		return btnSubmitComplaint;
	}

	private void updateManyObjects(String type, String matchField,
			String matchValue, String[] updateFields, String[] updateValues)
			throws IOException, Exception {
		Object workingObject = null;

		// Get the objects to update
		String[][] data = TheMain.global_db.select(type + "s", matchField,
				matchValue, "");

		int n = data.length;

		for (int i = 0; i < n; i++) {
			// Create an object for each entry
			if (type.equalsIgnoreCase("user")) {
				workingObject = new user(TheMain.global_db.select("users",
						"id", data[i][0], ""));

				// Update each field in updateFields with each value in
				// updateValue
				for (int j = 0; j < updateFields.length; j++) {
					((user) workingObject).setInfo(updateFields[j],
							updateValues[j]);
				}
				// Save the changes
				((user) workingObject).update();
			} else if (type.equalsIgnoreCase("item")) {
				workingObject = new item(TheMain.global_db.select("items",
						"id", data[i][0], ""));

				// Update each field in updateFields with each value in
				// updateValue
				for (int j = 0; j < updateFields.length; j++) {
					((item) workingObject).setInfo(updateFields[j],
							updateValues[j]);
				}
				// Save the changes
				((item) workingObject).update();

			} else if (type.equalsIgnoreCase("complaint")) {
				workingObject = new complaint(TheMain.global_db.select(
						"complaints", "id", data[i][0], ""));

				// Update each field in updateFields with each value in
				// updateValue
				for (int j = 0; j < updateFields.length; j++) {
					((complaint) workingObject).setInfo(updateFields[j],
							updateValues[j]);
				}
				// Save the changes
				((complaint) workingObject).update();

			} else if (type.equalsIgnoreCase("transaction")) {
				workingObject = new transaction(TheMain.global_db.select(
						"transactions", "id", data[i][0], ""));

				// Update each field in updateFields with each value in
				// updateValue
				for (int j = 0; j < updateFields.length; j++) {
					((transaction) workingObject).setInfo(updateFields[j],
							updateValues[j]);
				}
				// Save the changes
				((transaction) workingObject).update();
			}
		}// end -for loop
	}// end updateManyObjects

	private JLabel getJLabelNotice() {
		if (jLabelNotice == null) {
			jLabelNotice = new JLabel();
			jLabelNotice.setText("Please enter a whole dollar amount");
		}
		return jLabelNotice;
	}

	private JPanel getJPanelContainer() {
		if (jPanelContainer == null) {
			jPanelContainer = new JPanel();
			jPanelContainer.setLayout(new GridLayout(1, 3));
			jPanelContainer.add(getBtnImage());
			jPanelContainer.add(getPnlBid());
			jPanelContainer.add(getPnlButton());
			jPanelContainer.setSize(new java.awt.Dimension(793, 194));
		}
		return jPanelContainer;
	}

	/**
	 * This method initializes btnSell	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnSell() {
		if (btnSell == null) {
			btnSell = new JButton();
			btnSell.setPreferredSize(new Dimension(150, 30));
			btnSell.addActionListener(new sellButtonListener());
			btnSell.setVisible(false);
			btnSell.setText("Sell Now");
		}
		return btnSell;
	}
}
