package com.findafountain;

import java.util.ArrayList;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.util.Log;

//Purpose:
//	Represents a class that uses the DBHelper for initial database management, but implements
// 	the logic for Read, Update, and Delete operations on the database. 
public class DBAdapter
{
	private static String TAG = "DBAdapter";
	//Controls the 
	private DBHelper dbHelper;
	//Local instance of SQLite database used by all CRUD operations
	//private SQLiteDatabase db;
	private Context context;
	
	public DBAdapter(Context c) 
	{
		context = c;
		dbHelper = new DBHelper(c);
	}
	
	//Purpose: Queries the database for the fountain with the passed id.
	//Returns: A fountain object with the row data for the queried fountain.
	public Fountain SelectFountain(int id)
	{
		Fountain f = null;
		SQLiteDatabase db = dbHelper.getReadableDatabase();
		try
		{
			Cursor c = db.rawQuery("select * from " + DBHelper.FountainTable.NAME + " where " +
					DBHelper.FountainTable.COL_ID + " ='" + id + "';", null);
			
			//If a row was found
	        if (c.getCount() > 0) 
	        {
	        	//Go to the front of the list
	            c.moveToFirst();
	            //Create a dummy fountain to fill
                f = new Fountain();
                //Populate the dummy's attributes
                f.setId(c.getInt(c.getColumnIndex(DBHelper.FountainTable.COL_ID)));
                f.setLongitude(c.getDouble(c.getColumnIndex(DBHelper.FountainTable.COL_LONGITUDE)));
                f.setLatitude(c.getDouble(c.getColumnIndex(DBHelper.FountainTable.COL_LATITUDE)));
                f.setStatus(c.getInt(c.getColumnIndex(DBHelper.FountainTable.COL_STATUS)));
                f.setCity_id(c.getInt(c.getColumnIndex(DBHelper.FountainTable.COL_CITY_ID)));
	        }
			//Close the cursor
			c.close();
		}
		catch (Exception e)
		{
			Log.e(TAG, "SelectFountain: " + e);
		}
		finally
		{
			if(db != null)
				db.close();
		}
		return f;
	}
	
	//Purpose: Grabs all of the fountains from the database.
	//Returns: A list of populated Fountain objects
	public ArrayList<Fountain> SelectFountains() 
	{
		ArrayList<Fountain> results = new ArrayList<Fountain>();
		SQLiteDatabase db = dbHelper.getReadableDatabase();
	    try 
	    {
	    	//TODO: Maybe select * from fountains where city_id = CURRENT CITY.
	        //	This way, we only pull up the fountains in the user's city, avoiding
	        //	pulling more fountains than needed!
	        Cursor c = db.rawQuery("select * from " + DBHelper.FountainTable.NAME, null);
	        
	        //If results were found
	        if (c.getCount() > 0) 
	        {
	        	//Go to the front of the list
	            c.moveToFirst();
	            do 
	            {	                
	            	//Create a dummy fountain to fill
	                Fountain f = new Fountain();
	                //Populate the dummy's attributes
	                f.setId(c.getInt(c.getColumnIndex(DBHelper.FountainTable.COL_ID)));
	                f.setLongitude(c.getDouble(c.getColumnIndex(DBHelper.FountainTable.COL_LONGITUDE)));
	                f.setLatitude(c.getDouble(c.getColumnIndex(DBHelper.FountainTable.COL_LATITUDE)));
	                f.setStatus(c.getInt(c.getColumnIndex(DBHelper.FountainTable.COL_STATUS)));
	                f.setCity_id(c.getInt(c.getColumnIndex(DBHelper.FountainTable.COL_CITY_ID)));
	                
	                //Add the dummy object to the list of fountains
	                results.add(f);
	            } 
	            while (c.moveToNext());
	        }
	        
	        //Close the cursor for cleanup
	        c.close();
	    } 
	    catch (Exception e)
	    {
	    	Log.e(TAG, "SelectFountains: " + e);
	    }
	    finally 
	    {
	        if (db != null)
	            db.close();
	    }

        return results;
	}
	
	//Purpose: Adds the elements of the passed list in a transactional database write.
	//Notes: Using database transactions allow us to group writes together for better performance.
	public void AddFountains(ArrayList<Fountain> fountains)
	{
		SQLiteDatabase db = dbHelper.getWritableDatabase();
		
		//Start a transaction to make writes much faster
		db.beginTransaction();
		try 
	    {
			for (int i = 0; i < fountains.size(); i++)
			{
				Fountain f = fountains.get(i);
				//Populate the data to be stored from the attributes
				//	of the passed fountain object.
	    		ContentValues values = new ContentValues();
	    		values.put(DBHelper.FountainTable.COL_ID, f.getId());
	            values.put(DBHelper.FountainTable.COL_LONGITUDE, f.getLongitude());
	            values.put(DBHelper.FountainTable.COL_LATITUDE, f.getLatitude());
	            values.put(DBHelper.FountainTable.COL_STATUS, f.getStatus());
	            values.put(DBHelper.FountainTable.COL_CITY_ID, f.getCity_id());
		 
	            //Insert the data into the fountains table
		        db.insert(DBHelper.FountainTable.NAME, "", values);
			}
			db.setTransactionSuccessful();
	    } 
		catch(Exception e)
		{
			//End the transaction on error
	    	db.endTransaction(); 
	    	Log.e(TAG, "AddFountain: " + e);
		}
	    finally 
	    {
	    	//End the transaction
	    	db.endTransaction();
	    	
	        if (db != null)
	            db.close();
	        
	        Log.d(TAG, "AddFountains: Database transaction complete!");
	    }
		
	}
	
