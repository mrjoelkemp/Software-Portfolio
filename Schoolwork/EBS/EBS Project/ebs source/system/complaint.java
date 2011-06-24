package system;

import java.io.IOException;
import java.lang.String;
import java.lang.Integer;

import GUI.TheMain;

public class complaint {

	private int id;

	private String status;

	private String type_of;

	private int userOrItem_id;

	private int complainer_id;

	private String complaintText;

	private int complaint_id = 0;

	private int complaint_type_of = 1;

	private int complaint_userOrItem_id = 2;

	private int complaint_complainer_id = 3;

	private int complaint_complaintText = 4;

	private int complaint_status = 5;

	//Load Constructor
	public complaint(String data[][]) {

		id = Integer.parseInt(data[0][complaint_id]);
		type_of = data[0][complaint_type_of];
		userOrItem_id = Integer.parseInt(data[0][complaint_userOrItem_id]);
		complainer_id = Integer.parseInt(data[0][complaint_complainer_id]);
		complaintText = data[0][complaint_complaintText];
		status = data[0][complaint_status];
	}

	public complaint(String newType_of, int newUserOrItem_id,
			int newComplainer_id, String newComplaintText) throws IOException,
			Exception {

		id = 0;
		type_of = newType_of;
		userOrItem_id = newUserOrItem_id;
		complainer_id = newComplainer_id;
		complaintText = newComplaintText;
		status = "Pending";
	}

	public String[][] getFieldsAndDataForXML() {
		String[][] fieldsAndData;

		fieldsAndData = new String[][] { { "numberOfFields", "6" },
				{ "type", "complaint" }, { "id", String.valueOf(id) },
				{ "type_of", String.valueOf(type_of) },
				{ "userOrItem_id", String.valueOf(userOrItem_id) },
				{ "complainer_id", String.valueOf(complainer_id) },
				{ "complaintText", complaintText }, { "status", status } };

		return fieldsAndData;

	}

	public String getInfo(String field) {

		String result = null;

		if (field == "id")
			result = String.valueOf(id);
		else if (field == "type")
			result = type_of;
		else if (field == "userOrItem_id")
			result = String.valueOf(userOrItem_id);
		else if (field == "complainer_id")
			result = String.valueOf(complainer_id);
		else if (field == "complaintText")
			result = complaintText;
		else if (field == "status")
			result = status;

		return result;

	}

	public void setInfo(String field, String value) {
		if (field == "type")
			type_of = value;
		else if (field == "userOrItem_id")
			userOrItem_id = Integer.parseInt(value);
		else if (field == "complainer_id")
			complainer_id = Integer.parseInt(value);
		else if (field == "complaintText")
			complaintText = value;
		else if (field == "status")
			status = value;
	}

	public boolean parse() {
		if (complaintText.length() > 1)
			return true;
		else
			return false;
	}

	public void submitComplaint() throws IOException, Exception {
		id = Database.getMaxId("complaint") + 1;
		TheMain.global_db.insert(getFieldsAndDataForXML());
	}

	public void update() throws IOException, Exception {
		/*
		 * Purpose: To pass updated item information to the item.xml database
		 * for storage.
		 */

		TheMain.global_db.update(this.getFieldsAndDataForXML());
	}

}
