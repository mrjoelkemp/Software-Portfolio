package GUI;

import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

public class AccountInterface extends JPanel {

	private static final long serialVersionUID = 1L;

	private JPanel jPanel = null;

	private JLabel firstNameLabel = null;

	private JLabel lastNameLabel = null;

	private JLabel addressLabel = null;

	private JLabel cityLabel = null;

	private JLabel stateLabel = null;

	private JLabel zipCodeLabel = null;

	private JTextField firstNameTextField = null;

	private JTextField lastNameTextField = null;

	private JTextField addressTextField = null;

	private JTextField cityTextField = null;

	private JTextField stateTextField = null;

	private JTextField zipCodeTextField = null;

	private JButton updateInfoButton = null;

	private JButton changePasswordButton = null;

	private JPasswordField currentPasswordField = null;

	private JPasswordField newPasswordField = null;

	private JPasswordField confirmNewPasswordField = null;

	private JLabel currentPasswordLabel = null;

	private JLabel newPasswordLabel = null;

	private JLabel confirmNewPasswordLabel = null;

	private JLabel creditCardLabel = null;

	private JTextField creditCardTextField = null;

	private JLabel phoneNumberLabel = null;

	private JTextField phoneNumberTextField = null;

	private JLabel userNameLabel = null;

	private JTextField userNameTextField = null;

	private String newPassword = new String();

	private UpdateButtonListener buttonPressedListener = new UpdateButtonListener();

	private PasswordButtonListener passwordButtonPressedListener = new PasswordButtonListener();

	private JLabel emailLabel = null;

	private JTextField emailAddressTextField = null;

	private JLabel errorLabel = null;

	public AccountInterface() {
		add(getJPanel());

		updateInfoButton.addActionListener(buttonPressedListener);
		changePasswordButton.addActionListener(passwordButtonPressedListener);

	}

	private class PasswordButtonListener implements ActionListener {

		public void actionPerformed(ActionEvent event) {

			/*
			 * IF: 
			 * 		The current password is the actual current password
			 * 		The "new password" password matches the "confirm new password" password
			 */
			if (parsePassword()) {

				//Change the current user's password information
				TheMain.global_user.setInfo("password", newPassword);
				try {

					//Update the user information in the database.
					TheMain.global_user.update();

					//Show confirmation message
					JOptionPane.showMessageDialog(null,
							"Password Change Successful!");

					//Clear the password fields
					currentPasswordField.setText("");
					newPasswordField.setText("");
					confirmNewPasswordField.setText("");

				} catch (IOException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}//end if	

		}//end ActionPerformed
	}//end PasswordButtonListener

	private class UpdateButtonListener implements ActionListener {
		public void actionPerformed(ActionEvent event) {
			// If all the fields are valid
			if (parseFields()) {
				try {
					//Set the current user info to the new info
					setAllFields();

					//Update the user information
					TheMain.global_user.update();

					JOptionPane.showMessageDialog(null,
							"User Information Change Successful!");

				} catch (IOException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}// end if
		}// end actionPerformed
	}// end PressedButtonListener

	public void setAllFields() {
		//Put the new values into the current user from the interface

		TheMain.global_user.setInfo("firstName", firstNameTextField.getText());
		TheMain.global_user.setInfo("lastName", lastNameTextField.getText());
		TheMain.global_user.setInfo("address", addressTextField.getText());
		TheMain.global_user.setInfo("city", cityTextField.getText());
		TheMain.global_user.setInfo("state", stateTextField.getText());
		TheMain.global_user.setInfo("zipCode", zipCodeTextField.getText());
		TheMain.global_user.setInfo("phoneNumber", phoneNumberTextField
				.getText());
		TheMain.global_user.setInfo("emailAddress", emailAddressTextField
				.getText());
		TheMain.global_user
				.setInfo("creditCard", creditCardTextField.getText());

	}//end setAllFields

