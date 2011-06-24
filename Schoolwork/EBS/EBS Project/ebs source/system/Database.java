package system;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Observable;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;

import GUI.TheMain;

import com.sun.org.apache.xml.internal.serialize.OutputFormat;
import com.sun.org.apache.xml.internal.serialize.XMLSerializer;

public class Database extends Observable{

	private String[] fieldsInUser = { "id", "SA", "status", "complaints", "username",
			"password", "creditCard", "firstName", "lastName", "address",
			"city", "state", "zipCode", "phoneNumber", "emailAddress" };

	private String[] fieldsInComplaint = { "id", "type", "userOrItem_id", "complainer_id", "complaint_text", "status" };

	private String[] fieldsInItem = { "id", "startTime", "title", "currentPrice", "endTime",
			"user_id", "startPrice", "pictureFileName", "description", "status" };

	private String[] fieldsInTransaction = { "id", "user_id", "item_id", "amount",
			"timestamp", "type" };

	private String[] prettyFieldsInUser = { "Item #", "SA", "Status", "# Complaints", "Username",
			"Password", "Credit Card #", "First Name", "Last Name", "Address",
			"City", "State", "Zip Code", "Phone Number", "E-mail Address" };

	private String[] prettyFieldsInComplaint = { "Complaint #", "Type", "Complaint Against", "Complainer ID", "Complaint", "Status" };

	private String[] prettyFieldsInItem = { "Item #", "Start Time", "Title", "Current Price", "End Time",
			"Seller ID", "Start Price", "Picture", "Description", "Status" };

	private String[] prettyFieldsInTransaction = { "Transaction #", "User ID", "Item ID", "Amount",
			"Timestamp", "Type" };

	private static Document dom;

	private static final String dbFileName = "./xml/data.xml";

	private static Element rootElement = null;

	private static Node usersRootElement = null;

	private static Node itemsRootElement = null;

	private static Node complaintsRootElement = null;

	private static Node transactionsRootElement = null;

	public Database() throws IOException, Exception {
		super();
		dom = createDocumentFromFile(dbFileName);

		rootElement = dom.getDocumentElement();

		usersRootElement = rootElement.getFirstChild();
		itemsRootElement = usersRootElement.getNextSibling();
		complaintsRootElement = itemsRootElement.getNextSibling();
		transactionsRootElement = complaintsRootElement.getNextSibling();
	}

	public String[][] select(String tableName, String whereField,
			String lookingFor, String placeHolder) {
		String[][] results = null; // Stores the results to return
		String xpath = null; // Stores xpath search string
		NodeList nodeResults = null;// Stores the results of the xpath query
		int numOfResults = 0; // Stores the number of results returned from
		// the xpath query

		try {
			// Get all results
			if ( whereField == null ) 
				xpath = "/*/" + tableName + "/*";
			
			// If we're looking for an id, it's an attribute
			else if (whereField.equalsIgnoreCase("id"))
				xpath = "/*/" + tableName + "/*[@id=\"" + lookingFor + "\"]";
			else {
				// Otherwise it's an element
				
			// Match search terms
					xpath = "/*/" + tableName + "/*[" + whereField + "=\""
						+ lookingFor + "\"]";
			}

			nodeResults = com.sun.org.apache.xpath.internal.XPathAPI.selectNodeList(dom, xpath);

			// Store the number of results for efficiency in for loop and
			// to initialize the return object
			numOfResults = nodeResults.getLength();
			
			// Set the number of rows to the number of results from the xpath
			// search
			results = new String[numOfResults][];

			// Check that the xpath query returned something
			if ((nodeResults != null) && (numOfResults > 0)) {
				// Process the elements in the nodelist
				for (int i = 0; i < numOfResults; i++) {

					// Get element
					Element workingElement = (Element) nodeResults.item(i);

					if (tableName.equalsIgnoreCase("users"))
						// gets all of a user's information and returns it as an
						// object
						results[i] = getUserInformation(workingElement);
					else if (tableName.equalsIgnoreCase("items"))
						results[i] = getItemInformation(workingElement);
					else if (tableName.equalsIgnoreCase("complaints"))
						results[i] = getComplaintInformation(workingElement);
					else if (tableName.equalsIgnoreCase("transactions"))
						results[i] = getTransactionInformation(workingElement);

				}// end of for loop

			}// end of if statement

		}// end of try

		catch (javax.xml.transform.TransformerException e) {

		}// end of catch

		return results;

	}

