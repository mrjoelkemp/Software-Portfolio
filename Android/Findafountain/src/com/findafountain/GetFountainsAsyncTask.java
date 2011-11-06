package com.findafountain;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.os.AsyncTask;
import android.os.Handler;
import android.os.Message;
import android.util.Log;

import com.findafountain.RestClient.RequestMethod;

/**
 * Represents an async thread that polls a remote server for fountain information,
 * converts the server's JSON response into usable fountain objects, calls for the
 * local storage of the fountains, and notifies the caller about its task completion.
 * @author Joel
 */
public class GetFountainsAsyncTask extends AsyncTask<String, Integer, Integer>
{
	private static final String TAG = "GetFountainsAsyncTask";
	
	//Live server URL.
	private static final String SERVER_URL = "http://mrjoelkemp.com/findafountain/";
	//Development server URL at home
	//private static final String SERVER_URL = "http://74.73.72.2/findafountain/";
	//Development server at Hunter College
	//private static final String SERVER_URL = "http://146.95.37.88/findafountain/";
	
	//Pointer to the database adapter for db operations.
	private DBAdapter dbAdapter;
	//The handler that can receive this thread's messages
	private Handler messageHandler;
	
	public GetFountainsAsyncTask(DBAdapter db, Handler messageHandler) 
	{
		dbAdapter = db;
		this.messageHandler = messageHandler;
		Log.d(TAG, "Async Task Intialized.");
	}

	/**
	 * Purpose: Polls the restful server with a GET request and parses the JSON into fountain objects.
	 * On successful parsing, we store the fountains into the database.
	 */
	@Override
	protected Integer doInBackground(String... url)
	{		
		int numFountainsParsed = 0;
		try
		{		
			//Poll the server and grab the JSON response
			String response = GetFountainsJSON(SERVER_URL + url[0]);
			//The there was some response and the response doesn't have the word "Error" in any casing.
			if(response != null)
			{
				if(!response.contains("ERROR"))
				{
					//Convert the response to fountain objects and store in the database.
					numFountainsParsed = JSONtoFountain(response);
					Log.d(TAG, "onPostExecute: " + numFountainsParsed + " fountains sent to the DB.");
				}
				else
				{
					Log.e(TAG, "doInBackground: JSON Response is bad!");
					//Send a message to the UI indicating that the response was bad!
					//Create a new message to send to the observing thread
					Message msg = Message.obtain();
					//This message is coming from the refresh action (GetAsyncTask)
					msg.what = MyActionBar.Actions.REFRESH;
					//We'll use -1 to indicate an error
					msg.arg1 = -1;
					//Post the message to the observer
					messageHandler.sendMessage(msg);
				}
			}
		}
		catch (Exception e)
		{
			Log.e(TAG, "doInBackground: " + e);
		}
		//Return the number of processed fountains to onPostExecute
		return numFountainsParsed;
	}
	
	protected void onProgessUpdate(Integer... values)
	{}
	
	@Override
	protected void onPostExecute(Integer result)
	{
		try
		{
			//Create a new message to send to the observing thread
			Message msg = Message.obtain();
			msg.what = MyActionBar.Actions.REFRESH;
			//Pack the number of fountains processed from the server
			msg.arg1 = result;
			//Post the message to the observer
			messageHandler.sendMessage(msg);
			
			Log.d(TAG, "onPostExecute: Async returning to caller.");
		}
		catch(Exception e)
		{
			Log.e(TAG, "onPostExecute: " + e);
		}
	}

	/**
	 * Queries the REST server identified by the passed URL and returns
	 * @param absoluteURL The URL for the server/controller/action to poll.
	 * @return The server's JSON response.
	 */
	private String GetFountainsJSON(String absoluteURL)
	{
		String result = null;
		Log.d(TAG, "URL Created: " + absoluteURL);
		
		//Create the Rest client
		//Note: We should keep a static copy of this instead of recreating it. 
		//	However, the user doesn't actually refresh often.
		RestClient client = new RestClient(absoluteURL);
		if(client != null)
		{
			//Add apikey to the message
			client.AddParam("apikey", "mrjoeledwardkempfindafountainapikey");
			try
			{
				Log.d(TAG, "GetFountainsJSON: GetTaskSync Running...");
				client.Execute(RequestMethod.GET);
			}
			catch (Exception e)
			{
				Log.e(TAG, "doInBackground: " + e);
			}
			
			//serverResponse = client.getResponse();
			result = client.getResponse();
			Log.d(TAG, "GetFountainsJSON: Server response retrieved: " + result);
		}
		
		return result;
	}
	
