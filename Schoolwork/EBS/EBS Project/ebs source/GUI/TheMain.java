package GUI;

import java.io.IOException;

import system.*;

public class TheMain {

	public static systemInterface theSystemInterface = null;

	private static LoginInterface loginInterface = null;

	public static Database global_db = null;

	public static user global_user = null;

	private static ComplaintInterface complaintInt = null;

	public static void createAndShowGUI() throws IOException, Exception {

		global_db = new Database();
		
		theSystemInterface = new systemInterface();
//		loginInterface = new LoginInterface();
	}

	public static void main(String[] args) throws IOException, Exception {
		createAndShowGUI();
	}

	public static void showComplaintInterface(String user_id, String item_id) {
		complaintInt = new ComplaintInterface(user_id, item_id);
	}

}
