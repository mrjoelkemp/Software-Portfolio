package system;

import java.io.IOException;
import java.util.Calendar;
import java.util.Timer;
import java.util.TimerTask;

import GUI.TheMain;

	
public class ItemWatcher {
	/* Purpose: Watches all currently approved items to see if their end time has passed
	 * 			and updates their status.
	 */
	
	private final int item_id = 0;

	private final int item_endTime = 4;

	Timer timer;

	/*
	 * Constructor: Sets up the timed event, sets the function called, initial
	 * delay, and time in ms between calls.
	 */
	public ItemWatcher() {
		// Setup timer
		timer = new Timer(true);

		// Schedule the task to run 2 seconds from now and every 5 seconds after
		timer.schedule(new ItemEndWatcher(), 2000, 5000);

	}

	public void cancel() {
		timer.cancel();
	}

	/*
	 * Function to query and update approved items if their time has come.
	 */
	class ItemEndWatcher extends TimerTask {
		public void run() {
			// Get the current time
			long currentTime = Calendar.getInstance().getTimeInMillis();

			// Set the fields and values to be updated for each item that
			// has ended
			String[] updateFields = { "status" };
			String[] updateValues = { "Finished" };

			// Get all the approved items
			String[][] results = TheMain.global_db.select("items", "status",
					"Approved", "");

			// Store the number of items for the loop
			int n = results.length;

			// Go through them and compare the end time to the current time
			for (int i = 0; i < n; i++) {
				// Extract and convert the end time of the item
				long itemEndTime = Long.parseLong(results[i][item_endTime]);

				// If the item is no longer available
				if (itemEndTime < currentTime) {

					try {
						// Update the status of the item
						TheMain.global_db
								.updateManyObjects("item", "id",
										results[i][item_id], updateFields,
										updateValues);

					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				} // END if
			} // END for
		}
	}//end ItemEndWatcher
}
