package GUI;

import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import system.user;

public class RegisterInterface extends JFrame {

	private static final long serialVersionUID = 1L;

	private JLabel jLabelFirstName = null;

	private JLabel jLabelLastName = null;

	private JLabel jLabelAddress = null;

	private JLabel jLabelCity = null;

	private JLabel jLabelState = null;

	private JLabel jLabelZip = null;

	private JLabel jLabelRequestedUsername = null;

	private JLabel jLabelCreditCard = null;

	private JLabel jLabelPhoneNumber = null;

	private JLabel jLabelEmail = null;

	private JPanel jContentPane = null;

	private JTextField jTextFieldRequestedUsername = null;

	private JTextField jTextFieldFirstName = null;

	private JTextField jTextFieldLastName = null;

	private JTextField jTextFieldAddress = null;

	private JTextField jTextFieldCity = null;

	private JTextField jTextFieldState = null;

	private JTextField jTextFieldZipCode = null;

	private JTextField jTextFieldCreditCard = null;

	private JTextField jTextFieldPhoneNumber = null;

	private JTextField jTextFieldEmail = null;

	private JButton jButtonSubmit = null;

	private JTextArea jTextAreaNote = null;

	private JTextField[] jFields = { getJTextFieldRequestedUsername(),
			getJTextFieldFirstName(), getJTextFieldLastName(),
			getJTextFieldAddress(), getJTextFieldCity(), getJTextFieldState(),
			getJTextFieldZipCode(), getJTextFieldPhoneNumber(),
			getJTextFieldCreditCard(), getJTextFieldEmail() };

	private JLabel[] jLabels = { getJLabelRequestedUsername(),
			getJLabelFirstName(), getJLabelLastName(), getJLabelAddress(),
			getJLabelCity(), getJLabelState(), getJLabelZip(),
			getJLabelPhoneNumber(), getJLabelCreditCard(), getJLabelEmail() };

	private registerButtonHandler handler = new registerButtonHandler();

	public RegisterInterface() {
		add(getJContentPane());
		setBounds(250, 250, 350, 350);
		setTitle("Register");
		setResizable(false);
		setVisible(true);
	}

	// This is the Button action listener for Submit. It checks all of the
	// fields in the registration GUI
	private class registerButtonHandler implements ActionListener {

		private JButton button = getJButtonSubmit();

		private String jFieldString;

		private boolean register = true;

