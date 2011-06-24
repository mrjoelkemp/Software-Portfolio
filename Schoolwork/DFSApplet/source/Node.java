package source;

import java.awt.Component;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;

public class Node extends JButton implements ActionListener{

	private static final long serialVersionUID = 1L;
	
	public Node()
	{
		this.addActionListener(this);
	}

	public void actionPerformed(ActionEvent e) {
		if(e.getSource() != null)
		{
			//Increment the total number of buttons clicked
			DFSapp.numberButtonsClicked++;
					
			if(DFSapp.numberButtonsClicked == 1)
			{
				DFSapp.previousNodeClicked = this.getText();
			}
			
			//If the number of buttons clicked == 2 and you did not click the same button twice
			if (DFSapp.numberButtonsClicked == 2 && DFSapp.previousNodeClicked != this.getText())
			{	
				//Create an edge between the clicked button and the previously clicked button.
				String newEdge = DFSapp.previousNodeClicked + this.getText();
				
				//Add the edge to the edge list.
				DFSapp.systemEdgeList.add(newEdge);

				String prettyString = "(" + newEdge.substring(0,1) + ", " + newEdge.substring(1) + ")";
					
				//Update the edgesList GUI component's list model
				DFSapp.listModel.addElement(prettyString);
				
				//Update the edgesList GUI component
				GUI.edgesList.setModel(DFSapp.listModel);
				
				//Reset the number of buttons clicked
				DFSapp.numberButtonsClicked = 0;
			}
		}
		
	}
	

}
