package com.findafountain;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.findafountain.RestClient.RequestMethod;

import android.content.Context;
import android.location.Address;
import android.location.Geocoder;
import android.os.AsyncTask;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.widget.Toast;

public class GetFountainsAsyncTask extends AsyncTask<String, Integer, Integer>
{
	private static final String TAG = "GetFountainsAsyncTask";
	//Live server URL
	private static final String SERVER_URL = "http://mrjoelkemp.com/findafountain/";
	//Development server URL at home
	//private static final String SERVER_URL = "http://192.168.1.101/findafountain/";
	//Development server at Hunter College
	//private static final String SERVER_URL = "http://146.95.37.87/findafountain/";
	
	//Whether or not the async task has finished its rest functions
	//We use this to prevent multiple tasks from being started
	private boolean asyncTaskFinished = true;
	//Pointer to the database adapter for db operations.
	private DBAdapter dbAdapter;
	//Pointer to the calling activity
	private Context context;
	//The handler that can receive this thread's messages
	private Handler messageHandler;
	
	//Used to reverse geocode the addresses based on Longitude and Latitude coords.
	private Geocoder geocoder;
	
	public GetFountainsAsyncTask(Context context, DBAdapter db, Handler messageHandler) 
	{
		dbAdapter = db;
		this.context = context;
		this.messageHandler = messageHandler;
		
		geocoder = new Geocoder(context, Locale.getDefault());
		
		Log.d(TAG, "Async Task Intialized.");
	}

	//Purpose: The tasks performed in the background thread.
	@Override
	protected Integer doInBackground(String... url)
	{
		ArrayList<Fountain> readFountains;
		int numFountains = 0;
		try
		{		
			//We are not done with our task.
			setAsyncTaskFinished(false);
			
			//Set up the server url
			String absoluteURL = SERVER_URL + url[0];
			//Poll the server and grab the JSON response
			String response = GetFountainsJSON(absoluteURL);
			//The the response is valid
			if(response != null)
			{
				//Convert the returned result into a JSON array
				readFountains = JSONtoFountain(response);
					
				//Store the Fountain Objects into the Database
				dbAdapter.AddOrUpdateFountains(readFountains);
					
				Log.d(TAG, "onPostExecute: " + readFountains.size() + " fountains sent to the DB.");
				//Set the number of read fountains
				numFountains = readFountains.size();
			}
		}
		catch (Exception e)
		{
			Log.e(TAG, "doInBackground: " + e);
		}
		
		return numFountains;
	}
	
	protected void onProgessUpdate(Integer... values)
	{
		//super.onProgressUpdate(values);
		//Log.d(TAG, values[0] + "% Processed");
		//Toast.makeText(getBaseContext(), values[0] + "% Processed", Toast.LENGTH_SHORT).show();
	}
	
	@Override
	protected void onPostExecute(Integer result)
	{
		try
		{
			//Set the flag to indicate that we've finished our task
			setAsyncTaskFinished(true);
			//Create a new message to send to the observing thread
			Message msg = Message.obtain();
			//1 will represent completion
			msg.what = MyActionBar.Actions.REFRESH;
			//Post the message to the observer
			messageHandler.sendMessage(msg);
			
			//Display the result in a toast
			String resultString = result + " fountains processed!";
			Toast.makeText(context, resultString, Toast.LENGTH_SHORT).show();
			Log.d(TAG, "onPostExecute: Async returning to caller.");
		}
		catch(Exception e)
		{
			Log.e(TAG, "onPostExecute: " + e);
		}
	}

	//Purpose: Queries the REST server identified by the passed URL and returns
	//	the server's JSON response.
	private String GetFountainsJSON(String absoluteURL)
	{
		String result = null;
		Log.d(TAG, "URL Created: " + absoluteURL);
		
		//Create the Rest client
		RestClient client = new RestClient(absoluteURL);
		if(client != null)
		{
			//Add apikey to the message
			client.AddParam("apikey", "mrjoeledwardkempfindafountainapikey");
			Log.d(TAG, "Client: " + client.toString());
			try
			{
				Log.d(TAG, "GetTaskSync Running...");
				client.Execute(RequestMethod.GET);
			}
			catch (Exception e)
			{
				e.printStackTrace();
				Log.e(TAG, "doInBackground: " + e);
			}
			
			//serverResponse = client.getResponse();
			Log.d(TAG, "GetFountainsJSON: REST GET Complete!");
			result = client.getResponse();
		}
		
		return result;
	}
	
	//Purpose: Converts the passed JSON string into fountain objects and returns the list of objects.
	//Returns: A list of fountain objects.
	private ArrayList<Fountain> JSONtoFountain(String json)
	{
		//A list of fountains to hold the JSON to Fountain converted objects
		ArrayList<Fountain> readFountains = new ArrayList<Fountain>();
		
		//Convert the returned result into a JSON array
		try
		{
			JSONArray entries = new JSONArray(json);
			if(entries.length() != 0)
			{
				Log.d(TAG, "onPostExecute: JSON Parsed! There are " + entries.length() + " fountain elements.");
								
				//Convert the JSON into Fountain Objects
				for(int i = 0; i < entries.length(); i++)
				{
					//Convert the current element to a string so we can extract its array contents
					JSONObject fobj = new JSONObject(entries.getString(i));
					//Get the values associated with the "Fountain" element
					String fstring = fobj.getString("Fountain");
					//Create a usable object from the attribute data
					JSONObject obj = new JSONObject(fstring);
					
					//Create a dummy fountain object to populate
					Fountain f = new Fountain();
					//Set the properties of the fountain
					f.setId(obj.getInt(DBHelper.FountainTable.COL_ID));
					f.setLatitude(obj.getDouble(DBHelper.FountainTable.COL_LATITUDE));
					f.setLongitude(obj.getDouble(DBHelper.FountainTable.COL_LONGITUDE));
					f.setStatus(obj.getInt(DBHelper.FountainTable.COL_STATUS));
					f.setCity_id(obj.getInt(DBHelper.FountainTable.COL_CITY_ID));
						
					//TODO: Implement address information	
					
					//Store the JSON converted fountain object in the list
					readFountains.add(f);
					//Publish the fountain number just processed
					//publishProgress(i+1);
				}
			}//end if
		}
		catch (JSONException e)
		{
			e.printStackTrace();
			Log.e(TAG, "doInBackground: " + e);
		}
			
		Log.d(TAG, "onPostExecute: Fountain Objects Created! There are " + readFountains.size() + " fountains.");
			
		return readFountains;
	}
	

	public void setAsyncTaskFinished(boolean asyncTaskFinished)
	{
		this.asyncTaskFinished = asyncTaskFinished;
	}

	public boolean isAsyncTaskFinished()
	{
		return asyncTaskFinished;
	}
}
