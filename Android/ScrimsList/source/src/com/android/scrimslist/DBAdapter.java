package com.android.scrimslist;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;
public class DBAdapter 
{

	private DatabaseHelper dbHelper;
    private SQLiteDatabase db;
    
	private static final String DATABASE_NAME = "scrimslist"; 
	private static final String DATABASE_TABLE = "scrims"; 
	private static final int DATABASE_VERSION = 1; 
	public static final String KEY_ROWID = "_id";
	public static final String KEY_TITLE = "title"; 
	public static final String KEY_BODY = "body";
	public static final String KEY_CREATED = "created";
	public static final String KEY_END = "end";
	public static final String KEY_DURATION = "duration";
	public static final String DATABASE_CREATE = "";
	
	public DBAdapter() 
	{
		// TODO Auto-generated constructor stub
	}

	
    /**
     * Return a Cursor over the list of all reminders in the database
     * 
     * @return Cursor over all reminders
     */
    public Cursor fetchAllScrims() {

        return db.query(DATABASE_TABLE, new String[] {KEY_ROWID, KEY_TITLE,
                KEY_BODY, KEY_CREATED}, null, null, null, null, null);
    }
    
	private static class DatabaseHelper extends SQLiteOpenHelper 
	{
        DatabaseHelper(Context context) {
            super(context, DATABASE_NAME, null, DATABASE_VERSION);
        }

        @Override
        public void onCreate(SQLiteDatabase db) {

            db.execSQL(DATABASE_CREATE);
        }

		@Override
		public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion)
		{
			// TODO Auto-generated method stub
			
		}

//        @Override
//        public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
//            Log.w(TAG, "Upgrading database from version " + oldVersion + " to "
//                    + newVersion + ", which will destroy all old data");
//            db.execSQL("DROP TABLE IF EXISTS " + DATABASE_TABLE);
//            onCreate(db);
//        }
    }
}
