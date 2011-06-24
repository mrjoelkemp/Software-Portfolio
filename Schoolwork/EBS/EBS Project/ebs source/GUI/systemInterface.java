package GUI;

import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.beans.PropertyVetoException;

import javax.swing.JDesktopPane;
import javax.swing.JFrame;
import javax.swing.JInternalFrame;
import javax.swing.JToolBar;
import javax.swing.JMenuItem;
import javax.swing.JMenuBar;

public class systemInterface extends JFrame {

	private static final long serialVersionUID = 1L;

	private JDesktopPane jDesktopPane = null;

	private JInternalFrame jInternalFrame = null;

	public TabbedPane tabbedPane = null; //new TabbedPane();

	private JMenuBar jJMenuBar = null;

	public LoginInterface theLoginInterface ;
	
	public systemInterface() {

		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		add(getJDesktopPane());
		theLoginInterface = new LoginInterface();
		jDesktopPane.add(theLoginInterface);
		setSize(1024, 700);
		
		setTitle("CCNY Auction System");

		setVisible(true);
	}

private void showLogin() {
//	jDesktopPane.add(new LoginInterface());
	theLoginInterface.setVisible(true);
	
}
	
	private void disposeInternalFrame() {
//		jInternalFrame.dispose();
		jDesktopPane.remove(jInternalFrame);
		
	}
	
	public void newInterface() {
		
		if ( tabbedPane != null ) {
			tabbedPane.removeAll();
			jInternalFrame.remove(tabbedPane);
		}
		
		tabbedPane = new TabbedPane();
		
		jInternalFrame = getJInternalFrame();
		jInternalFrame.add(tabbedPane);
		jDesktopPane.add(jInternalFrame);
		try {
			jInternalFrame.setMaximum(true);
			jInternalFrame.setJMenuBar(getJJMenuBar());
//			jInternalFrame.setSize(new java.awt.Dimension(327,217));
		} catch (PropertyVetoException e) {
			e.printStackTrace();
		}
		
		
//		add(getJDesktopPane());
//		add(getJInternalFrame());
		
	}
	
	private JDesktopPane getJDesktopPane() {
		if (jDesktopPane == null) {
			jDesktopPane = new JDesktopPane();
			jDesktopPane.setSize(new java.awt.Dimension(800,1000));
//			jInternalFrame = getJInternalFrame();
//			jDesktopPane.add(jInternalFrame);
//			try {
//				jInternalFrame.setMaximum(true);
//				jInternalFrame.setJMenuBar(getJJMenuBar());
//				jInternalFrame.setSize(new java.awt.Dimension(327,217));
//			} catch (PropertyVetoException e) {
//				e.printStackTrace();
//			}

			jDesktopPane.setVisible(true);
		}
		return jDesktopPane;
	}

	private JInternalFrame getJInternalFrame() {
		if (jInternalFrame == null) {
			jInternalFrame = new JInternalFrame("Main Interface", false, false,
					false, false);
			jInternalFrame.getContentPane().add(tabbedPane);
			jInternalFrame.setVisible(true);

		}
		return jInternalFrame;
	}

	/**
	 * This method initializes jJMenuBar	
	 * 	
	 * @return javax.swing.JMenuBar	
	 */
	private JMenuBar getJJMenuBar() {
		if (jJMenuBar == null) {
			jJMenuBar = new JMenuBar();
//			jJMenuBar.setPreferredSize(new Dimension(20, 900));
			JMenuItem jLogoff = new JMenuItem("Logoff");
			jLogoff.addActionListener(new logoffActionListener());
			
			jJMenuBar.add(jLogoff);
		}
		return jJMenuBar;
	}
	
	private class logoffActionListener implements ActionListener {

		public void actionPerformed(ActionEvent arg0) {
//			TheMain.theSystemInterface.setVisible(false);
			disposeInternalFrame();
			showLogin();
			repaint();
		}
		
	}
	
}
