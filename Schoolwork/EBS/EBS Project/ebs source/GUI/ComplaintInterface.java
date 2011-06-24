package GUI;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.io.IOException;

import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTextArea;

import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import system.complaint;

public class ComplaintInterface extends JFrame {

	private static final long serialVersionUID = 1L;

	private JPanel jContentPane = null;

	private ButtonGroup radioButtonGroup = null;

	private JRadioButton userRadioButton = null;

	private JRadioButton itemRadioButton = null;

	private JLabel complaintAgainstLabel = null;

	private JLabel itemNumberLabel = null;

	private JLabel itemTitleLabel = null;

	private JLabel itemNumberDataLabel = null;

	private JLabel itemTitleDataLabel = null;

	private JTextArea complaintTextArea = null;

	private JLabel complaintLabel = null;

	private JButton submitButton = null;

	private String user_ID = null;

	private String item_ID = null;

	private String type = null;

	private String complaintText = null;

	private String title = null;

	private int userOrItem_id = 0;

	private int complainer_id = 0;

	private SubmitButtonListener submitButtonListener = new SubmitButtonListener();

	private radioButtonListener RadioButtonListener = new radioButtonListener();

	private ComplaintTextArea complaintTA = new ComplaintTextArea();

	private Element item_info;

	public ComplaintInterface(String user_ID, String item_ID) {
		// check the type and set the userOrItem_id appropriately
		// if the type is item, then the item id is what you want

		this.user_ID = user_ID;
		this.item_ID = item_ID;
		title = getItemTitle();

		add(getJContentPane());
		setSize(300, 400);
		setTitle("Submit Complaint Form");
		setResizable(false);
		setVisible(true);

		submitButton.addActionListener(submitButtonListener);
		radioButtonGroup = getRadioButtonGroup();

		complaintTextArea.addFocusListener(complaintTA);
	}

	// Gets the title of the auction
	private String getItemTitle() {
		// Gets all the information on the item
		item_info = TheMain.global_db.select("items", "id", item_ID);
		String toText = null;

		// Retrieves the title from the nodelist
		NodeList node1 = item_info.getElementsByTagName("title");

		if (node1 != null && node1.getLength() > 0) {
			Element element = (Element) node1.item(0);
			toText = element.getFirstChild().getNodeValue();

		}

		return toText;
	}

	// This clears JTextArea if the error message is there
	private class ComplaintTextArea implements FocusListener {
		public void focusGained(FocusEvent arg0) {
			if (complaintTextArea.getText().equals(
					"You must submit an explaination.")) {
				complaintTextArea.setText("");
			}
		}

		public void focusLost(FocusEvent arg0) {
		}
	}

	// This sets either the userRadioButton or ItemRadioButton, never both.
	private class radioButtonListener implements ActionListener {
		public void actionPerformed(ActionEvent arg0) {
			if (itemRadioButton.hasFocus()) {
				userRadioButton.setSelected(false);
				itemRadioButton.setSelected(true);
			}

			else {
				userRadioButton.setSelected(true);
				itemRadioButton.setSelected(false);
			}
		}//end actionPerformed
	}//end radioButtonListener

	// This gathers all the information and passes it to complaint
	private class SubmitButtonListener implements ActionListener {

