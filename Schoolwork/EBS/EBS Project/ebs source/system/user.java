package system;

import java.io.IOException;
import java.lang.String;
import java.lang.Integer;

import GUI.TheMain;

public class user {
	/*
	 * Author: Joel Kemp, Jamal Goddard, Daniel Ranells
	 * 
	 * Purpose: Creates a new user that will have access to the system
	 * functionality.
	 * 
	 * Important Attributes:
	 * 
	 * -Boolean SA Determines whether or not the user is a System Administrator.
	 * Default is false. -String status Labels the user as "pending", "blocked",
	 * or "registered". -String password Contains the user's password. When the
	 * user object is instantiated, this password is set to be equal to the
	 * user's phone number. -String creditCard Contains the credit card number
	 * defined by the end-user.
	 */
	private int id;

	private int complaints;

	private boolean SA;

	private String status;

	private String userName;

	private String password;

	private String firstName;

	private String lastName;

	private String address;

	private String city;

	private String state;

	private String zipCode;

	private String creditCard;

	private String phoneNumber;

	private String emailAddress;

	// Constructor for user class.
	public user(String newUsername, String newFirstName, String newLastName,
			String newAddress, String newCity, String newState,
			String newZipCode, String newCreditCard, String newPhoneNumber,
			String newEmailAddress) throws IOException, Exception {

		id = 0;

		complaints = 0;
		SA = false;
		status = "Pending";
		userName = newUsername;
		firstName = newFirstName;
		lastName = newLastName;
		address = newAddress;
		city = newCity;
		state = newState;
		zipCode = newZipCode;
		creditCard = newCreditCard;
		phoneNumber = newPhoneNumber;
		emailAddress = newEmailAddress;
		password = phoneNumber;
	}

	private final int user_id = 0;

	private final int user_numComplaints = 3;

	private final int user_SA = 1;

	private final int user_status = 2;

	private final int user_password = 5;

	private final int user_userName = 4;

	private final int user_firstName = 7;

	private final int user_lastName = 8;

	private final int user_address = 9;

	private final int user_city = 10;

	private final int user_state = 11;

	private final int user_zipCode = 12;

	private final int user_creditCard = 6;

	private final int user_phoneNumber = 13;

	private final int user_emailAddress = 14;

	public user(String[][] data) {
		/*
		 * Constructor is for loading purposes only, not for creating a new user. 
		 * ex: once a user logs in, load all their information into an object.
		 */

		id = Integer.parseInt(data[0][user_id]);
		complaints = Integer.parseInt(data[0][user_numComplaints]);
		SA = Boolean.valueOf(data[0][user_SA]);
		status = data[0][user_status];
		userName = data[0][user_userName];
		firstName = data[0][user_firstName];
		lastName = data[0][user_lastName];
		address = data[0][user_address];
		city = data[0][user_city];
		state = data[0][user_state];
		zipCode = data[0][user_zipCode];
		creditCard = data[0][user_creditCard];
		phoneNumber = data[0][user_phoneNumber];
		emailAddress = data[0][user_emailAddress];
		password = data[0][user_password];
	}

	public String[][] getFieldsAndDataForXML() {

		String[][] fieldsAndData;

		fieldsAndData = new String[][] { { "numberOfFields", "15" },
				{ "type", "user" }, { "id", String.valueOf(id) },
				{ "numberOfComplaints", String.valueOf(complaints) },
				{ "SA", String.valueOf(SA) }, { "status", status },
				{ "password", password }, { "username", userName },
				{ "firstName", firstName }, { "lastName", lastName },
				{ "address", address }, { "city", city }, { "state", state },
				{ "zipCode", zipCode }, { "creditCard", creditCard },
				{ "phoneNumber", phoneNumber },
				{ "emailAddress", emailAddress }

		};

		return fieldsAndData;
	}

	public boolean canLogin(){
		boolean canLogin = false;
		
		if(status.equals("Approved"))
			canLogin = true;
		
		return canLogin;
	}
	
	public String getInfo(String field) {
		/*
		 * Purpose: Getter for the arributes of the user class.
		 */

		String result = new String();

		if (field == "userName")
			result = userName;
		else if (field == "SA")
			result = String.valueOf(SA);
		else if (field == "id")
			result = String.valueOf(id);
		else if (field == "complaints")
			result = String.valueOf(complaints);
		else if (field == "status")
			result = status;
		else if (field == "firstName")
			result = firstName;
		else if (field == "lastName")
			result = lastName;
		else if (field == "address")
			result = address;
		else if (field == "city")
			result = city;
		else if (field == "state")
			result = state;
		else if (field == "zipCode")
			result = zipCode;
		else if (field == "creditCard")
			result = creditCard;
		else if (field == "phoneNumber")
			result = phoneNumber;
		else if (field == "emailAddress")
			result = emailAddress;
		else if (field == "password")
			result = password;

		return result;
	}

	public void setInfo(String field, String value) {
		/*
		 * Purpose: Setter for attributes of user class.
		 */
		if (field == "userName")
			userName = value;
		else if (field == "id")
			id = Integer.parseInt(value);
		else if (field == "status")
			status = value;
		else if (field == "firstName")
			firstName = value;
		else if (field == "lastName")
			lastName = value;
		else if (field == "address")
			address = value;
		else if (field == "city")
			city = value;
		else if (field == "state")
			state = value;
		else if (field == "zipCode")
			zipCode = value;
		else if (field == "phoneNumber")
			phoneNumber = value;
		else if (field == "creditCard")
			creditCard = value;
		else if (field == "emailAddress")
			emailAddress = value;
		else if (field == "numberOfComplaints")
			complaints = Integer.parseInt(value);
		else if (field == "password")
			password = value;
	}

	public void incComplaint() throws IOException, Exception {
		/*
		 * Purpose: Increment the complaint count.
		 */
		
		complaints++;

		//If the user recieves more than 2 complaints
		if (complaints > 2)
			
			//Block that user from accessing the system
			status = "Blocked";

		//Write this change to the database
		update();
	}

	public boolean authenticate(String username, String password) {

		String user_pwd = new String();
		String[][] userInfo = TheMain.global_db.select("users", "username", username, null);

		user_pwd = userInfo[0][user_password];

		if (password.equalsIgnoreCase(user_pwd))
			return true;
		else
			return false;
	}

	public void register() throws IOException, Exception {
		id = Database.getMaxId("user") + 1;
		TheMain.global_db.insert(this.getFieldsAndDataForXML());
	}

	public void update() throws IOException, Exception {
		TheMain.global_db.update(this.getFieldsAndDataForXML());
	}

	public void changePassword() throws IOException, Exception {
		TheMain.global_db.update(this.getFieldsAndDataForXML());
	}
}
