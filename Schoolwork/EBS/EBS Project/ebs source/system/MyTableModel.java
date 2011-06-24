package system;

import java.text.SimpleDateFormat;

import javax.swing.table.AbstractTableModel;

import GUI.TheMain;

public class MyTableModel extends AbstractTableModel {

	private static final long serialVersionUID = 1L;

	private String[][] data = null;

	private final int user_userName = 4;

	private String[] colNames = null;

	private String[] colNamesNotPretty = null;

	private int colCount;

	private int rowCount;

	public MyTableModel(String tableName_in, String whereField_in,
			String lookingFor_in) {

		data = TheMain.global_db.select(tableName_in, whereField_in,
				lookingFor_in, "");
		colNames = TheMain.global_db.getPrettyArrayOfFieldsFor(tableName_in);
		colNamesNotPretty = TheMain.global_db.getArrayOfFieldsFor(tableName_in);

		convertIdToUser("user_id");
		
		convertIdToUser("complainer_id");

		if (tableName_in.equalsIgnoreCase("items")) {

			// Call to convert startTime timestamp (item)
			convertTimestamp("startTime");

			// Call to convert endTime timestamp (item)
			convertTimestamp("endTime");

			convertMoneyValue("currentPrice");
			convertMoneyValue("startPrice");

		}

		if (tableName_in.equalsIgnoreCase("transactions")) {
			// Call to convert timestamp (transaction)
			convertTimestamp("timestamp");
			convertMoneyValue("amount");
		}

		colCount = colNames.length;
		rowCount = data.length;
	}

	private void convertTimestamp(String fieldName) {
		/*
		 * Purpose: Change the millisecond timestamp from the database into a readable date format.
		 */

		SimpleDateFormat date = new SimpleDateFormat("MM/dd/yyyy");
		int fieldToChange = -1;

		for (int i = 0; i < colNamesNotPretty.length; i++)
			// If we find the field we are looking for
			if (colNamesNotPretty[i] == fieldName)
				fieldToChange = i;

		if (fieldToChange != -1) {
			for (int i = 0; i < data.length; i++)
				// Change the millisecond timestamp to MM/dd/yyyy format.
				data[i][fieldToChange] = String.valueOf(date.format(Long
						.parseLong(data[i][fieldToChange])));
		}
	}//end convertTimestamp

	private void convertMoneyValue(String fieldName) {
		/*
		 * Purpose: Change the millisecond timestamp from the database into a
		 * readable date format.
		 */

		int fieldToChange = -1;

		for (int i = 0; i < colNamesNotPretty.length; i++)
			// If we find the field we are looking for
			if (colNamesNotPretty[i] == fieldName)
				fieldToChange = i;

		if (fieldToChange != -1) {
			for (int i = 0; i < data.length; i++)
				// Add a dollar sign and a space
				data[i][fieldToChange] = "$ " + data[i][fieldToChange];
		}
	}// end convertMoneyValue

	private void convertIdToUser(String fieldName) {
		/*
		 * Purpose: Change the millisecond timestamp from the database into a
		 * readable date format.
		 */

		int fieldToChange = -1;

		for (int i = 0; i < colNamesNotPretty.length; i++)
			// If we find the field we are looking for
			if (colNamesNotPretty[i] == fieldName)
				fieldToChange = i;

		if (fieldToChange != -1) {
			for (int i = 0; i < data.length; i++)
				// Add a dollar sign and a space
				data[i][fieldToChange] = getUsernameForID(data[i][fieldToChange]);
		}
	}// end convertMoneyValue

	private String getUsernameForID(String user_id) {
		String[][] results = TheMain.global_db.select("users", "id", user_id,
				"");
		return results[0][user_userName];
	}

	public boolean isCellEditable(int row, int col) {
		return false;
	}

	public String getColumnName(int col) {
		return colNames[col];
	}

	public int getRowCount() {
		return rowCount;
	}

	public int getColumnCount() {
		return colCount;
	}

	public Object getValueAt(int arg0, int arg1) {
		return data[arg0][arg1];
	}
}