		public void actionPerformed(ActionEvent event) {

			if ((complaintTextArea.getText().toString().length() != 0)
					&& !(complaintTextArea.getText()
							.equals("You must submit an explaination."))) {
				if (itemRadioButton.isSelected()) {
					type = "item";
					userOrItem_id = Integer.parseInt(item_ID);
				} else {
					type = "user";
					userOrItem_id = Integer.parseInt(user_ID);
				}
				complainer_id = Integer.parseInt(TheMain.global_user
						.getInfo("id"));
				complaintText = complaintTextArea.getText().toString();
				complaint c1 = null;

				try {
					c1 = new complaint(type, userOrItem_id, complainer_id,
							complaintText);
					c1.submitComplaint();
					setVisible(false);
				} catch (IOException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else
				complaintTextArea.setText("You must submit an explaination.");
		}

	}

	private JPanel getJContentPane() {
		if (jContentPane == null) {
			GridBagConstraints gridBagConstraints9 = new GridBagConstraints();
			gridBagConstraints9.gridx = 1;
			gridBagConstraints9.gridy = 9;
			GridBagConstraints gridBagConstraints8 = new GridBagConstraints();
			gridBagConstraints8.gridx = 0;
			gridBagConstraints8.gridy = 8;
			GridBagConstraints gridBagConstraints7 = new GridBagConstraints();
			gridBagConstraints7.fill = java.awt.GridBagConstraints.BOTH;
			gridBagConstraints7.gridy = 9;
			gridBagConstraints7.weightx = 1.0;
			gridBagConstraints7.weighty = 1.0;
			gridBagConstraints7.gridx = 0;
			GridBagConstraints gridBagConstraints6 = new GridBagConstraints();
			gridBagConstraints6.gridx = 1;
			gridBagConstraints6.gridy = 6;
			GridBagConstraints gridBagConstraints5 = new GridBagConstraints();
			gridBagConstraints5.gridx = 0;
			gridBagConstraints5.gridy = 6;
			GridBagConstraints gridBagConstraints4 = new GridBagConstraints();
			gridBagConstraints4.gridx = 1;
			gridBagConstraints4.gridy = 2;
			GridBagConstraints gridBagConstraints3 = new GridBagConstraints();
			gridBagConstraints3.gridx = 1;
			gridBagConstraints3.gridy = 1;
			GridBagConstraints gridBagConstraints2 = new GridBagConstraints();
			gridBagConstraints2.gridx = 0;
			gridBagConstraints2.gridy = 3;
			GridBagConstraints gridBagConstraints1 = new GridBagConstraints();
			gridBagConstraints1.gridx = 0;
			gridBagConstraints1.gridy = 2;
			GridBagConstraints gridBagConstraints = new GridBagConstraints();
			gridBagConstraints.gridx = 0;
			gridBagConstraints.gridy = 1;
			jContentPane = new JPanel();
			jContentPane.setLayout(new GridBagLayout());
			jContentPane.add(getComplaintAgainstLabel(), gridBagConstraints);
			jContentPane.add(getUserRadioButton(), gridBagConstraints1);
			jContentPane.add(getItemRadioButton(), gridBagConstraints2);
			jContentPane.add(getItemNumberLabel(), gridBagConstraints3);
			jContentPane.add(getItemNumberDataLabel(), gridBagConstraints4);
			jContentPane.add(getItemTitleLabel(), gridBagConstraints5);
			jContentPane.add(getItemTitleDataLabel(), gridBagConstraints6);
			jContentPane.add(getComplaintTextArea(), gridBagConstraints7);
			jContentPane.add(getComplaintLabel(), gridBagConstraints8);
			jContentPane.add(getSubmitButton(), gridBagConstraints9);
			getUserRadioButton().setSelected(true);
		}
		return jContentPane;
	}

	private ButtonGroup getRadioButtonGroup() {
		if (radioButtonGroup == null) {
			radioButtonGroup = new ButtonGroup();
			radioButtonGroup.add(userRadioButton);
			radioButtonGroup.add(itemRadioButton);
		}
		return radioButtonGroup;
	}

	private JRadioButton getUserRadioButton() {
		if (userRadioButton == null) {
			userRadioButton = new JRadioButton();
			userRadioButton.setText("User");
		}
		return userRadioButton;
	}

	private JRadioButton getItemRadioButton() {
		if (itemRadioButton == null) {
			itemRadioButton = new JRadioButton();
			itemRadioButton.setText("Item");
		}
		return itemRadioButton;
	}

	private JLabel getComplaintAgainstLabel() {
		if (complaintAgainstLabel == null) {
			complaintAgainstLabel = new JLabel();
			complaintAgainstLabel.setText("Complaint Against:");
		}
		return complaintAgainstLabel;
	}

	private JLabel getItemNumberLabel() {
		if (itemNumberLabel == null) {
			itemNumberLabel = new JLabel();
			itemNumberLabel.setText("Item #:");
		}
		return itemNumberLabel;
	}

	private JLabel getItemTitleLabel() {
		if (itemTitleLabel == null) {
			itemTitleLabel = new JLabel();
			itemTitleLabel.setText("Item Title:");
		}
		return itemTitleLabel;
	}

	private JLabel getItemNumberDataLabel() {
		if (itemNumberDataLabel == null) {
			itemNumberDataLabel = new JLabel();
			itemNumberDataLabel.setText(item_ID);
		}
		return itemNumberDataLabel;
	}

	private JLabel getItemTitleDataLabel() {
		if (itemTitleDataLabel == null) {
			itemTitleDataLabel = new JLabel();
			itemTitleDataLabel.setText(title);
		}
		return itemTitleDataLabel;
	}

	private JTextArea getComplaintTextArea() {
		if (complaintTextArea == null) {
			complaintTextArea = new JTextArea();
			complaintTextArea.setWrapStyleWord(true);
			complaintTextArea.setLineWrap(true);
		}
		return complaintTextArea;
	}

	private JLabel getComplaintLabel() {
		if (complaintLabel == null) {
			complaintLabel = new JLabel();
			complaintLabel.setText("Complaint:");
		}
		return complaintLabel;
	}

	private JButton getSubmitButton() {
		if (submitButton == null) {
			submitButton = new JButton();
			submitButton.setText("Submit");
		}
		return submitButton;
	}
}