	public Element select(String tableName, String whereField,
			String lookingFor) {
		String xpath = null; // Stores xpath search string
		NodeList nodeResults = null;// Stores the results of the xpath query

		try {
			// If we're looking for an id, it's an attribute
			if (whereField == null || lookingFor == null)
				xpath = "/*/" + tableName + "/*";
			else if (whereField.equalsIgnoreCase("id"))
				xpath = "/*/" + tableName + "/*[@id=\"" + lookingFor + "\"]";
			else
				// Otherwise it's an element
				xpath = "/*/" + tableName + "/*[" + whereField + "=\""
						+ lookingFor + "\"]";

			nodeResults = com.sun.org.apache.xpath.internal.XPathAPI
					.selectNodeList(dom, xpath);
		}// end of try

		catch (javax.xml.transform.TransformerException e) {

		}// end of catch

		return (Element) nodeResults.item(0);

	}

	public void update(String[][] data) {

		Element typeEle = null;

		Node typeNode = null; // Holds the type node, eg an item node, a
		// user node
		Node newNode = null; // Holds the updated information

		int idToUpdate; // The unique id extracted from the passed
		// data variable
		String updateType = null; // The type of object we are updating
		NodeList nodeResults = null;// Holds out query results

		// Create a node from the passed data
		newNode = createTypeElement(data);

		// Get the id for the record that we want to update
		idToUpdate = Integer.parseInt(data[2][1]);

		// Get the type of object being updated
		updateType = data[1][1];

		// Choose the root element according to the type
		if (updateType.equalsIgnoreCase("user")){
			// Add the node to the users root
		
			// Loop through all the items
			for (Node userNode = usersRootElement.getFirstChild(); userNode != null; userNode = userNode
					.getNextSibling()) {
				String currentNodeID = userNode.getAttributes().item(0).getTextContent();

				if (currentNodeID.equalsIgnoreCase(String.valueOf(idToUpdate))) {

					int i = 3;
					// Loop through the item's values
					for (Node valueNode = userNode.getFirstChild(); valueNode != null; valueNode = valueNode
							.getNextSibling()) {
						valueNode.setTextContent(data[i][1]);
						i++;
					}
					break;
				}
			}//end for
		}//end if
		
		else if (updateType.equalsIgnoreCase("item")) {
			// Add the node to the users root

			// Loop through all the items
			for (Node itemNode = itemsRootElement.getFirstChild(); itemNode != null; itemNode = itemNode
					.getNextSibling()) {
				String currentNodeID = itemNode.getAttributes().item(0).getTextContent();

				if (currentNodeID.equalsIgnoreCase(String.valueOf(idToUpdate))) {

					int i = 3;
					// Loop through the item's values
					for (Node valueNode = itemNode.getFirstChild(); valueNode != null; valueNode = valueNode
							.getNextSibling()) {
						valueNode.setTextContent(data[i][1]);
						i++;
					}
					break;
				}
			}//end for
		}//end else if
		
		else if (updateType.equalsIgnoreCase("complaint")) {
			// Add the node to the users root

			// Loop through all the items
			for (Node complaintNode = complaintsRootElement.getFirstChild(); complaintNode != null; complaintNode = complaintNode
					.getNextSibling()) {
				String currentNodeID = complaintNode.getAttributes().item(0).getTextContent();

				if (currentNodeID.equalsIgnoreCase(String.valueOf(idToUpdate))) {

					int i = 3;
					// Loop through the item's values
					for (Node valueNode = complaintNode.getFirstChild(); valueNode != null; valueNode = valueNode
							.getNextSibling()) {
						valueNode.setTextContent(data[i][1]);
						i++;
					}
					break;
				}
			}//end for
		}//end else if

		else if (updateType.equalsIgnoreCase("transaction")) {
			// Add the node to the users root

			// Loop through all the items
			for (Node transactionNode = transactionsRootElement.getFirstChild(); transactionNode != null; transactionNode = transactionNode
					.getNextSibling()) {
				String currentNodeID = transactionNode.getAttributes().item(0).getTextContent();

				if (currentNodeID.equalsIgnoreCase(String.valueOf(idToUpdate))) {

					int i = 3;
					// Loop through the item's values
					for (Node valueNode = transactionNode.getFirstChild(); valueNode != null; valueNode = valueNode
							.getNextSibling()) {
						valueNode.setTextContent(data[i][1]);
						i++;
					}
					break;
				}
			}//end for
		}//end else if

		printToFile();

		// Update observers
		setChanged();
		notifyObservers();
		
	}

