package com.findafountain;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

//Purpose: 
//	Represents an object that creates the database and its tables if they doesn't exist, in 
//	addition to handling the upgrading of database schemas and exposing database table constants.
public class DBHelper extends SQLiteOpenHelper 
{ 
	private static String TAG = "DBHelper";
	private static final String DB_NAME = "findafountain.db";
	private static final int DB_VERSION = 1;
	
	//Exposes the static column data for the table
	public final class FountainTable 
	{  
        public static final String NAME = "fountains";  
        public static final String COL_ID = "id";  
        public static final String COL_LONGITUDE = "longitude";  
        public static final String COL_LATITUDE = "latitude"; 
        public static final String COL_STATUS = "status";
    } 
	
	//Exposes the table columns
	//We don't create a specific statuses table on the client to avoid the 
	//	maintenance of a non-changing lookup table, but we'll expose the columns 
	//	to facilitate the combining of the status description as the fountain's status
	public final class StatusTable 
	{  
        public static final String NAME = "statuses";  
        public static final String COL_ID = "id";  
        public static final String COL_DESCRIPTION = "description";
    }
	
	public DBHelper(Context context) 
    {
        super(context, DB_NAME, null, DB_VERSION);
    }
	
    @Override
    public void onCreate(SQLiteDatabase db) 
    {
    	//Create Fountains Table
    	//Construct the CREATE table string
    	String sql = String.format(    
			"create table %s " +			//Table Name
	        "(%s integer primary key, " +	//Fountain ID
	        "%s double, " +					//Longitude
	        "%s double, " +					//Latitude
	        "%s varchar(256)); ", 				//Status
	        FountainTable.NAME,
	        FountainTable.COL_ID, 
	        FountainTable.COL_LONGITUDE, 
	        FountainTable.COL_LATITUDE,
	        FountainTable.COL_STATUS);
    	
    	try
    	{
    		db.execSQL(sql);
    		Log.d(TAG, "onCreate: Database Created!");
    	}
    	catch(Exception e)
    	{
    		Log.e(TAG,"onCreate: " + e);
    	}
    	
    	
    }
 
    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) 
    {
        // TODO Auto-generated method stub
 
    	Log.d(TAG, "onCreate: Database Upgraded!");
    }
 
}//end DBHelper