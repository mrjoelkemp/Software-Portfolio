package GUI;

import java.awt.Color;
import java.awt.Component;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.JTextPane;
import javax.swing.filechooser.FileFilter;

import system.item;

public class PostItemInterface extends JPanel {

	private static final long serialVersionUID = 1L;

	private JPanel jContentPane = null;

	private JLabel jLabelTitle = null;

	private JLabel jLabelDescription = null;

	private JLabel jLabelStartingBid = null;

	private JLabel jLabelAuctionLength = null;

	private JButton jButtonSelectPicture = null;

	private JButton jButtonSubmit = null;

	private JTextField jTextFieldTitle = null;

	private JTextField jTextFieldDescription = null;

	private JTextField jTextFieldStartingBid = null;

	private JTextPane jTextPaneNote = null;

	private JComboBox jComboBox = null;

	private JComboBox jComboBox1 = null;

	private String auctionDays[] = { "1", "2", "3", "4", "5", "6", "7" };

	private selectPictureButton SelectPictureButton = new selectPictureButton();

	private JFileChooser selectPic = null;

	private String file = null;

	private InputStream in = null;

	private String path = new String();

	private File selectedFile = null;

	private JLabel[] jLabel = { getJLabelTitle(), getJLabelDescription(),
			getJLabelStartingBid() };

	public PostItemInterface() {
		add(getJContentPane());
		JTextField jtext[] = { getJTextFieldTitle(),
				getJTextFieldDescription(), getJTextFieldStartingBid() };
		jTextPostHandler handler = new jTextPostHandler(getJButtonSubmit(),
				jtext, getJComboBox1());
		jTextFocusHandler Focushandler = new jTextFocusHandler(jLabel, jtext);
		for (int i = 0; i < jtext.length; i++)
			jtext[i].addFocusListener(Focushandler);
		getJButtonSubmit().addActionListener(handler);
		jButtonSelectPicture.addActionListener(SelectPictureButton);
	}

	// The action Listener for the select Picture Button
	private class selectPictureButton implements ActionListener {