	public static Document createDocumentFromFile(String doc_name1)
			throws Exception, IOException {
		/*
		 * Purpose: To create a DOM from an existing xml file.
		 * 
		 * XML Files Used: items.xml, users.xml, complaints.xml,
		 * transactions.xml
		 * 
		 */

		Document dom1 = null;

		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		try {
			DocumentBuilder db = dbf.newDocumentBuilder();

			// Parse the xml file and create a DOM from the elements in the file
			dom1 = db.parse(doc_name1);

		} catch (ParserConfigurationException pce) {
			System.out
					.println("Error while trying to instantiate DocumentBuilder "
							+ pce);
			System.exit(1);
		}

		// Return the DOM that contains the parsed xml data.
		return dom1;
	}

	private static void printToFile() {
		try {
			// print
			OutputFormat format = new OutputFormat(dom);
			format.setIndenting(false);

			// generate file output
			XMLSerializer serializer = new XMLSerializer(new FileOutputStream(
					new File(dbFileName)), format);
			serializer.serialize(dom);

		} catch (IOException ie) {
			ie.printStackTrace();
		}
	}

	private static String[] getItemInformation(Element itemElement) {

		String id = getID(itemElement);
		String status = getText(itemElement, "status");
		String startTime = getText(itemElement, "startTime");
		String title = getText(itemElement, "title");
		String description = getText(itemElement, "description");
		String startPrice = getText(itemElement, "startPrice");
		String currentPrice = getText(itemElement, "currentPrice");
		String endTime = getText(itemElement, "endTime");
		String pictureFileName = getText(itemElement, "pictureFileName");
		String user_id = getText(itemElement, "user_id");

		String[] itemInformation = { id, startTime, title, currentPrice, endTime,
				user_id, startPrice, pictureFileName, description, status };

		return itemInformation;

	}

	/*
	 * This function returns
	 * SA,status,complaints,username,password,s_creditCard,
	 * firstName,lastName,address,city,state,s_zipCode,phoneNumber,emailAddress
	 */
	private static String[] getUserInformation(Element userElement) {

		// for a given user element get the values of the
		// user information

		String user_id = getID(userElement);
		String complaints = getText(userElement, "numberOfComplaints");
		String SA = getText(userElement, "SA");
		String status = getText(userElement, "status");
		String password = getText(userElement, "password");
		String username = getText(userElement, "username");
		String firstName = getText(userElement, "firstName");
		String lastName = getText(userElement, "lastName");
		String address = getText(userElement, "address");
		String city = getText(userElement, "city");
		String state = getText(userElement, "state");
		String zipCode = getText(userElement, "zipCode");
		String creditCard = getText(userElement, "creditCard");
		String phoneNumber = getText(userElement, "phoneNumber");
		String emailAddress = getText(userElement, "emailAddress");

		String[] ouInformation = { user_id, SA, status, complaints, username,
				password, creditCard, firstName, lastName, address, city,
				state, zipCode, phoneNumber, emailAddress };

		return ouInformation;
	}

