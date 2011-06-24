package GUI;

import java.awt.Color;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;

import javax.swing.JLabel;
import javax.swing.JTextField;

public class jTextFocusHandler implements FocusListener {
	private JLabel[] jLabels;

	private JTextField[] jTextField;

	public jTextFocusHandler(JLabel[] newJLabel, JTextField[] newJTextField) {
		jLabels = newJLabel;
		jTextField = newJTextField;
	}

	public void focusGained(FocusEvent arg0) {
		for (int i = 0; i < jLabels.length; i++) {
			if ((jLabels[i].getForeground() == Color.red)
					&& jTextField[i].hasFocus()) {
				jLabels[i].setForeground(Color.black);
				jTextField[i].setText("");
			}
		}
	}// end focusGained

	public void focusLost(FocusEvent arg0) {
	}
}
