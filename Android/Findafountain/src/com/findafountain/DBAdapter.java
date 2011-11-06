package com.findafountain;

import java.util.ArrayList;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.util.Log;

/**
 * Represents a class that uses the DBHelper for initial database management, but implements
 * the logic for Read, Update, and Delete operations on the database. 
 * @author Joel
 */
public class DBAdapter
{
	private static String TAG = "DBAdapter";
	private DBHelper dbHelper;
	/**
	 * Accessible Object pool to maintain the instantiations and reusing of fountain objects.
	 * It's a design choice to make the dbAdapter manage the fountain pool.
	 */
	public ObjectPool<Fountain> pool;
	
	/**
	 * The total number of possible fountain objects in the object pool.
	 */
	private final static int POOL_SIZE = 100;
	public DBAdapter(Context c) 
	{
		dbHelper = new DBHelper(c);
		pool = new ObjectPool<Fountain>(new FountainFactory(), POOL_SIZE);
	}
	
	/**
	 * Grabs fountains within the four passed geolocations and returns them in a list.
	 * Select * from fountains where longitude >= topLeft.longitude and
	 * 								 longitude <= topRight.longitude and
	 * 								 latitude <= topLeft.latitude and
	 * 								 latitude >= bottomLeft.latitude; 
	 * @return List of fountains within the range.
	 */
	public ArrayList<Fountain> SelectFountainsInRange(LongLat topLeft, LongLat topRight, LongLat bottomRight, LongLat bottomLeft)
	{
		//List to hold the fountains in range
		ArrayList<Fountain> fountains = new ArrayList<Fountain>();
		SQLiteDatabase db = dbHelper.getReadableDatabase();
		try
		{
			String q = "select * from " + DBHelper.FountainTable.NAME + " where " +
			DBHelper.FountainTable.COL_LONGITUDE + " >= '" + topLeft.longitude + "' and " + 
			DBHelper.FountainTable.COL_LONGITUDE + " <= '" + topRight.longitude + "' and " + 
			DBHelper.FountainTable.COL_LATITUDE + " <= '" + topLeft.latitude + "' and " + 
			DBHelper.FountainTable.COL_LATITUDE + " >= '" + bottomLeft.latitude + "'";
			
			Log.d(TAG, "topLeft: " + topLeft.longitude + ", " + topLeft.latitude + 
						" topRight: " + topRight.longitude + ", " + topRight.latitude);
			Log.d(TAG, "botLeft: " + bottomLeft.longitude + ", " + bottomLeft.latitude + 
						" botRight: " + bottomRight.longitude + ", " + bottomRight.latitude);
			
			Cursor c = db.rawQuery(q, null);
			
			//If a row was found
	        if (c.getCount() > 0) 
	        {
	        	//Go to the front of the list
	            c.moveToFirst();
	            do 
	            {	                	            	
	            	//Grab an available fountain from the pool.
	                Fountain f = pool.borrow();
	                //Fountain f = new Fountain();
	            	//Populate the dummy's attributes
	                f.setId(c.getInt(c.getColumnIndex(DBHelper.FountainTable.COL_ID)));
	                f.setLongitude(c.getDouble(c.getColumnIndex(DBHelper.FountainTable.COL_LONGITUDE)));
	                f.setLatitude(c.getDouble(c.getColumnIndex(DBHelper.FountainTable.COL_LATITUDE)));
	                f.setStatus(c.getString(c.getColumnIndex(DBHelper.FountainTable.COL_STATUS)));
	                
	                //Add the dummy object to the list of fountains
	                fountains.add(f);
	               
	                Log.d(TAG, "Within Range: " + f.getLongitude() + ", " + f.getLatitude());
	            } 
	            while (c.moveToNext());
	        }
	        
	        //Close the cursor for memory cleanup
	        c.close();
	    } 
	    catch (Exception e)
	    {
	    	Log.e(TAG, "SelectFountainsWithinRange: " + e);
	    }
	    finally 
	    {
	        if (db != null)
	            db.close();
	        Log.d(TAG, "SelectFountainsWithinRange: " + fountains.size() + " fountains fetched.");
	    }

		return fountains;	
	}
	
	/**
	 * Queries the database for the fountain with the passed id.
	 * @return A fountain object with the row data for the queried fountain.
	 */
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
                f.setStatus(c.getString(c.getColumnIndex(DBHelper.FountainTable.COL_STATUS)));
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
	
	/**
	 * Purpose: Grabs all of the fountains from the database.
	 * @return A list of populated Fountain objects.
	 */
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
	                f.setStatus(c.getString(c.getColumnIndex(DBHelper.FountainTable.COL_STATUS)));
	                
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
	
	/**
	 * Handles the adding of fountain objects to the fountains table
	 * @param f The fountain object whose data should be added to the db.
	 */
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
	        
	/**
	 * Updates the row in the fountains table for the passed object.
	 * The row is identified by the id field of the fountain object.
	 * @param f
	 */
	
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
	
	/**
	 * Purpose: Removes the row (identified by the passed fountain's id) from the database
	 * @param f The fountain whose data should be deleted from the db.
	 */
	
	public void DeleteFountain(Fountain f)
	{
		//TODO: Implement this. 
		//We want delete in case we ever need to delete local data.
	}
	 
	/**
	 * Allows us to clear all fountains from the DB.
	 * This is only for testing purposes.
	 */
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

	/**
	 * Purpose: Inserts or Updates fountain rows based on the existence of the 
	 * fountains passed in the list. 
	 * 
	 * We use the SQL Replace method 
	 * to automatically handle inserting or updating and Sqlite transactions
	 * for very fast writing operations.
	 * @param fountains The fountain objects whose data should be stored in the database.
	 */
	public void AddOrUpdateFountains(ArrayList<Fountain> fountains)
	{
		SQLiteDatabase db = dbHelper.getWritableDatabase();
		
		//Start a transaction to make writes much faster
		db.beginTransaction();
		try 
	    {
			//Cache the number of fountains to avoid the lookup overhead
			int numFountains = fountains.size();
			//Cache the fountain object to avoid useless stack objects
			Fountain f;
			//Cache a content values object to avoid creating unnecessary objects
			ContentValues values = new ContentValues();
			//For every fountain in the list.
			for (int i = 0; i < numFountains; i++)
			{
				//Cache the fountain
				f = fountains.get(i);
							
				//Populate the data to be stored from the attributes of the cached object   		
	    		values.put(DBHelper.FountainTable.COL_ID, f.getId());
	            values.put(DBHelper.FountainTable.COL_LONGITUDE, f.getLongitude());
	            values.put(DBHelper.FountainTable.COL_LATITUDE, f.getLatitude());
	            values.put(DBHelper.FountainTable.COL_STATUS, f.getStatus());
	           
	            //Insert or update the row automatically using SQL Replace
	            db.replace(DBHelper.FountainTable.NAME, "", values);
	            
	            //Prepare the contentvalues object for reuse
	            values.clear();
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
	}//end AddOrUpdateFountains
}