	public boolean parsePassword() {
		char[] currPass = currentPasswordField.getPassword();
		char[] newPass = newPasswordField.getPassword();
		char[] confirmNewPass = confirmNewPasswordField.getPassword();
		String currPassString = new String();

		currentPasswordLabel.setForeground(Color.BLACK);

		//Keep track if new password and confirm new password match
		boolean passesEqual = true;

		//Gather the entered current password
		for (int i = 0; i < currPass.length; i++)
			currPassString = currPassString + currPass[i];

		//If provided current password is not equal to the actual current password
		if (!currPassString.equals(TheMain.global_user.getInfo("password"))) {
			//Highlight the incorrect field
			currentPasswordLabel.setForeground(Color.RED);
			return false;
		}

		//Collect the password from the char array
		for (int i = 0; i < newPass.length; i++) {

			//If any char of the new password and confirm new password do not match
			if (newPass[i] != confirmNewPass[i]) {
				//then return false
				passesEqual = false;
				break;
			}
			//else gather the new password
			else
				newPassword = newPassword + newPass[i];
		}

		return passesEqual;
	}

	public boolean parseFields() {
		/*
		 * If we see an invalid field then we must return false (parsing failed).
		 * Otherwise we return true (parse success).
		 * 
		 * Steps:
		 * 0. Reset the foreground colors of the labels used in parsing.
		 * 1. Check if text matches regular expression.
		 * 2. If not, then set the foreground of the label to RED
		 * 3. Set invalidField to true (noting that we have found an error)
		 */
		boolean invalidField = false;

		/* Reset the color of the labels */

		creditCardLabel.setForeground(Color.BLACK);
		zipCodeLabel.setForeground(Color.BLACK);
		phoneNumberLabel.setForeground(Color.BLACK);
		errorLabel.setForeground(Color.RED);
		errorLabel.setText("");

		/* Parse specific Fields */

		if (!creditCardTextField.getText().matches("(\\d{16})?")) {
			creditCardLabel.setForeground(Color.RED);
			invalidField = true;
			errorLabel.setText("Please correct the fields in red!");
		}

		if (!zipCodeTextField.getText().matches("\\d{5}")) {
			zipCodeLabel.setForeground(Color.RED);
			invalidField = true;
			errorLabel.setText("Please correct the fields in red!");
		}

		if (!phoneNumberTextField.getText().matches("\\d{3}-?\\d{3}-?\\d{4}")) {
			phoneNumberLabel.setForeground(Color.RED);
			invalidField = true;
			errorLabel.setText("Please correct the fields in red!");
		}

		return !invalidField;
	}