	/*
	 * This function returns type_of, userOrItem_id, complainer_id,
	 * complaintText
	 */
	private static String[] getComplaintInformation(Element complaintElement) {

		// for a given user element get the values of the
		// user information
		
		String id = getID(complaintElement);
		String type_of = getText(complaintElement, "type_of");
		String userOrItem_id = getText(complaintElement, "userOrItem_id");
		String complainer_id = getText(complaintElement, "complainer_id");
		String complaintText = getText(complaintElement, "complaintText");
		String status = getText(complaintElement, "status");

		String[] complaintInformation = { id, type_of, userOrItem_id,
				complainer_id, complaintText, status };

		return complaintInformation;
	}

	/*
	 * This function returns user_id, item_id, amount, timestamp, type
	 */
	private static String[] getTransactionInformation(Element transactionElement) {

		// for a given user element get the values of the
		// user information

		String id = getID(transactionElement);
		String user_id = getText(transactionElement, "user_id");
		String item_id = getText(transactionElement, "item_id");
		String amount = getText(transactionElement, "amount");
		String timestamp = getText(transactionElement, "timestamp");
		String type = getText(transactionElement, "type");

		String[] transactionInformation = { id, user_id, item_id, amount, timestamp,
				type };

		return transactionInformation;
	}

	// Changes the given element into a text based form
	private static String getText(Element ele, String tagName) {
		String toText = null;

		// tagname is the name of the tag in the XML file that you want to be
		// retrieved
		NodeList node1 = ele.getElementsByTagName(tagName);

		if (node1 != null && node1.getLength() > 0) {
			Element element = (Element) node1.item(0);
			toText = element.getFirstChild().getNodeValue();

		}

		return toText;
	}

	private static String getID(Element element) {
		return element.getAttribute("id");

	}

	public static int getMaxId(String tableName) throws IOException, Exception {
		/*
		 * Purpose: Find largest id in doc_name database and return that number.
		 */
		// Set default value
		int max_id = 0;
		
		Node lastChild = null;

		// Find the largest id currently in the associated root element
		
		if (tableName== "user" && usersRootElement.getChildNodes().getLength() !=0) {
			lastChild = usersRootElement.getLastChild();
			max_id = Integer.parseInt(lastChild.getAttributes().item(0).getTextContent());
		}
		else if (tableName== "item" && itemsRootElement.getChildNodes().getLength() !=0) {
			lastChild = itemsRootElement.getLastChild();
			max_id = Integer.parseInt(lastChild.getAttributes().item(0).getTextContent());
		}
		else if (tableName== "complaint" && complaintsRootElement.getChildNodes().getLength() !=0) {
			lastChild = complaintsRootElement.getLastChild();
			max_id = Integer.parseInt(lastChild.getAttributes().item(0).getTextContent());
		}
		else if (tableName== "transaction" && transactionsRootElement.getChildNodes().getLength() !=0) {
			lastChild = transactionsRootElement.getLastChild();
			max_id = Integer.parseInt(lastChild.getAttributes().item(0).getTextContent());
		}
				
		// Return this value
		return max_id;
	}

	private static Element createTypeElement(String[][] data) {
		/*
		 * Purpose: Create a child to be used in the DOM tree and Return that
		 * child.
		 * 
		 * Note: currentFieldsAndData[][] is set to contain the attribute values
		 * passed in. This allows a child to be created from that information.
		 */

		int n = Integer.parseInt(data[0][1]);

		Element typeEle = dom.createElement(data[1][1]);
		typeEle.setAttribute(data[2][0], data[2][1]);

		for (int i = 3; i < n + 2; i++) {
			// Create field entries for type
			Element fieldEle = dom.createElement(data[i][0]);
			Text fieldText = dom.createTextNode(data[i][1]);
			fieldEle.appendChild(fieldText);
			typeEle.appendChild(fieldEle);

		}

		return typeEle;
	}

