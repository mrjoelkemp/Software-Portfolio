package source;

import java.awt.BorderLayout;
import javax.swing.JPanel;
import javax.swing.JApplet;
import java.awt.Dimension;
import javax.swing.JTree;

import java.awt.Color;
import java.awt.Component;
import java.awt.Rectangle;
import java.awt.ComponentOrientation;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.SwingConstants;
import javax.swing.Timer;

import java.awt.Point;
import javax.swing.JComboBox;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import javax.swing.JTextField;
import javax.swing.JTextArea;
import java.awt.Font;
import java.util.ArrayList;
import java.awt.event.*; 

import javax.swing.JList;
import javax.swing.DefaultListModel;


public class GUI extends JApplet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	int nodeCounter = 0;

	Color redColor;
	Color yellowColor;
	Color blueColor;

	private JPanel jContentPane = null;

	private JButton performSearchButton = null;

	private JPanel optionsPanel = null;

	private JLabel goalLabel = null;

	private JTextField goalNodeTextField = null;

	private static Node node1Button = null;

	private static Node node2Button = null;

	private Node node3Button = null;

	private static JPanel nodePanel = null;

	private Node node4Button = null;

	private Node node5Button = null;

	private Node node6Button = null;

	private Node node7Button = null;

	private Node node8Button = null;

	private Node node9Button = null;

	private Node node10Button = null;

	private Node node11Button = null;

	private Node node12Button = null;

	private Node node13Button = null;

	private Node node14Button = null;

	private Node node15Button = null;

	private Node node16Button = null;

	private JTextArea jTextArea = null;

	private JPanel edgesPanel = null;

	private JLabel edgesLabel = null;

	static JList edgesList = null;
	
	private ArrayList<String> edgeList = new ArrayList<String>();
	
	int buttonClickedCounter = 0;

	public GUI() {
		super();
	}

	public void init() {
		this.setSize(504, 537);
		this.setContentPane(getJContentPane());
		GUI.populateSystemNodeList();
	}
	
	
	public static void updateVisitedNode(String nodeTextValue){
		for(Node node : DFSapp.systemNodeList)
		{
			if (nodeTextValue.equals(node.getText()))
			{
				node.setBackground(Color.GRAY);
				break;
			}
		}
	}//end updateVisitedNode()
	
	public static void updateGoalNode(String nodeTextValue){
		for(Node node : DFSapp.systemNodeList)
		{
			if (nodeTextValue.equals(node.getText()))
			{
				node.setBackground(Color.YELLOW);
				break;
			}
		}
	}//end updateGoalNode()
	
	public static void updatePathNode(String nodeTextValue){
		for(Node node : DFSapp.systemNodeList)
		{
			if (nodeTextValue.equals(node.getText()))
			{
				node.setBackground(Color.YELLOW);
				break;
			}
		}
	}
	private class SearchButtonActionListener implements ActionListener{

		public void actionPerformed(ActionEvent arg0) {
			
			String goalNodeTextValue = goalNodeTextField.getText();
			
			//The root node is the first char of the first edge defined in the list of edges
			TreeNode rootNode = new TreeNode(DFSapp.systemEdgeList.get(0).substring(0, 1));
			//Generate the tree from the system's edge list
			rootNode.generateChildren();
			
			
			//Initial search states
			int initialDepthLimit = 0;
			int initialDepth = 0;
			boolean result = false;
			
			//Traverse the tree using a DFS w/iterative deepening algorithm
			while (result == false)
			{
				result = rootNode.dfsidSearch(initialDepthLimit, initialDepth, goalNodeTextValue);
				//Through each necessary iteration, increase the allowed depth.
				initialDepthLimit++;
			}
			
			if(result)
				//Make sure to include the root in the path
				GUI.updatePathNode(rootNode.value);
			
		}//end actionPerformed
	}
	
	public static void populateSystemNodeList(){
		Component[] panelComponents = nodePanel.getComponents();
		//Component component;
		for(Component component : panelComponents)
		{
			if(component instanceof Node)
				DFSapp.systemNodeList.add((Node)component);
		}
		
	}//end populateSystemNodeList()
	
	public void start(){
		//this.setBackground(redColor);
	}

	/**
	 * This method initializes jContentPane	
	 * 	
	 * @return javax.swing.JPanel	
	 */
	private JPanel getJContentPane() {
		if (jContentPane == null) {
			jContentPane = new JPanel();
			jContentPane.setLayout(null);
			//jContentPane.setSize(200,200);
			jContentPane.add(getOptionsPanel(), null);
			jContentPane.add(getNodePanel(), null);
			jContentPane.add(getJTextArea(), null);
			jContentPane.add(getEdgesPanel(), null);
		}
		return jContentPane;
	}

	/**
	 * This method initializes performSearchButton	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getPerformSearchButton() {
		if (performSearchButton == null) {
			performSearchButton = new JButton();
			performSearchButton.setText("Search");
			performSearchButton.setBounds(new Rectangle(391, 17, 90, 29));
			performSearchButton.addActionListener(new SearchButtonActionListener());
		}
		return performSearchButton;
	}
	
	
	
	/**
	 * This method initializes optionsPanel	
	 * 	
	 * @return javax.swing.JPanel	
	 */
	private JPanel getOptionsPanel() {
		if (optionsPanel == null) {
			goalLabel = new JLabel();
			goalLabel.setBounds(new Rectangle(195, 15, 76, 31));
			goalLabel.setText("Goal Node:");
			optionsPanel = new JPanel();
			optionsPanel.setLayout(null);
			optionsPanel.setBounds(new Rectangle(1, 453, 502, 83));
			optionsPanel.add(getPerformSearchButton(), null);
			optionsPanel.add(goalLabel, null);
			optionsPanel.add(getGoalNodeTextField(), null);
		}
		return optionsPanel;
	}

	/**
	 * This method initializes goalNodeTextField	
	 * 	
	 * @return javax.swing.JTextField	
	 */
	private JTextField getGoalNodeTextField() {
		if (goalNodeTextField == null) {
			goalNodeTextField = new JTextField();
			goalNodeTextField.setBounds(new Rectangle(285, 15, 61, 31));
		}
		return goalNodeTextField;
	}

	/**
	 * This method initializes node1Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode1Button() {
		if (node1Button == null) {
			node1Button = new Node();
			node1Button.setBounds(new Rectangle(30, 30, 45, 29));
			node1Button.setText("1");
		}
		return node1Button;
	}

	/**
	 * This method initializes node2Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode2Button() {
		if (node2Button == null) {
			node2Button = new Node();
			node2Button.setText("2");
			node2Button.setSize(new Dimension(45, 29));
			node2Button.setLocation(new Point(90, 30));
		}
		return node2Button;
	}

	/**
	 * This method initializes node3Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode3Button() {
		if (node3Button == null) {
			node3Button = new Node();
			node3Button.setText("3");
			node3Button.setSize(new Dimension(45, 29));
			node3Button.setLocation(new Point(150, 30));
		}
		return node3Button;
	}

	/**
	 * This method initializes nodePanel	
	 * 	
	 * @return javax.swing.JPanel	
	 */
	private JPanel getNodePanel() {
		if (nodePanel == null) {
			nodePanel = new JPanel();
			nodePanel.setLayout(null);
			nodePanel.setBounds(new Rectangle(195, 120, 286, 271));
			nodePanel.add(getNode1Button(), null);
			nodePanel.add(getNode2Button(), null);
			nodePanel.add(getNode3Button(), null);
			nodePanel.add(getNode4Button(), null);
			nodePanel.add(getNode5Button(), null);
			nodePanel.add(getNode6Button(), null);
			nodePanel.add(getNode7Button(), null);
			nodePanel.add(getNode8Button(), null);
			nodePanel.add(getNode9Button(), null);
			nodePanel.add(getNode10Button(), null);
			nodePanel.add(getNode11Button(), null);
			nodePanel.add(getNode12Button(), null);
			nodePanel.add(getNode13Button(), null);
			nodePanel.add(getNode14Button(), null);
			nodePanel.add(getNode15Button(), null);
			nodePanel.add(getNode16Button(), null);
		}
		return nodePanel;
	}

	/**
	 * This method initializes node4Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode4Button() {
		if (node4Button == null) {
			node4Button = new Node();
			node4Button.setText("4");
			node4Button.setSize(new Dimension(45, 29));
			node4Button.setLocation(new Point(210, 30));
		}
		return node4Button;
	}

	/**
	 * This method initializes node5Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode5Button() {
		if (node5Button == null) {
			node5Button = new Node();
			node5Button.setLocation(new Point(30, 90));
			node5Button.setText("5");
			node5Button.setSize(new Dimension(45, 29));
		}
		return node5Button;
	}

	/**
	 * This method initializes node6Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode6Button() {
		if (node6Button == null) {
			node6Button = new Node();
			node6Button.setText("6");
			node6Button.setSize(new Dimension(45, 29));
			node6Button.setLocation(new Point(90, 90));
		}
		return node6Button;
	}

	/**
	 * This method initializes node7Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode7Button() {
		if (node7Button == null) {
			node7Button = new Node();
			node7Button.setText("7");
			node7Button.setSize(new Dimension(45, 29));
			node7Button.setLocation(new Point(150, 90));
		}
		return node7Button;
	}

	/**
	 * This method initializes node8Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode8Button() {
		if (node8Button == null) {
			node8Button = new Node();
			node8Button.setText("8");
			node8Button.setSize(new Dimension(45, 29));
			node8Button.setLocation(new Point(210, 90));
		}
		return node8Button;
	}

	/**
	 * This method initializes node9Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode9Button() {
		if (node9Button == null) {
			node9Button = new Node();
			node9Button.setText("9");
			node9Button.setSize(new Dimension(45, 29));
			node9Button.setLocation(new Point(30, 150));
		}
		return node9Button;
	}

	/**
	 * This method initializes node10Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode10Button() {
		if (node10Button == null) {
			node10Button = new Node();
			node10Button.setText("A");
			node10Button.setSize(new Dimension(45, 29));
			node10Button.setLocation(new Point(90, 150));
		}
		return node10Button;
	}

	/**
	 * This method initializes node11Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode11Button() {
		if (node11Button == null) {
			node11Button = new Node();
			node11Button.setText("B");
			node11Button.setSize(new Dimension(45, 29));
			node11Button.setLocation(new Point(150, 150));
		}
		return node11Button;
	}

	/**
	 * This method initializes node12Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode12Button() {
		if (node12Button == null) {
			node12Button = new Node();
			node12Button.setText("C");
			node12Button.setSize(new Dimension(45, 29));
			node12Button.setLocation(new Point(210, 150));
		}
		return node12Button;
	}

	/**
	 * This method initializes node13Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode13Button() {
		if (node13Button == null) {
			node13Button = new Node();
			node13Button.setText("D");
			node13Button.setSize(new Dimension(45, 29));
			node13Button.setLocation(new Point(30, 210));
		}
		return node13Button;
	}

	/**
	 * This method initializes node14Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode14Button() {
		if (node14Button == null) {
			node14Button = new Node();
			node14Button.setText("E");
			node14Button.setSize(new Dimension(45, 29));
			node14Button.setLocation(new Point(90, 210));
		}
		return node14Button;
	}

	/**
	 * This method initializes node15Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode15Button() {
		if (node15Button == null) {
			node15Button = new Node();
			node15Button.setText("F");
			node15Button.setSize(new Dimension(45, 29));
			node15Button.setLocation(new Point(150, 210));
		}
		return node15Button;
	}

	/**
	 * This method initializes node16Button	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getNode16Button() {
		if (node16Button == null) {
			node16Button = new Node();
			node16Button.setText("G");
			node16Button.setSize(new Dimension(45, 29));
			node16Button.setLocation(new Point(210, 210));
		}
		return node16Button;
	}

	/**
	 * This method initializes jTextArea	
	 * 	
	 * @return javax.swing.JTextArea	
	 */
	private JTextArea getJTextArea() {
		if (jTextArea == null) {
			jTextArea = new JTextArea();
			jTextArea.setLineWrap(true);
			jTextArea.setWrapStyleWord(true);
			jTextArea.setEditable(false);
			jTextArea.setFont(new Font("Dialog", Font.BOLD, 12));
			jTextArea.setBackground(new Color(238, 238, 238));
			jTextArea.setRows(0);
			jTextArea.setBounds(new Rectangle(15, 44, 466, 66));
			jTextArea.setText("Please click pairs of nodes to form an edge. When all the edges have been defined, enter the goal node and select Search. \n\nGray nodes have been visited and Yellow nodes dictate the path to the goal.");
		}
		return jTextArea;
	}

	/**
	 * This method initializes edgesPanel	
	 * 	
	 * @return javax.swing.JPanel	
	 */
	private JPanel getEdgesPanel() {
		if (edgesPanel == null) {
			edgesLabel = new JLabel();
			edgesLabel.setBounds(new Rectangle(15, 15, 121, 16));
			edgesLabel.setText("Edges:");
			edgesPanel = new JPanel();
			edgesPanel.setLayout(null);
			edgesPanel.setBounds(new Rectangle(15, 120, 166, 316));
			edgesPanel.add(edgesLabel, null);
			edgesPanel.add(getEdgesList(), null);
		}
		return edgesPanel;
	}


	private JList getEdgesList() {
		if (edgesList == null) {
			edgesList = new JList();
			edgesList.setBounds(new Rectangle(15, 30, 136, 271));
			edgesList.setModel(DFSapp.listModel);
		}
		return edgesList;
	}

}  //  @jve:decl-index=0:visual-constraint="10,10"