	private JPanel getJPanel() {
		if (jPanel == null) {
			GridBagConstraints gridBagConstraints32 = new GridBagConstraints();
			gridBagConstraints32.gridx = 0;
			gridBagConstraints32.gridwidth = 3;
			gridBagConstraints32.gridy = 20;
			GridBagConstraints gridBagConstraints22 = new GridBagConstraints();
			gridBagConstraints22.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints22.gridy = 10;
			gridBagConstraints22.weightx = 1.0;
			gridBagConstraints22.gridx = 2;
			GridBagConstraints gridBagConstraints111 = new GridBagConstraints();
			gridBagConstraints111.gridx = 0;
			gridBagConstraints111.gridy = 10;
			GridBagConstraints gridBagConstraints61 = new GridBagConstraints();
			gridBagConstraints61.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints61.gridy = 0;
			gridBagConstraints61.weightx = 1.0;
			gridBagConstraints61.gridx = 2;
			GridBagConstraints gridBagConstraints51 = new GridBagConstraints();
			gridBagConstraints51.gridx = 0;
			gridBagConstraints51.gridy = 0;
			userNameLabel = new JLabel();
			userNameLabel.setText("Username");
			GridBagConstraints gridBagConstraints41 = new GridBagConstraints();
			gridBagConstraints41.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints41.gridy = 9;
			gridBagConstraints41.weightx = 1.0;
			gridBagConstraints41.gridx = 2;
			GridBagConstraints gridBagConstraints31 = new GridBagConstraints();
			gridBagConstraints31.gridx = 0;
			gridBagConstraints31.gridy = 9;
			phoneNumberLabel = new JLabel();
			phoneNumberLabel.setText("Phone Number");
			GridBagConstraints gridBagConstraints21 = new GridBagConstraints();
			gridBagConstraints21.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints21.gridy = 8;
			gridBagConstraints21.weightx = 1.0;
			gridBagConstraints21.gridx = 2;
			GridBagConstraints gridBagConstraints110 = new GridBagConstraints();
			gridBagConstraints110.gridx = 0;
			gridBagConstraints110.gridy = 8;
			creditCardLabel = new JLabel();
			creditCardLabel.setText("Credit Card");
			GridBagConstraints gridBagConstraints19 = new GridBagConstraints();
			gridBagConstraints19.gridx = 0;
			gridBagConstraints19.gridy = 18;
			GridBagConstraints gridBagConstraints18 = new GridBagConstraints();
			gridBagConstraints18.gridx = 0;
			gridBagConstraints18.gridy = 17;
			GridBagConstraints gridBagConstraints17 = new GridBagConstraints();
			gridBagConstraints17.gridx = 0;
			gridBagConstraints17.gridy = 16;
			GridBagConstraints gridBagConstraints16 = new GridBagConstraints();
			gridBagConstraints16.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints16.gridy = 18;
			gridBagConstraints16.weightx = 1.0;
			gridBagConstraints16.gridx = 2;
			GridBagConstraints gridBagConstraints15 = new GridBagConstraints();
			gridBagConstraints15.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints15.gridy = 17;
			gridBagConstraints15.weightx = 1.0;
			gridBagConstraints15.gridx = 2;
			GridBagConstraints gridBagConstraints7 = new GridBagConstraints();
			gridBagConstraints7.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints7.gridy = 16;
			gridBagConstraints7.weightx = 1.0;
			gridBagConstraints7.gridx = 2;
			GridBagConstraints gridBagConstraints = new GridBagConstraints();
			gridBagConstraints.gridx = 2;
			gridBagConstraints.gridy = 19;
			GridBagConstraints gridBagConstraints14 = new GridBagConstraints();
			gridBagConstraints14.gridx = 2;
			gridBagConstraints14.gridy = 15;
			GridBagConstraints gridBagConstraints13 = new GridBagConstraints();
			gridBagConstraints13.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints13.gridy = 7;
			gridBagConstraints13.weightx = 1.0;
			gridBagConstraints13.gridx = 2;
			GridBagConstraints gridBagConstraints12 = new GridBagConstraints();
			gridBagConstraints12.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints12.gridy = 5;
			gridBagConstraints12.weightx = 1.0;
			gridBagConstraints12.gridx = 2;
			GridBagConstraints gridBagConstraints11 = new GridBagConstraints();
			gridBagConstraints11.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints11.gridy = 4;
			gridBagConstraints11.weightx = 1.0;
			gridBagConstraints11.gridx = 2;
			GridBagConstraints gridBagConstraints10 = new GridBagConstraints();
			gridBagConstraints10.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints10.gridy = 3;
			gridBagConstraints10.weightx = 1.0;
			gridBagConstraints10.gridx = 2;
			GridBagConstraints gridBagConstraints9 = new GridBagConstraints();
			gridBagConstraints9.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints9.gridy = 2;
			gridBagConstraints9.weightx = 1.0;
			gridBagConstraints9.gridx = 2;
			GridBagConstraints gridBagConstraints8 = new GridBagConstraints();
			gridBagConstraints8.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints8.gridy = 1;
			gridBagConstraints8.weightx = 1.0;
			gridBagConstraints8.gridx = 2;
			GridBagConstraints gridBagConstraints6 = new GridBagConstraints();
			gridBagConstraints6.gridx = 0;
			gridBagConstraints6.gridy = 7;
			zipCodeLabel = new JLabel();
			zipCodeLabel.setText("ZIP Code");
			GridBagConstraints gridBagConstraints5 = new GridBagConstraints();
			gridBagConstraints5.gridx = 0;
			gridBagConstraints5.gridy = 5;
			stateLabel = new JLabel();
			stateLabel.setText("State");
			GridBagConstraints gridBagConstraints4 = new GridBagConstraints();
			gridBagConstraints4.gridx = 0;
			gridBagConstraints4.gridy = 4;
			cityLabel = new JLabel();
			cityLabel.setText("City");
			GridBagConstraints gridBagConstraints3 = new GridBagConstraints();
			gridBagConstraints3.gridx = 0;
			gridBagConstraints3.gridy = 3;
			addressLabel = new JLabel();
			addressLabel.setText("Address");
			GridBagConstraints gridBagConstraints2 = new GridBagConstraints();
			gridBagConstraints2.gridx = 0;
			gridBagConstraints2.gridy = 2;
			lastNameLabel = new JLabel();
			lastNameLabel.setText("Last Name");
			GridBagConstraints gridBagConstraints1 = new GridBagConstraints();
			gridBagConstraints1.gridx = 0;
			gridBagConstraints1.gridy = 1;
			firstNameLabel = new JLabel();
			firstNameLabel.setText("First Name");
			jPanel = new JPanel();
			jPanel.setLayout(new GridBagLayout());
			jPanel.add(firstNameLabel, gridBagConstraints1);
			jPanel.add(lastNameLabel, gridBagConstraints2);
			jPanel.add(addressLabel, gridBagConstraints3);
			jPanel.add(cityLabel, gridBagConstraints4);
			jPanel.add(stateLabel, gridBagConstraints5);
			jPanel.add(zipCodeLabel, gridBagConstraints6);
			jPanel.add(getFirstNameTextField(), gridBagConstraints8);
			jPanel.add(getLastNameTextField(), gridBagConstraints9);
			jPanel.add(getAddressTextField(), gridBagConstraints10);
			jPanel.add(getCityTextField(), gridBagConstraints11);
			jPanel.add(getStateTextField(), gridBagConstraints12);
			jPanel.add(getZipCodeTextField(), gridBagConstraints13);
			jPanel.add(getUpdateInformationButton(), gridBagConstraints14);
			jPanel.add(getChangePasswordButton(), gridBagConstraints);
			jPanel.add(getCurrentPasswordField(), gridBagConstraints7);
			jPanel.add(getConfirmNewPasswordField(), gridBagConstraints15);
			jPanel.add(getNewPasswordField(), gridBagConstraints16);
			jPanel.add(getCurrentPasswordLabel(), gridBagConstraints17);
			jPanel.add(getNewPasswordLabel(), gridBagConstraints18);
			jPanel.add(getConfirmNewPasswordLabel(), gridBagConstraints19);
			jPanel.add(creditCardLabel, gridBagConstraints110);
			jPanel.add(getCreditCardTextField(), gridBagConstraints21);
			jPanel.add(phoneNumberLabel, gridBagConstraints31);
			jPanel.add(getPhoneNumberTextField(), gridBagConstraints41);
			jPanel.add(userNameLabel, gridBagConstraints51);
			jPanel.add(getUserNameTextField(), gridBagConstraints61);
			jPanel.add(getEmailLabel(), gridBagConstraints111);
			jPanel.add(getEmailAddressTextField(), gridBagConstraints22);
			jPanel.add(getErrorLabel(), gridBagConstraints32);
		}
		return jPanel;
	}