	public void insert(String[][] data) throws IOException, Exception {
		/*
		 * Purpose: Carries out the tasks necessary to create the valid xml
		 * document.
		 * 
		 */

		// Load user information
		// currentFieldsAndData = data;
		Element typeEle = null;
		String insertType = data[1][1];

		// Use the type of the element and add it to the appropriate root
		// element

		if (insertType.equalsIgnoreCase("user")) {
			// Create the node to insert
			typeEle = createTypeElement(data);
			// Add the node to the users root
			usersRootElement.appendChild(typeEle);
		}
		if (insertType.equalsIgnoreCase("item")) {
			// Create the node to insert
			typeEle = createTypeElement(data);
			// Add the node to the users root
			itemsRootElement.appendChild(typeEle);
		}
		if (insertType.equalsIgnoreCase("complaint")) {
			// Create the node to insert
			typeEle = createTypeElement(data);
			// Add the node to the users root
			complaintsRootElement.appendChild(typeEle);
		}
		if (insertType.equalsIgnoreCase("transaction")) {
			// Create the node to insert
			typeEle = createTypeElement(data);
			// Add the node to the users root
			transactionsRootElement.appendChild(typeEle);
		}

		// Output to file
		printToFile();
		
		// Update observers
		setChanged();
		notifyObservers();


	}
	
	public String[] getArrayOfFieldsFor (String tableName) {
		String [] fields = null;
		
		if (tableName.equalsIgnoreCase("users"))
			fields = fieldsInUser;
		else if (tableName.equalsIgnoreCase("items"))
			fields = fieldsInItem;
		else if (tableName.equalsIgnoreCase("complaints"))
			fields = fieldsInComplaint;
		else if (tableName.equalsIgnoreCase("transactions"))
			fields = fieldsInTransaction;
		
		return fields;
		}

	public String[] getPrettyArrayOfFieldsFor (String tableName) {
		String [] fields = null;
		
		if (tableName.equalsIgnoreCase("users"))
			fields = prettyFieldsInUser;
		else if (tableName.equalsIgnoreCase("items"))
			fields = prettyFieldsInItem;
		else if (tableName.equalsIgnoreCase("complaints"))
			fields = prettyFieldsInComplaint;
		else if (tableName.equalsIgnoreCase("transactions"))
			fields = prettyFieldsInTransaction;
		
		return fields;
		}
	public void updateManyObjects(String type, String matchField, String matchValue, String[] updateFields, String[] updateValues) throws IOException, Exception{
		Object workingObject = null;
		// Get the objects to update
		String [][] data = TheMain.global_db.select(type+"s", matchField, matchValue, "");
		
		int n = data.length;
		
		for ( int i = 0; i < n; i++ ) {
			// Create an object for each entry
			if ( type.equalsIgnoreCase("user")) {
				workingObject = new user(TheMain.global_db.select("users", "id", data[i][0], ""));
					
				// Update each field in updateFields with each value in updateValue
				for ( int j = 0; j < updateFields.length; j++) {
					((user) workingObject).setInfo(updateFields[j], updateValues[j]);
				}				
				// Save the changes
				((user) workingObject).update();
			}
			else if ( type.equalsIgnoreCase("item")) {
				workingObject = new item(TheMain.global_db.select("items", "id", data[i][0], ""));
				
				// Update each field in updateFields with each value in updateValue
				for ( int j = 0; j < updateFields.length; j++) {
					((item) workingObject).setInfo(updateFields[j], updateValues[j]);
				}				
				// Save the changes
				((item) workingObject).update();
			
			}
			else if ( type.equalsIgnoreCase("complaint")) {
				workingObject = new complaint(TheMain.global_db.select("complaints", "id", data[i][0], ""));
				
				// Update each field in updateFields with each value in updateValue
				for ( int j = 0; j < updateFields.length; j++) {
					((complaint) workingObject).setInfo(updateFields[j], updateValues[j]);
				}				
				// Save the changes
				((complaint) workingObject).update();

			}
			else if ( type.equalsIgnoreCase("transaction")) {
				workingObject = new transaction(TheMain.global_db.select("transactions", "id", data[i][0], "")); 
			
				// Update each field in updateFields with each value in updateValue
				for ( int j = 0; j < updateFields.length; j++) {
					((transaction) workingObject).setInfo(updateFields[j], updateValues[j]);
				}				
				// Save the changes
				((transaction) workingObject).update();
			}
		}//end For loop
	}//end updateManyObjects
}
