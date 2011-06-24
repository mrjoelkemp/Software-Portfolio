package system;

import java.io.IOException;
import java.util.Calendar;

import GUI.TheMain;

public class transaction {
	private int id;

	private int user_id;

	private int item_id;

	private long amount;

	private long timestamp;

	//Type can be: Bid, Withdrawn, Sold, Activated, Archived
	private String type;

	private int transaction_id = 0;

	private int transaction_user_id = 1;

	private int transaction_item_id = 2;

	private int transaction_amount = 3;

	private int transaction_timestamp = 4;

	private int transaction_type = 5;

	//Load Constructor
	public transaction(String data[][]) {

		id = Integer.parseInt(data[0][transaction_id]);
		user_id = Integer.parseInt(data[0][transaction_user_id]);
		item_id = Integer.parseInt(data[0][transaction_item_id]);
		amount = Long.parseLong(data[0][transaction_amount]);
		timestamp = Long.parseLong(data[0][transaction_timestamp]);
		type = data[0][transaction_type];
	}

	public transaction(int newUser_id, int newItem_id, long newAmount,
			String newType) throws IOException, Exception {

		id = 0;
		user_id = newUser_id;
		item_id = newItem_id;
		amount = newAmount;

		//timestamp is being stored as the milliseconds from the epoch.
		timestamp = Calendar.getInstance().getTimeInMillis();

		type = newType;
	}

	public String[][] getFieldsAndDataForXML() {
		String[][] temp = { { "numberOfFields", "6" },
				{ "type", "transaction" }, { "id", String.valueOf(id) },
				{ "timestamp", String.valueOf(timestamp) },
				{ "user_id", String.valueOf(user_id) },
				{ "item_id", String.valueOf(item_id) },
				{ "amount", String.valueOf(amount) }, { "type", type } };
		return temp;
	}

	void storeTransaction() throws IOException, Exception {
		id = TheMain.global_db.getMaxId("transaction") + 1;
		TheMain.global_db.insert(this.getFieldsAndDataForXML());
	}

	public void setInfo(String field, String value) {
		/*
		 * Purpose: Setter of the attributes of the item class.
		 */

		if (field.equalsIgnoreCase("id"))
			id = Integer.parseInt(value);
		else if (field.equalsIgnoreCase("item_id"))
			item_id = Integer.parseInt(value);
		else if (field.equalsIgnoreCase("timestamp"))
			timestamp = Long.parseLong(value);
		else if (field.equalsIgnoreCase("type"))
			type = value;
		else if (field.equalsIgnoreCase("user_id"))
			user_id = Integer.parseInt(value);
	}

	public void update() throws IOException, Exception {
		TheMain.global_db.update(this.getFieldsAndDataForXML());
	}
}