	private JTextField getFirstNameTextField() {
		if (firstNameTextField == null) {
			firstNameTextField = new JTextField();
			firstNameTextField
					.setText(TheMain.global_user.getInfo("firstName"));
			firstNameTextField.setEditable(false);
		}
		return firstNameTextField;
	}

	private JTextField getLastNameTextField() {
		if (lastNameTextField == null) {
			lastNameTextField = new JTextField();
			lastNameTextField.setText(TheMain.global_user.getInfo("lastName"));
			lastNameTextField.setEditable(false);
		}
		return lastNameTextField;
	}

	private JTextField getAddressTextField() {
		if (addressTextField == null) {
			addressTextField = new JTextField();
			addressTextField.setText(TheMain.global_user.getInfo("address"));
		}
		return addressTextField;
	}

	private JTextField getCityTextField() {
		if (cityTextField == null) {
			cityTextField = new JTextField();
			cityTextField.setText(TheMain.global_user.getInfo("city"));
		}
		return cityTextField;
	}

	private JTextField getStateTextField() {
		if (stateTextField == null) {
			stateTextField = new JTextField();
			stateTextField.setText(TheMain.global_user.getInfo("state"));
		}
		return stateTextField;
	}

	private JTextField getZipCodeTextField() {
		if (zipCodeTextField == null) {
			zipCodeTextField = new JTextField();
			zipCodeTextField.setText(TheMain.global_user.getInfo("zipCode"));
		}
		return zipCodeTextField;
	}