		public void actionPerformed(ActionEvent arg0) {
			try {
				select();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		// Gets the path of the selected picture		
		public void select() throws IOException {
			Component comp = null;
			selectPic = new JFileChooser();
			//This makes sure only BMP and JPeg files are shown
			selectPic.setFileFilter(new pic());

			int returnVal = selectPic.showOpenDialog(comp);
			if (returnVal == JFileChooser.APPROVE_OPTION) {
				//gets the selected file informaiton
				selectedFile = selectPic.getSelectedFile();
			}

			//saves the name of the selected file
			file = selectedFile.getName();
			//saves the path of the file
			path = selectedFile.getPath();
		}
	}//end selectPictureButton

	//This is the filter that chooses which files are to be shown in the select picture dialog
	public class pic extends FileFilter {

		@Override
		public boolean accept(File f) {
			//if it is a directory -- we want to show it so return true.
			if (f.isDirectory())
				return true;

			//get the extension of the file

			String extension = getExtension(f);
			//check to see if the extension is equal to jpeg,JPEG,bmp,or BMP
			if ((extension.equalsIgnoreCase("jpeg"))
					|| (extension.equalsIgnoreCase("bmp"))
					|| (extension.equalsIgnoreCase("jpg"))
					|| (extension.equalsIgnoreCase("gif")))
				return true;

			return false;
		}

		@Override
		public String getDescription() {
			return null;
		}

		private String getExtension(File f) {
			String s = f.getName();
			int i = s.lastIndexOf('.');
			if (i > 0 && i < s.length() - 1)
				return s.substring(i + 1).toLowerCase();
			return "";
		}
	}

	//This handler checks all of the fields and makes sure the are all filled in correctly	
	public class jTextPostHandler implements ActionListener {
		private JButton button;

		private JTextField[] jFields;

		private JComboBox jBoxOne;

		private String jFieldString;

		private boolean post = true;

		public jTextPostHandler(JButton newButton) {
			button = newButton;
		}

		public jTextPostHandler(JButton newButton, JTextField[] newjFields,
				JComboBox newjBoxOne) {
			button = newButton;
			jFields = newjFields;
			jBoxOne = newjBoxOne;

		}

		public void actionPerformed(ActionEvent arg0) {
			//if the submit button is pressed execute
			if ((arg0.getSource() == button) && jFields.length > 0) {
				//set post to true if it remains true after checking all
				//the fiels the item will be posted else errors will be shown
				post = true;

				//checks field if its empty prompt user to fill in information	
				for (int i = 0; i < jFields.length - 1; i++) {
					jFieldString = jFields[i].getText().trim();
					if (jFieldString.length() == 0) {
						jLabel[i].setForeground(Color.red);
						jFields[i]
								.setText("This information must be filled in");
					}
				}

				// Limit the length of the submitted description so it won't mess up the layout on the detailed item interface
				if (jTextFieldDescription.getText().length() > 90) {
					post = false;
					JOptionPane.showMessageDialog(null,
							"Please enter a shorter description");
				}
				//Change the price from string and test if it is of type Long if not
				//return an error
				try {
					Long.parseLong(jFields[2].getText().trim());

				} catch (Exception num) {
					jLabel[2].setForeground(Color.red);
					jFields[2]
							.setText("Price entered must be whole value amount");
				}

			}
			//If any of the Labels are red that means there is an error 
			//dont post the item
			for (int j = 0; j < jLabel.length; j++) {
				if (jLabel[j].getForeground() == Color.red)
					post = false;
			}

			//If post is still true after checking all the fields post the item
			if (post) {
				//Set each jField to the appropriate name
				String title = jFields[0].getText().toString();
				String description = jFields[1].getText().toString();
				String picLocation = new String();
				Long startPrice = Long.parseLong(jFields[2].getText()
						.toString());
				Long currentPrice = startPrice;
				int endTime = Integer.parseInt(jBoxOne.getSelectedItem()
						.toString());
				int itemNumber = getItemNumber() + 1;

				String fileExt = new String();
				int user_ID = Integer.parseInt(TheMain.global_user
						.getInfo("id"));

				if (path.length() == 0)
					//Save the file
					picLocation = "nopicture";

				else {
					// Get the extension of the selected file
					for (int i = file.length() - 1; i > 0; i--) {
						if (file.charAt(i) == '.') {
							fileExt = file.substring(i, file.length());
							break;
						}

					}
					picLocation = "./item_images/" + itemNumber + fileExt;

					try {
						//Save the file to this location
						OutputStream out = new FileOutputStream(picLocation);

						//Grab the file to be copied
						in = new FileInputStream(path);

						//set the Max file size
						byte[] buf = new byte[1024];
						int len;

						//Copy the file to the given picLoction 
						while ((len = in.read(buf)) > 0) {
							out.write(buf, 0, len);
						}
						in.close();
						out.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				//create a new item from the entered data
				item newItem = new item(title, description, startPrice,
						currentPrice, endTime, picLocation, user_ID);

				try {
					// post the item to the system
					newItem.post();
				} catch (IOException e1) {
					e1.printStackTrace();
				} catch (Exception e1) {
					e1.printStackTrace();
				}
				for (int i = 0; i < jFields.length; i++) {
					jFields[i].setText("");
				}
				//Reset the Auction Day combo box
				jBoxOne.setSelectedIndex(0);
				file = null;

				// Show success message 
				JOptionPane
						.showMessageDialog(null,
								"Your item has been entered into the system sucessfully");
			}
		}
	}//end jTextPostHandler

	//Get the item number for the newly posted item 
	private int getItemNumber() {
		int itemNumber = 0;
		try {
			itemNumber = TheMain.global_db.getMaxId("item");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return itemNumber;
	}

	private JPanel getJContentPane() {
		if (jContentPane == null) {
			GridBagConstraints gridBagConstraints11 = new GridBagConstraints();
			gridBagConstraints11.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints11.gridx = 1;
			gridBagConstraints11.weightx = 1.0;
			gridBagConstraints11.gridy = 3;
			GridBagConstraints gridBagConstraints10 = new GridBagConstraints();
			gridBagConstraints10.fill = java.awt.GridBagConstraints.BOTH;
			gridBagConstraints10.gridy = 6;
			gridBagConstraints10.weightx = 1.0;
			gridBagConstraints10.weighty = 1.0;
			gridBagConstraints10.gridx = 1;
			GridBagConstraints gridBagConstraints9 = new GridBagConstraints();
			gridBagConstraints9.gridx = 1;
			gridBagConstraints9.gridy = 5;
			GridBagConstraints gridBagConstraints8 = new GridBagConstraints();
			gridBagConstraints8.gridx = 1;
			gridBagConstraints8.gridy = 4;
			GridBagConstraints gridBagConstraints6 = new GridBagConstraints();
			gridBagConstraints6.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints6.gridy = 2;
			gridBagConstraints6.weightx = 1.0;
			gridBagConstraints6.gridx = 1;
			GridBagConstraints gridBagConstraints5 = new GridBagConstraints();
			gridBagConstraints5.gridx = 0;
			gridBagConstraints5.gridy = 3;
			GridBagConstraints gridBagConstraints4 = new GridBagConstraints();
			gridBagConstraints4.gridx = 0;
			gridBagConstraints4.gridy = 2;
			GridBagConstraints gridBagConstraints3 = new GridBagConstraints();
			gridBagConstraints3.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints3.gridy = 1;
			gridBagConstraints3.weightx = 1.0;
			gridBagConstraints3.gridx = 1;
			GridBagConstraints gridBagConstraints2 = new GridBagConstraints();
			gridBagConstraints2.fill = java.awt.GridBagConstraints.HORIZONTAL;
			gridBagConstraints2.gridy = 0;
			gridBagConstraints2.weightx = 1.0;
			gridBagConstraints2.gridx = 1;
			GridBagConstraints gridBagConstraints1 = new GridBagConstraints();
			gridBagConstraints1.gridx = 0;
			gridBagConstraints1.gridy = 1;
			GridBagConstraints gridBagConstraints = new GridBagConstraints();
			gridBagConstraints.gridx = 0;
			gridBagConstraints.gridy = 0;
			jContentPane = new JPanel();
			jContentPane.setLayout(new GridBagLayout());
			jContentPane.add(getJLabelTitle(), gridBagConstraints);
			jContentPane.add(getJLabelDescription(), gridBagConstraints1);
			jContentPane.add(getJTextFieldTitle(), gridBagConstraints2);
			jContentPane.add(getJTextFieldDescription(), gridBagConstraints3);
			jContentPane.add(getJLabelStartingBid(), gridBagConstraints4);
			jContentPane.add(getJLabelAuctionLength(), gridBagConstraints5);
			jContentPane.add(getJTextFieldStartingBid(), gridBagConstraints6);
			jContentPane.add(getJButtonSelectPicture(), gridBagConstraints8);
			jContentPane.add(getJButtonSubmit(), gridBagConstraints9);
			jContentPane.add(getJTextPaneNote(), gridBagConstraints10);
			jContentPane.add(getJComboBox1(), gridBagConstraints11);
		}
		return jContentPane;
	}

	private JLabel getJLabelTitle() {
		if (jLabelTitle == null) {
			jLabelTitle = new JLabel();
			jLabelTitle.setText("Title");
		}
		return jLabelTitle;
	}

	private JLabel getJLabelDescription() {
		if (jLabelDescription == null) {
			jLabelDescription = new JLabel();
			jLabelDescription.setText("Description");
		}
		return jLabelDescription;
	}

	private JLabel getJLabelStartingBid() {
		if (jLabelStartingBid == null) {
			jLabelStartingBid = new JLabel();
			jLabelStartingBid.setText("Starting Bid");
		}
		return jLabelStartingBid;
	}

	private JLabel getJLabelAuctionLength() {
		if (jLabelAuctionLength == null) {
			jLabelAuctionLength = new JLabel();
			jLabelAuctionLength.setText("Auction Length (days)");
		}
		return jLabelAuctionLength;
	}

	private JButton getJButtonSelectPicture() {
		if (jButtonSelectPicture == null) {
			jButtonSelectPicture = new JButton();
			jButtonSelectPicture.setText("Select Picture");
		}
		return jButtonSelectPicture;
	}

	private JButton getJButtonSubmit() {
		if (jButtonSubmit == null) {
			jButtonSubmit = new JButton();
			jButtonSubmit.setText("Submit");
		}
		return jButtonSubmit;
	}

	private JTextField getJTextFieldTitle() {
		if (jTextFieldTitle == null) {
			jTextFieldTitle = new JTextField();
		}
		return jTextFieldTitle;
	}

	private JTextField getJTextFieldDescription() {
		if (jTextFieldDescription == null) {
			jTextFieldDescription = new JTextField();
		}
		return jTextFieldDescription;
	}

	private JTextField getJTextFieldStartingBid() {
		if (jTextFieldStartingBid == null) {
			jTextFieldStartingBid = new JTextField();
		}
		return jTextFieldStartingBid;
	}

	private JTextPane getJTextPaneNote() {
		if (jTextPaneNote == null) {
			jTextPaneNote = new JTextPane();
			jTextPaneNote
					.setText("Your auction will start when the System Administrator approves it.");
		}
		return jTextPaneNote;
	}

	private JComboBox getJComboBox1() {
		if (jComboBox1 == null) {
			jComboBox1 = new JComboBox(auctionDays);
			jComboBox1.setSize(new java.awt.Dimension(243, 67));
		}
		return jComboBox1;
	}
}
