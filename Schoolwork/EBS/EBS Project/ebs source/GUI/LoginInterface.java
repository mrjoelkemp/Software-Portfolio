package GUI;

import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

import system.Database;
import system.user;

public class LoginInterface extends JInternalFrame {

	private static final long serialVersionUID = 1L;

	private static systemInterface theSystemInterface = null;

	private static RegisterInterface theRegisterInterface = null;

	private JLabel jLabelUsername = null;

	private JLabel jLabelPassword = null;

	private JTextField jTextFieldUsername = null;

	private JPasswordField jPasswordFieldPassword = null;

	private JInternalFrame jInternalFrame = null;

	private JPanel jContentPane = null;

	private JButton jButtonLogin = null;

	private JButton jButtonRegister = null;

	private JLabel jLabelNote = null;

	private JLabel jLabelWelcome = null;

	private JLabel jLabelError = null;

	private boolean isValid = false;

	private ButtonPressedListener pressedButtonListener = new ButtonPressedListener();

	public LoginInterface() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		add(getJContentPane());
		 setSize(570, 224);
		setBounds(250, 250, 570, 224);
		setTitle("CCNY Auction System");
		setVisible(true);
		setResizable(false);

		jButtonLogin.addActionListener(pressedButtonListener);
		jButtonRegister.addActionListener(pressedButtonListener);

	}

	public void simulateSALogin(String username_in, String password_in) {
		jTextFieldUsername.setText(username_in);
		jPasswordFieldPassword.setText(password_in);
		jButtonLogin.doClick();
	}

	public void simulateOULogin(String username_in, String password_in) {
		jTextFieldUsername.setText(username_in);
		jPasswordFieldPassword.setText(password_in);
		jButtonLogin.doClick();
	}

	private class ButtonPressedListener implements ActionListener {

		public void actionPerformed(ActionEvent event) {

			if (event.getSource() == jButtonLogin) {
				// reset color of errorlabel
				jLabelError.setForeground(Color.BLACK);
				authenticateUser();
			}

			if (event.getSource() == jButtonRegister)
				// show the register interface
				theRegisterInterface = new RegisterInterface();

		}// end actionPerformed
	}// end ActionListener

	private void authenticateUser() {
		String[][] tempUserInfo = null;

		// Load the username and password from the text boxes
		String userUserName = new String(jTextFieldUsername.getText()
				.toLowerCase());
		char[] enteredPasswordChar = jPasswordFieldPassword.getPassword();
		String enteredPassword = new String();

		for (int i = 0; i < enteredPasswordChar.length; i++) {
			enteredPassword = enteredPassword + enteredPasswordChar[i];
		}

		// Check the database to see if the user exists
		tempUserInfo = TheMain.global_db.select("users", "username",
				userUserName, null);

		// If the user does not exist
		if (tempUserInfo.length == 0)
			// Show a message that the username and password do not match
			showError();

		else {
			// The user exists

			// load that user's information from DB into global_user
			TheMain.global_user = new user(tempUserInfo);

			// Authenticate the given username and password.
			isValid = TheMain.global_user.authenticate(userUserName,
					enteredPassword);

			// if the username and password exist and if the user can login
			if (isValid && TheMain.global_user.canLogin()) {
				// grant access to the system interface
//				theSystemInterface = new systemInterface();
				TheMain.theSystemInterface.newInterface();
				// kill the login interface
//				this.dispose();
				this.setVisible(false);
			}
			// else, display login error message
			else
				showError();

		} // end else
		
		jPasswordFieldPassword.setText("");
		jTextFieldUsername.setText("");
	}

	public void showError() {
		/*
		 * Purpose: Display a red error message to the user.
		 */

		// If the user cannot login
		jLabelError
		.setText("The system cannot find the username and password that you entered. Please try again.");
		jLabelError.setForeground(Color.RED);
//		if (!TheMain.global_user.canLogin()) {
//
//			jLabelError.setForeground(Color.RED);
//			// Display a status error message
//			jLabelError
//					.setText("Your Account is either Pending or Blocked. Please contact the Administrator!");
//		}
//
//		// Else the password is invalid.
//		else {
//			jLabelError.setForeground(Color.RED);
//			jLabelError.setText("The Username and/or Password is Incorrect");
//		}
	}

	private JLabel getJLabelUsername() {
		if (jLabelUsername == null) {
			jLabelUsername = new JLabel();
			jLabelUsername.setText("Username");
		}
		return jLabelUsername;
	}

	private JLabel getJLabelPassword() {
		if (jLabelPassword == null) {
			jLabelPassword = new JLabel();
			jLabelPassword.setText("Password");
		}
		return jLabelPassword;
	}

	private JTextField getJTextFieldUsername() {
		if (jTextFieldUsername == null) {
			jTextFieldUsername = new JTextField();
		}
		return jTextFieldUsername;
	}

	private JPasswordField getJPasswordFieldPassword() {
		if (jPasswordFieldPassword == null) {
			jPasswordFieldPassword = new JPasswordField();
		}
		return jPasswordFieldPassword;
	}

	private JPanel getJContentPane() {
		if (jContentPane == null) {
			GridBagConstraints gridBagConstraints13 = new GridBagConstraints();
			gridBagConstraints13.gridx = 1;
			gridBagConstraints13.gridy = 1;
			GridBagConstraints gridBagConstraints12 = new GridBagConstraints();
			gridBagConstraints12.gridx = 1;
			gridBagConstraints12.gridy = 0;
			GridBagConstraints gridBagConstraints11 = new GridBagConstraints();
			gridBagConstraints11.gridx = 1;
			gridBagConstraints11.gridy = 5;
			GridBagConstraints gridBagConstraints5 = new GridBagConstraints();
			gridBagConstraints5.gridx = 1;
			gridBagConstraints5.gridy = 6;
			GridBagConstraints gridBagConstraints4 = new GridBagConstraints();
			gridBagConstraints4.gridx = 1;
			gridBagConstraints4.gridy = 4;
			GridBagConstraints gridBagConstraints3 = new GridBagConstraints();
			gridBagConstraints3.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints3.gridy = 3;
			gridBagConstraints3.weightx = 1.0;
			gridBagConstraints3.gridx = 1;
			GridBagConstraints gridBagConstraints2 = new GridBagConstraints();
			gridBagConstraints2.gridx = 0;
			gridBagConstraints2.gridy = 3;
			GridBagConstraints gridBagConstraints1 = new GridBagConstraints();
			gridBagConstraints1.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints1.gridy = 2;
			gridBagConstraints1.weightx = 1.0;
			gridBagConstraints1.gridx = 1;
			GridBagConstraints gridBagConstraints = new GridBagConstraints();
			gridBagConstraints.gridx = 0;
			gridBagConstraints.gridy = 2;
			jContentPane = new JPanel();
			jContentPane.setLayout(new GridBagLayout());
			jContentPane.add(getJLabelUsername(), gridBagConstraints);
			jContentPane.add(getJTextFieldUsername(), gridBagConstraints1);
			jContentPane.add(getJLabelPassword(), gridBagConstraints2);
			jContentPane.add(getJPasswordFieldPassword(), gridBagConstraints3);
			jContentPane.add(getJButtonLogin(), gridBagConstraints4);
			jContentPane.add(getJButtonRegister(), gridBagConstraints5);
			jContentPane.add(getJLabelNote(), gridBagConstraints11);
			jContentPane.add(getJLabelWelcome(), gridBagConstraints12);
			jContentPane.add(getJLabelError(), gridBagConstraints13);
		}
		return jContentPane;
	}

	private JButton getJButtonLogin() {
		if (jButtonLogin == null) {
			jButtonLogin = new JButton();
			jButtonLogin.setText("Login");
		}
		return jButtonLogin;
	}

	private JButton getJButtonRegister() {
		if (jButtonRegister == null) {
			jButtonRegister = new JButton();
			jButtonRegister.setText("Register");
		}
		return jButtonRegister;
	}

	private JLabel getJLabelNote() {
		if (jLabelNote == null) {
			jLabelNote = new JLabel();
			jLabelNote.setText("Don't have an account? Click Register");
		}
		return jLabelNote;
	}

	private JLabel getJLabelWelcome() {
		if (jLabelWelcome == null) {
			jLabelWelcome = new JLabel();
			jLabelWelcome.setText("Welcome to the CCNY Auction System");
		}
		return jLabelWelcome;
	}

	private JLabel getJLabelError() {
		if (jLabelError == null) {
			jLabelError = new JLabel();
		}
		return jLabelError;
	}
}
