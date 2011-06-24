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
        //TODO: Mirror the server's database schema
        
        public static final String COL_CITY_ID = "city_id";
    } 
	
	//TODO: Create structures (similar to FountainTable) for the other tables. 
	//TODO: Figure out a better way to handle the database creation
	
	public DBHelper(Context context) 
    {
        super(context, DB_NAME, null, DB_VERSION);
    }
	
    @Override
    public void onCreate(SQLiteDatabase db) 
    {
    	//Create Fountains Table
    	//Note: city_id references cities.id
    	//TODO: Implement the reference to cities table

    	//Construct the CREATE table string
    	String sql = String.format(    
			"create table %s " +
	        "(%s integer primary key, " +
	        "%s double, " +
	        "%s double, " +
	        "%s integer, " +
	        "%s integer); ", 
	        FountainTable.NAME,
	        FountainTable.COL_ID, 
	        FountainTable.COL_LONGITUDE, 
	        FountainTable.COL_LATITUDE,
	        FountainTable.COL_STATUS,
	        FountainTable.COL_CITY_ID);
    	
    	db.execSQL(sql);
    	
    	//Create fountain_status table
    	
    	//Create cities table
    	
    	//Create ratings table
    	
    	//Create status table
    	Log.d(TAG, "onCreate: Database Created!");
    }
 
    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) 
    {
        // TODO Auto-generated method stub
 
    	Log.d(TAG, "onCreate: Database Upgraded!");
    }
 
}//end DBHelper