	private JTextField getCreditCardTextField() {
		if (creditCardTextField == null) {
			creditCardTextField = new JTextField();
			creditCardTextField.setText(TheMain.global_user
					.getInfo("creditCard"));
		}
		return creditCardTextField;
	}

	private JTextField getPhoneNumberTextField() {
		if (phoneNumberTextField == null) {
			phoneNumberTextField = new JTextField();
			phoneNumberTextField.setText(TheMain.global_user
					.getInfo("phoneNumber"));
		}
		return phoneNumberTextField;
	}

	private JTextField getUserNameTextField() {
		if (userNameTextField == null) {
			userNameTextField = new JTextField();
			userNameTextField.setEditable(false);
			userNameTextField.setText(TheMain.global_user.getInfo("userName"));
		}
		return userNameTextField;
	}

	private JTextField getEmailAddressTextField() {
		if (emailAddressTextField == null) {
			emailAddressTextField = new JTextField();
			emailAddressTextField.setText(TheMain.global_user
					.getInfo("emailAddress"));
		}
		return emailAddressTextField;
	}

	private JButton getUpdateInformationButton() {
		if (updateInfoButton == null) {
			updateInfoButton = new JButton();
			updateInfoButton.setText("Update Information");
		}
		return updateInfoButton;
	}

	private JButton getChangePasswordButton() {
		if (changePasswordButton == null) {
			changePasswordButton = new JButton();
			changePasswordButton.setText("Change Password");
		}
		return changePasswordButton;
	}

	private JPasswordField getCurrentPasswordField() {
		if (currentPasswordField == null) {
			currentPasswordField = new JPasswordField();
		}
		return currentPasswordField;
	}

	private JPasswordField getNewPasswordField() {
		if (newPasswordField == null) {
			newPasswordField = new JPasswordField();
		}
		return newPasswordField;
	}

	private JPasswordField getConfirmNewPasswordField() {
		if (confirmNewPasswordField == null) {
			confirmNewPasswordField = new JPasswordField();
		}
		return confirmNewPasswordField;
	}

	private JLabel getCurrentPasswordLabel() {
		if (currentPasswordLabel == null) {
			currentPasswordLabel = new JLabel();
			currentPasswordLabel.setText("Current Password");
		}
		return currentPasswordLabel;
	}

	private JLabel getNewPasswordLabel() {
		if (newPasswordLabel == null) {
			newPasswordLabel = new JLabel();
			newPasswordLabel.setText("New Password");
		}
		return newPasswordLabel;
	}

	private JLabel getConfirmNewPasswordLabel() {
		if (confirmNewPasswordLabel == null) {
			confirmNewPasswordLabel = new JLabel();
			confirmNewPasswordLabel.setText("Confirm New Password");
		}
		return confirmNewPasswordLabel;
	}

	private JLabel getEmailLabel() {
		if (emailLabel == null) {
			emailLabel = new JLabel();
			emailLabel.setText("E-mail Address");
		}
		return emailLabel;
	}

	private JLabel getErrorLabel() {
		if (errorLabel == null) {
			errorLabel = new JLabel();
		}
		return errorLabel;
	}
}