	/**
	 * Purpose: Converts the passed JSON string into fountain objects and pushes a set
	 * 	of converted fountain objects to the database at a time.
	 * @param json: The JSON response from the RESTful server.
	 * @return The number of fountains parsed from the JSON response.
	 */
	private int JSONtoFountain(String json)
	{
		//A list of fountains to hold the JSON to Fountain converted objects
		ArrayList<Fountain> readFountains = new ArrayList<Fountain>();
		//The number of entries/fountains in the JSON response
		int numEntries = 0;
		
		//Convert the returned result into a JSON array
		try
		{
			JSONArray entries = new JSONArray(json);
			//Cache the length to avoid the lookup
			numEntries = entries.length();
			//If we have no entries, then something went wrong
			if(numEntries == 0) return 0;
			
			Log.d(TAG, "onPostExecute: JSON Parsed! There are " + entries.length() + " fountain elements.");
									
			//Convert the JSON into Fountain Objects
			for(int i = 0; i < numEntries; i++)
			{
				//Convert the current element to a string so we can extract its array contents
				JSONObject fobj = new JSONObject(entries.getString(i));
				//Get the values associated with the "Fountain" element
				String fstring = fobj.getString("Fountain");
				//Get the associated fountain status from the status element of the current array entry
				String statusString = fobj.getString("Status");
				//Create a usable object from the attribute data
				JSONObject obj = new JSONObject(fstring);
				JSONObject statusObj = new JSONObject(statusString);
				
				//Cache the longitude and latitude fields since we'll use them a lot.
				double longitude = obj.getDouble(DBHelper.FountainTable.COL_LONGITUDE);
				double latitude = obj.getDouble(DBHelper.FountainTable.COL_LATITUDE);
				
				//Get a fountain object from the pool to populate
				Fountain f = dbAdapter.pool.borrow();
				if(f == null) 
				{
					Log.e(TAG, "JSONtoFountain: Fountain object not borrowed. Pool is possibly full!");
					return 0;
				}
				
				//Set the properties of the reusable fountain
				f.setId(obj.getInt(DBHelper.FountainTable.COL_ID));
				f.setLatitude(latitude);
				f.setLongitude(longitude);
				//Store the fountain status as the description text in the status object
				f.setStatus(statusObj.getString(DBHelper.StatusTable.COL_DESCRIPTION));

				readFountains.add(f);
				
				//Store the fountains in groups of 50
				//50 was chosen because it still leaves room in the object pool of fountains.
				//We do i+1 since we start the loop at 0. Changing the counter to start at 1
				//	would break the container access.
				if(((i+1) % 50) == 0)
					pushAndRelease(readFountains);
				
			}//end for
			
			//Push the leftover data to the db
			//We store in groups of 50, but if we had 51 fountains,
			//	the last fountain would still need to be stored.
			if(readFountains.size() > 0)
				pushAndRelease(readFountains);
			
		}
		catch (JSONException e)
		{
			Log.e(TAG, "JSONtoFountain: " + e);
		}
		catch (Exception e)
		{
			Log.e(TAG, "JSONtoFountain: " + e);
		}
		
		return numEntries;
	}//end JSONtoFountain
	
	/**
	 * Pushes the fountain objects in the list to the DB
	 * and releases them from the DBAdapter's object pool. The 
	 * passed list is then cleared of its contents upon flushing
	 * to the database.
	 * @param fountains The list of fountains to be stored, released, then cleared.
	 */
	private void pushAndRelease(ArrayList<Fountain> fountains)
	{
		int num = fountains.size();
		//Push the fountains to the database
		dbAdapter.AddOrUpdateFountains(fountains);
		//Release the fountain objects back to the pool
		for (int j = 0; j < num; j++)
			dbAdapter.pool.release(fountains.get(j));
		//Clear the array list
		fountains.clear();
	}
}
