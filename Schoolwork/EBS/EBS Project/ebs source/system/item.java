package system;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import GUI.TheMain;

public class item {
	/*
	 * Author: Joel Kemp, Jamal Goddard, Daniel Ranells
	 * 
	 * Purpose: Creates a new item that users can control or bid on.
	 * 
	 * Important Attributes:
	 * 
	 * -int endTime 
	 * 		endTime holds the number of days for active auction.
	 * -Calendar startTime 
	 * 		startTime set to current date and time.
	 * 
	 */

	private int id;

	private String title;
	
	private String description;

	private long startPrice;

	private long currentPrice;

	private long startTime;

	private long endTime;

	private String pictureFileName;

	private int user_id;

	private String status;
	
	private final int item_id = 0;

	private final int item_title = 2;
	
	private final int item_startTime = 1;
	
	private final int item_currentPrice = 3;
	
	private final int item_endTime = 4;
	
	private final int item_user_id = 5;
	
	private final int item_startPrice = 6;
	
	private final int item_pictureFileName = 7;
	
	private final int item_description = 8;
	
	private final int item_status = 9;
	
	
	//Load constructor
	public item(String data[][]){
		
		id = Integer.parseInt(data[0][item_id]);
		title = data[0][item_title];
		startTime = Long.parseLong(data[0][item_startTime]);
		currentPrice = Long.parseLong(data[0][item_currentPrice]);
		endTime = Long.parseLong(data[0][item_endTime]);
		user_id = Integer.parseInt(data[0][item_user_id]);
		startPrice = Long.parseLong(data[0][item_startPrice]);
		pictureFileName = data[0][item_pictureFileName];		
		description = data[0][item_description];
		status = data[0][item_status];
	}
	
	// Constructor for the Item class.
	public item(String newTitle, String newDescription, long newStartPrice, long newCurrentPrice,
			int newEndTime, String newPictureFileName, int newUser_id)
			 {
		id = 0;

		title = newTitle;
		description = newDescription;
		startPrice = newStartPrice;
		currentPrice = newCurrentPrice;
		startTime = Calendar.getInstance().getTimeInMillis();
		endTime = startTime + (newEndTime * 86400000);
		status = "Pending";
		pictureFileName = newPictureFileName;
		user_id = newUser_id;

	}

	public String[][] getFieldsAndDataForXML() {
		/*
		 * Purpose: Pass the item attribute values to the database.
		 * 
		 */

		String[][] fieldsAndData;

		fieldsAndData = new String[][] { { "numberOfFields", "10" },
				{ "type", "item" }, 
				{ "id", String.valueOf(id) },
				{ "status", status },
				{ "startTime", String.valueOf(startTime) }, { "title", title },
				{ "startPrice", String.valueOf(startPrice) },
				{ "currentPrice", String.valueOf(currentPrice) },
				{ "endTime", String.valueOf(endTime) },
				{ "pictureFileName", pictureFileName },
				{ "user_id", String.valueOf(user_id) },
				{ "description", description } };

		return fieldsAndData;
	}

	public String getInfo(String field) {
		/*
		 * Purpose: Getter of the attributes of the item class.
		 * 
		 */

		String result = new String();
		result = null;
		if (field == "id")
			result = String.valueOf(id);
		else if (field == "title")
			result = title;
		else if (field == "description")
			result = description;
		else if (field == "startPrice")
			result = String.valueOf(startPrice);
		else if (field == "currentPrice")
			result = String.valueOf(currentPrice);
		else if (field == "startTime")
			result = String.valueOf(startTime);
		else if (field == "endTime")
			result = String.valueOf(endTime);
		else if (field == "pictureFileName")
			result = pictureFileName;
		else if (field == "user_id")
			result = String.valueOf(user_id);
		else if (field == "status")
			result = status;

		return result;
	}

	public void setInfo(String field, String value) {
		/*
		 * Purpose: Setter of the attributes of the item class.
		 */

		if (field == "id")
			id = Integer.parseInt(value);
		else if (field == "title")
			title = value;
		else if (field == "description")
			description = value;
		else if (field == "startPrice")
			startPrice = Long.parseLong(value);
		else if (field == "endTime")
			endTime = Long.parseLong(value);
		else if (field == "pictureFileName")
			pictureFileName = value;
		else if (field == "user_id")
			user_id = Integer.parseInt(value);
		else if (field == "status")
			status = value;
	}

	public void post() throws IOException, Exception {
		/*
		 * Purpose: Insert a new item into the database.
		 */

		id = Database.getMaxId("item") + 1;
		TheMain.global_db.insert(this.getFieldsAndDataForXML());
	}

	public void bid(Long currentBid) throws IOException, Exception {
		/*
		 * Purpose: Allow a user to bid on an item. Once a bid is made, it is
		 * recorded as a transaction.
		 */
		
		/* OBJECTIVE: 
		 * 	Find the two highest bids in highBids, Set highBid equal to the
		 * 	highest bid Set highBid2 equal to the second highest bid
		 * 
		 * 	If highBid is equal to highBid2 Then currentPrice is equal to highBid
		 * 	Else currentPrice is equal to highBid2 + 1
		 */

		long systemIncValue = 1;
		
		long currentHighestBid = getHighestBid();
		
		// If there are no bids for this item yet, the current bid is the only one
		// increment the curent price by the system increment
		if ( currentHighestBid == 0)
			currentPrice += systemIncValue;
		else {
			// If the high bid and the current bid are equal
			if ( currentHighestBid == currentBid)
				currentPrice = currentHighestBid;
			// the current bid is less than the highest bid
			else if ( currentBid < currentHighestBid )
				currentPrice = currentBid + systemIncValue;
			// the current highest bid is now the second highest bid
			else if ( currentHighestBid < currentBid )
				currentPrice = currentHighestBid + systemIncValue;
			
		}
		
		// Construct a double-scripted array to pass to the transaction xml file
		String[][] temp = { { "0", TheMain.global_user.getInfo("id"), String.valueOf(id),
			String.valueOf(currentBid) , String.valueOf(Calendar.getInstance().getTimeInMillis()), "bid" } };
				
		transaction t1 = new transaction(temp);
		
		// Store transaction
		t1.storeTransaction();
		
		//Call to database function that will store the updated item information.
		update();
	}

	
	// Gets the highest bid for this item, returns 0 if there are no bids for this item
	private long getHighestBid() {
		// field identifier from transaction.java
		int transaction_amount = 3;
		
		long highestBid = 0;
		// get all the bids on this item
		String[][] highBids = TheMain.global_db.select("transactions", "item_id", String.valueOf(id), "");
		
		int highBidsLength = highBids.length;
		
		for ( int i = 0; i< highBidsLength ; i++){
			long bidAmount = Long.parseLong(highBids[i][transaction_amount]);
			if (bidAmount > highestBid)
				highestBid = bidAmount;
		}
		return highestBid;
	}
	
	public void withdraw() throws IOException, Exception {
		/*
		 * Purpose: Change the status of an Item to withdrawn.
		 */

		status = "withdrawn";
	}

	public void update() throws IOException, Exception {
		/*
		 * Purpose: To pass updated item information to the item.xml database
		 * for storage.
		 */

		TheMain.global_db.update(this.getFieldsAndDataForXML());
	}

}
