package source;

import java.util.ArrayList;

public class TreeNode {
	String value;
	ArrayList<TreeNode> children = new ArrayList<TreeNode>();
	
	TreeNode(String textValue){
		value = textValue;
	}
	
	public void addChild(TreeNode child){
		children.add(child);
	}
	
	public String getTextValue(){
		return value;
	}
	
	public void generateChildren(){
		//Recursively generate the calling node's children.
		for(String edge : DFSapp.systemEdgeList)
		{
			//If the first char in an edge is equal to the parent's value
			if(edge.substring(0, 1).equals(this.value))
			{
				//The second char in the edge will define a child
				TreeNode newChild = new TreeNode(edge.substring(1, 2));
				newChild.generateChildren();
				this.addChild(newChild);
				
			}
		}
		
	}//end generateChildren()
	
//	public void dfsidSearch(String goalNodeText){
//		//If I am the goal node
//		if(goalNodeText.equals(this.value))
//		{
//			//Change the gui node to Yellow, indicating that you've found the goal
//			GUI.updateGoalNode(this.value);
//		}
//
//		//Otherwise
//		if(!goalNodeText.equals(this.value))
//		{
//			boolean result;
//
//			//Make me a visited node
//			GUI.updateVisitedNode(this.value);
//			
//			//Check my children
//			result = checkChildren(this, goalNodeText);
//
//			//If none of my children were the goal
//			if(result == false)
//			{
//				//For each child, repeat the process.
//				for(TreeNode myChild : this.children)
//					
//					myChild.checkChildren(myChild, goalNodeText);
////					myChild.dfsidSearch(goalNodeText);
//			}
//		}
		
//	}//end dfsidSearch()
	
	public boolean dfsidSearch(int depthLimit, int currentDepth, String goalNodeText)
	{
		//Check if I exceeded my allowed depth
		if(currentDepth > depthLimit)
			return false;
		
		//Check if the calling node is the goal node
		if(this.getTextValue().equals(goalNodeText)){
			
			//Change the gui node to Yellow, indicating that you've found the goal
			GUI.updateGoalNode(this.value);
			//GUI.delay();
			return true;
		}
		if(!this.getTextValue().equals(goalNodeText))
		{	
			GUI.updateVisitedNode(this.value);
		}
		
		//If we have not exceeded the allowed depth and have not found the goal node
		for(TreeNode child : this.children)
		{
			//Change the gui node to Gray, indicating that the node was visited
			GUI.updateVisitedNode(child.value);
						
			//Increase the allowed depth and search each of my child's children
			if(child.dfsidSearch(depthLimit, currentDepth + 1, goalNodeText))
			{
				GUI.updatePathNode(child.value);
				//If through the searching the children, we encounter a goal,
				//the call to dfsidSearch will return true. If this returns
				//true, then we should break the loop and return true.
				return true;
			}
		}
	
		return false;
	}
	
//	private boolean checkChildren(TreeNode parentNode, String goalNodeText){
//		for(TreeNode child : parentNode.children)
//		{
//			//Delay the changing of the node colors -- pause to observe path
//			GUI.delay();
//			
//			if(goalNodeText.equals(child.value))
//			{
//				//Change the gui node to Yellow, indicating that you've found the goal
//				GUI.updateGoalNode(child.value);
//				return true;
//			}
//			else if (!goalNodeText.equals(child.value))
//			{
//				GUI.updateVisitedNode(child.value);
//			}
//		}
//		return false;
//	}
	
	
}