	//Purpose: Handles the adding of fountain objects to the fountains table
	public void AddFountain(Fountain f)
	{
		SQLiteDatabase db = dbHelper.getWritableDatabase();
		
		//Start a transaction to make writes much faster
		db.beginTransaction();
		try 
	    {
			//Populate the data to be stored from the attributes
			//	of the passed fountain object.
    		ContentValues values = new ContentValues();
    		values.put(DBHelper.FountainTable.COL_ID, f.getId());
            values.put(DBHelper.FountainTable.COL_LONGITUDE, f.getLongitude());
            values.put(DBHelper.FountainTable.COL_LATITUDE, f.getLatitude());
            values.put(DBHelper.FountainTable.COL_STATUS, f.getStatus());
            values.put(DBHelper.FountainTable.COL_CITY_ID, f.getCity_id());
	 
            //Insert the data into the fountains table
	        db.insert("fountains", "", values);
	    } 
		catch(Exception e)
		{
			//End the transaction on error
	    	db.endTransaction(); 
	    	Log.d(TAG, "AddFountain: " + e);
		}
	    finally 
	    {
	    	//End the transaction
	    	db.endTransaction();
	    	
	        if (db != null)
	            db.close();
	    }
	}
	        
	//Purpose: Updates the row in the fountains table for the passed object.
	// The row is identified by the id field of the fountain object.
	public void UpdateFountain(Fountain f)
	{
//		SQLiteDatabase db = _dbHelper.getWritableDatabase();
//	    try {
//	        Random r = new Random();
//	        ContentValues values = new ContentValues();
//	        values.put("PlayTime", r.nextInt());
//	 
//	        int affected = db.update("Games", values, null, null);
//	 
//	        return affected;
//	    } finally {
//	        if (db != null)
//	            db.close();
	    
	}
	
	//Purpose: Removes the row (identified by the passed fountain's id) from
	//	the database.
	public void DeleteFountain(Fountain f)
	{
		//TODO: Implement this. 
		//We want delete in case we ever need to delete local data.
	}
	 
	//Purpose: Allows us to clear all fountains from the DB.
	//Notes: This is only for testing purposes.
	public void DeleteAll()
	{
		SQLiteDatabase db = dbHelper.getWritableDatabase();
		try
		{
			db.delete(DBHelper.FountainTable.NAME, null, null);
		}
		finally 
	    {
	        if (db != null)
	            db.close();
	    }
	}

	//Purpose: Inserts or Updates fountain rows based on the existence of the fountains passed in the list.
	//Note: We use the SQL Replace method to automatically handle inserting or updating. This is FAST!
	public void AddOrUpdateFountains(ArrayList<Fountain> fountains)
	{
		SQLiteDatabase db = dbHelper.getWritableDatabase();
		
		//Start a transaction to make writes much faster
		db.beginTransaction();
		try 
	    {
			for (int i = 0; i < fountains.size(); i++)
			{
				Fountain f = fountains.get(i);
							
				//Populate the data to be stored from the attributes
				//	of the passed fountain object.
	    		ContentValues values = new ContentValues();
	    		values.put(DBHelper.FountainTable.COL_ID, f.getId());
	            values.put(DBHelper.FountainTable.COL_LONGITUDE, f.getLongitude());
	            values.put(DBHelper.FountainTable.COL_LATITUDE, f.getLatitude());
	            values.put(DBHelper.FountainTable.COL_STATUS, f.getStatus());
	            values.put(DBHelper.FountainTable.COL_CITY_ID, f.getCity_id());
	           
	            //Insert or update the row automatically using SQL Replace
	            db.replace(DBHelper.FountainTable.NAME, "", values);
			}
			db.setTransactionSuccessful();
	    } 
		catch(Exception e)
		{
			//End the transaction on error
	    	db.endTransaction(); 
	    	Log.e(TAG, "AddOrUpdateFountains: " + e);
		}
	    finally 
	    {
	    	//End the transaction
	    	db.endTransaction();
	    	
	        if (db != null)
	            db.close();
	        
	        Log.d(TAG, "AddOrUpdateFountains: " + fountains.size() + " replacements performed!");
	    }
	}
}
