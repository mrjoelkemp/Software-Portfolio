package com.findafountain;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

/**
 * Represents an object that creates the database and its tables if they doesn't exist, in 
 *	addition to handling the upgrading of database schemas and exposing database table constants.
 * @author Joel
 */
public class DBHelper extends SQLiteOpenHelper 
{ 
	private static String TAG = "DBHelper";
	private static final String DB_NAME = "findafountain.db";
	private static final int DB_VERSION = 3;	//DB Update: Removing Status
	
	//Exposes the static column data for the table
	public final class FountainTable 
	{  
        public static final String NAME = "fountains";  
        public static final String COL_ID = "id";  
        public static final String COL_LONGITUDE = "longitude";  
        public static final String COL_LATITUDE = "latitude"; 
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
	        "%s double)",					//Latitude
	        FountainTable.NAME,
	        FountainTable.COL_ID, 
	        FountainTable.COL_LONGITUDE, 
	        FountainTable.COL_LATITUDE);
    	
    	try {
    		db.execSQL(sql);
    		Log.d(TAG, "onCreate: Database Created!");
    	} catch(Exception e){
    		Log.e(TAG,"onCreate: " + e);
    	}   	
    }
 
    /**
     * Upgrade notes:
     * 	Since the client doesn't contain user-created data, we can simply drop the table and create
     * 		The schema for the new table. 
     */
    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) 
    {
    	String sql = String.format(
	    	"drop table if exists %s",
	    	FountainTable.NAME);
    	
    	try{
    		db.execSQL(sql);
        	Log.d(TAG, "onUpgrade: Database Upgraded!");
        	onCreate(db);
    	} catch(Exception e){
    		Log.e(TAG, "onUpgrade: " + e.toString());
    	}
    } 
}//end DBHelper