		public void actionPerformed(ActionEvent arg0) {
			if (arg0.getSource() == button) {
				register = true;

				Pattern noNumbers = Pattern.compile("[^0-9]");
				Pattern zipcode = Pattern.compile("^([0-9]{5})$");
				Pattern phoneNumber = Pattern
						.compile("[1-9]{3}-?[1-9]{1}[0-9]{2}-?[0-9]{4}");
				Pattern creditcard = Pattern
						.compile("[0-9]{4}-?[0-9]{4}-?[0-9]{4}-?[0-9]{4}");
				Pattern emailAddress = Pattern.compile(".+@.+\\.[a-z]+");

				boolean found = false;
				Matcher m;

				// Checks that the first six fields are not just numbers
				for (int i = 0; i < 6; i++) {
					m = noNumbers.matcher(jFields[i].getText().trim());
					found = m.find();
					if (!found || (jFields[i].toString().length() == 0)) {
						jLabels[i].setForeground(Color.red);
						jFields[i].setText("Incomplete");
					}
				}
				// Checks to see if zip is a five digit number
				m = zipcode.matcher(jFields[6].getText().trim());
				found = m.find();
				if (!found || (jFields[6].toString().length() == 0)) {
					jLabels[6].setForeground(Color.red);
					jFields[6].setText("Enter 5 digit zip");
				}
				// Checks to see if phoneNumber is a ten digit number
				m = phoneNumber.matcher(jFields[7].getText().trim());
				found = m.find();
				if (!found || (jFields[7].toString().length() == 0)) {
					jLabels[7].setForeground(Color.red);
					jFields[7].setText("Enter 10 digit PhoneNumber");
				}
				// Checks to see if creditcard is a fourteen digit number
				m = creditcard.matcher(jFields[8].getText().trim());
				found = m.find();
				if (!found || (jFields[8].toString().length() == 0)) {
					jLabels[8].setForeground(Color.red);
					jFields[8].setText("Enter 14 digit creditcard number");
				}
				// checks to see if email address is in the right format
				m = emailAddress.matcher(jFields[9].getText().trim());
				found = m.find();
				if (!found || (jFields[9].toString().length() == 0)) {
					jLabels[9].setForeground(Color.red);
					jFields[9].setText("Invalid email address");
				}
			}
			// If any of the labels are red there is an error so dont register
			// the user

			for (int j = 0; j < jLabels.length; j++) {
				if (jLabels[j].getForeground() == Color.red)
					register = false;
			}
			// If User Name is equal to Incomplete dont search for it in the
			// database
			if (!jFields[0].getText().equals("Incomplete")) {
				// If the chosen user name is not unique send an error to the
				// user
				if (notUniqueName(jFields[0].getText().trim())) {
					register = false;
					jLabels[0].setForeground(Color.red);
					jFields[0].setText("User Name is Already Taken");
				}
			}

			// If everthing checks out above then register the user
			if (register) {
				try {
					TheMain.global_user = new user(jFields[0].getText().trim()
							.toLowerCase(), jFields[1].getText().trim()
							.toLowerCase(), jFields[2].getText().trim()
							.toLowerCase(), jFields[3].getText().trim()
							.toLowerCase(), jFields[4].getText().trim()
							.toLowerCase(), jFields[5].getText().trim()
							.toLowerCase(), jFields[6].getText().trim(),
							jFields[8].getText().trim(), jFields[7].getText()
									.trim(), jFields[9].getText().trim());
					TheMain.global_user.register();
					setVisible(false);
					JOptionPane.showMessageDialog(null,
							"Registration Successful!");
					dispose();

				} catch (IOException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		}

	}

	// Checks if the user name is unique or not
	private boolean notUniqueName(String userName) {
		boolean check = true;
		Element allUserNames = TheMain.global_db.select("users", "username",
				userName);

		try {
			NodeList node1 = allUserNames.getElementsByTagName("username");
		} catch (Exception e1) {
			check = false;
		}

		return check;
	}

	private JLabel getJLabelFirstName() {
		if (jLabelFirstName == null) {
			jLabelFirstName = new JLabel();
			jLabelFirstName.setText("First Name");
		}
		return jLabelFirstName;
	}

	private JLabel getJLabelLastName() {
		if (jLabelLastName == null) {
			jLabelLastName = new JLabel();
			jLabelLastName.setText("Last Name");
		}
		return jLabelLastName;
	}

	private JLabel getJLabelAddress() {
		if (jLabelAddress == null) {
			jLabelAddress = new JLabel();
			jLabelAddress.setText("Address");
		}
		return jLabelAddress;
	}

	private JLabel getJLabelCity() {
		if (jLabelCity == null) {
			jLabelCity = new JLabel();
			jLabelCity.setText("City");
		}
		return jLabelCity;
	}

	private JLabel getJLabelState() {
		if (jLabelState == null) {
			jLabelState = new JLabel();
			jLabelState.setText("State");
		}
		return jLabelState;
	}

	private JLabel getJLabelZip() {
		if (jLabelZip == null) {
			jLabelZip = new JLabel();
			jLabelZip.setText("ZIP Code");
		}
		return jLabelZip;
	}

	private JLabel getJLabelCreditCard() {
		if (jLabelCreditCard == null) {
			jLabelCreditCard = new JLabel();
			jLabelCreditCard.setText("CreditCard Number");
		}
		return jLabelCreditCard;
	}

	private JLabel getJLabelPhoneNumber() {
		if (jLabelPhoneNumber == null) {
			jLabelPhoneNumber = new JLabel();
			jLabelPhoneNumber.setText("PhoneNumber");
		}
		return jLabelPhoneNumber;
	}

	private JLabel getJLabelEmail() {
		if (jLabelEmail == null) {
			jLabelEmail = new JLabel();
			jLabelEmail.setText("Email Address");
		}
		return jLabelEmail;
	}

	private JLabel getJLabelRequestedUsername() {
		if (jLabelRequestedUsername == null) {
			jLabelRequestedUsername = new JLabel();
			jLabelRequestedUsername.setText("Requested Username");
		}
		return jLabelRequestedUsername;
	}

	private JPanel getJContentPane() {
		if (jContentPane == null) {
			GridBagConstraints gridBagConstraints101 = new GridBagConstraints();
			gridBagConstraints101.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints101.gridx = 1;
			gridBagConstraints101.gridy = 10;
			GridBagConstraints gridBagConstraints100 = new GridBagConstraints();
			gridBagConstraints100.gridx = 0;
			gridBagConstraints100.gridy = 10;
			GridBagConstraints gridBagConstraints91 = new GridBagConstraints();
			gridBagConstraints91.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints91.gridx = 1;
			gridBagConstraints91.gridy = 9;
			GridBagConstraints gridBagConstraints90 = new GridBagConstraints();
			gridBagConstraints90.gridx = 0;
			gridBagConstraints90.gridy = 9;
			GridBagConstraints gridBagConstraints81 = new GridBagConstraints();
			gridBagConstraints81.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints81.gridx = 1;
			gridBagConstraints81.gridy = 8;
			GridBagConstraints gridBagConstraints80 = new GridBagConstraints();
			gridBagConstraints80.gridx = 0;
			gridBagConstraints80.gridy = 8;
			GridBagConstraints gridBagConstraints10 = new GridBagConstraints();
			gridBagConstraints10.fill = java.awt.GridBagConstraints.BOTH;
			gridBagConstraints10.gridy = 16;
			gridBagConstraints10.weightx = 1.0;
			gridBagConstraints10.weighty = 1.0;
			gridBagConstraints10.gridx = 1;
			GridBagConstraints gridBagConstraints8 = new GridBagConstraints();
			gridBagConstraints8.gridx = 0;
			gridBagConstraints8.gridy = 15;
			GridBagConstraints gridBagConstraints71 = new GridBagConstraints();
			gridBagConstraints71.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints71.gridy = 7;
			gridBagConstraints71.weightx = 1.0;
			gridBagConstraints71.gridx = 1;
			GridBagConstraints gridBagConstraints61 = new GridBagConstraints();
			gridBagConstraints61.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints61.gridy = 5;
			gridBagConstraints61.weightx = 1.0;
			gridBagConstraints61.gridx = 1;
			GridBagConstraints gridBagConstraints51 = new GridBagConstraints();
			gridBagConstraints51.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints51.gridy = 4;
			gridBagConstraints51.weightx = 1.0;
			gridBagConstraints51.gridx = 1;
			GridBagConstraints gridBagConstraints41 = new GridBagConstraints();
			gridBagConstraints41.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints41.gridy = 3;
			gridBagConstraints41.weightx = 1.0;
			gridBagConstraints41.gridx = 1;
			GridBagConstraints gridBagConstraints31 = new GridBagConstraints();
			gridBagConstraints31.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints31.gridy = 2;
			gridBagConstraints31.weightx = 1.0;
			gridBagConstraints31.gridx = 1;
			GridBagConstraints gridBagConstraints21 = new GridBagConstraints();
			gridBagConstraints21.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints21.gridy = 1;
			gridBagConstraints21.weightx = 1.0;
			gridBagConstraints21.gridx = 1;
			GridBagConstraints gridBagConstraints11 = new GridBagConstraints();
			gridBagConstraints11.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints11.gridy = 0;
			gridBagConstraints11.weightx = 1.0;
			gridBagConstraints11.gridx = 1;
			GridBagConstraints gridBagConstraints6 = new GridBagConstraints();
			gridBagConstraints6.gridx = 0;
			gridBagConstraints6.gridy = 7;
			GridBagConstraints gridBagConstraints5 = new GridBagConstraints();
			gridBagConstraints5.gridx = 0;
			gridBagConstraints5.gridy = 5;
			GridBagConstraints gridBagConstraints4 = new GridBagConstraints();
			gridBagConstraints4.gridx = 0;
			gridBagConstraints4.gridy = 4;
			GridBagConstraints gridBagConstraints3 = new GridBagConstraints();
			gridBagConstraints3.gridx = 0;
			gridBagConstraints3.gridy = 3;
			GridBagConstraints gridBagConstraints2 = new GridBagConstraints();
			gridBagConstraints2.gridx = 0;
			gridBagConstraints2.gridy = 2;
			GridBagConstraints gridBagConstraints1 = new GridBagConstraints();
			gridBagConstraints1.gridx = 0;
			gridBagConstraints1.gridy = 1;
			GridBagConstraints gridBagConstraints = new GridBagConstraints();
			gridBagConstraints.gridx = 0;
			gridBagConstraints.gridy = 0;
			jContentPane = new JPanel();
			jContentPane.setLayout(new GridBagLayout());
			jContentPane.add(getJLabelRequestedUsername(), gridBagConstraints);
			jContentPane.add(getJLabelFirstName(), gridBagConstraints1);
			jContentPane.add(getJLabelLastName(), gridBagConstraints2);
			jContentPane.add(getJLabelAddress(), gridBagConstraints3);
			jContentPane.add(getJLabelCity(), gridBagConstraints4);
			jContentPane.add(getJLabelState(), gridBagConstraints5);
			jContentPane.add(getJLabelZip(), gridBagConstraints6);
			jContentPane.add(getJLabelPhoneNumber(), gridBagConstraints80);
			jContentPane.add(getJLabelCreditCard(), gridBagConstraints90);
			jContentPane.add(getJLabelEmail(), gridBagConstraints100);
			jContentPane.add(getJTextFieldEmail(), gridBagConstraints101);
			jContentPane.add(getJTextFieldCreditCard(), gridBagConstraints91);
			jContentPane.add(getJTextFieldPhoneNumber(), gridBagConstraints81);
			jContentPane.add(getJTextFieldRequestedUsername(),
					gridBagConstraints11);
			jContentPane.add(getJTextFieldFirstName(), gridBagConstraints21);
			jContentPane.add(getJTextFieldLastName(), gridBagConstraints31);
			jContentPane.add(getJTextFieldAddress(), gridBagConstraints41);
			jContentPane.add(getJTextFieldCity(), gridBagConstraints51);
			jContentPane.add(getJTextFieldState(), gridBagConstraints61);
			jContentPane.add(getJTextFieldZipCode(), gridBagConstraints71);
			jContentPane.add(getJButtonSubmit(), gridBagConstraints8);
			jContentPane.add(getJTextAreaNote(), gridBagConstraints10);

			jTextFocusHandler Focushandler = new jTextFocusHandler(jLabels,
					jFields);

			for (int i = 0; i < jFields.length; i++)
				jFields[i].addFocusListener(Focushandler);

			getJButtonSubmit().addActionListener(handler);
		}
		return jContentPane;
	}

	private JTextField getJTextFieldEmail() {
		if (jTextFieldEmail == null) {
			jTextFieldEmail = new JTextField();
		}

		return jTextFieldEmail;
	}

	private JTextField getJTextFieldCreditCard() {
		if (jTextFieldCreditCard == null) {
			jTextFieldCreditCard = new JTextField();
		}
		return jTextFieldCreditCard;
	}

	private JTextField getJTextFieldPhoneNumber() {
		if (jTextFieldPhoneNumber == null) {
			jTextFieldPhoneNumber = new JTextField();
		}
		return jTextFieldPhoneNumber;
	}

	private JTextField getJTextFieldRequestedUsername() {
		if (jTextFieldRequestedUsername == null) {
			jTextFieldRequestedUsername = new JTextField();
		}
		return jTextFieldRequestedUsername;
	}

	private JTextField getJTextFieldFirstName() {
		if (jTextFieldFirstName == null) {
			jTextFieldFirstName = new JTextField();
		}
		return jTextFieldFirstName;
	}

	private JTextField getJTextFieldLastName() {
		if (jTextFieldLastName == null) {
			jTextFieldLastName = new JTextField();
		}
		return jTextFieldLastName;
	}

	private JTextField getJTextFieldAddress() {
		if (jTextFieldAddress == null) {
			jTextFieldAddress = new JTextField();
		}
		return jTextFieldAddress;
	}

	private JTextField getJTextFieldCity() {
		if (jTextFieldCity == null) {
			jTextFieldCity = new JTextField();
		}
		return jTextFieldCity;
	}

	private JTextField getJTextFieldState() {
		if (jTextFieldState == null) {
			jTextFieldState = new JTextField();
		}
		return jTextFieldState;
	}

	private JTextField getJTextFieldZipCode() {
		if (jTextFieldZipCode == null) {
			jTextFieldZipCode = new JTextField();
		}
		return jTextFieldZipCode;
	}

	private JButton getJButtonSubmit() {
		if (jButtonSubmit == null) {
			jButtonSubmit = new JButton();
			jButtonSubmit.setText("Submit");
		}
		return jButtonSubmit;
	}

	private JTextArea getJTextAreaNote() {
		if (jTextAreaNote == null) {
			jTextAreaNote = new JTextArea();
			jTextAreaNote.setLineWrap(true);
			jTextAreaNote.setEditable(false);
			jTextAreaNote.setWrapStyleWord(true);
			jTextAreaNote
					.setText("You will have access to the system when the System Administrator approves your account!");
		}
		return jTextAreaNote;
	}
}
