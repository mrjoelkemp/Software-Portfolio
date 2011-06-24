/*
 * File: DFSapp.java
 * Authors: Joel Kemp & Daniel Ranells
 * Artificial Intelligence, Summer 2007
 * Prof. Lucci
 */
package source;

import java.util.ArrayList;

import javax.swing.DefaultListModel;
import javax.swing.JFrame;

class DFSapp {

	static GUI systemGui;
	static ArrayList<Node> systemNodeList = new ArrayList<Node>();
	
	static ArrayList<String> systemEdgeList = new ArrayList<String>();
	//Used in adding and removing items from the JList GUI component.
	static DefaultListModel listModel = new DefaultListModel();
	
	//Global tracker of the previous gui button clicked -- text of button
	static String previousNodeClicked;
	//Global counter of the number of buttons clicked
	static int numberButtonsClicked = 0;
	
	
	public static void main(String[] args) {
		systemGui = new GUI();
		JFrame mainFrame = new JFrame();
		
		mainFrame.getContentPane().add(systemGui);
		mainFrame.setSize(500,550);
		mainFrame.setVisible(false);
		systemGui.init();
		mainFrame.setVisible(true);
		mainFrame.setTitle("Depth First Search with Iterative Deepening -- Joel Kemp & Daniel Ranells");
		
		//Populate system node list
		GUI.populateSystemNodeList();
		
	}
	

}
