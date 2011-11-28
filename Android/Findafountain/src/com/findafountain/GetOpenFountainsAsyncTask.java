package com.findafountain;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.util.ArrayList;

import org.codehaus.jackson.JsonFactory;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.JsonToken;
import org.codehaus.jackson.sym.Name;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.findafountain.RestClient.RequestMethod;

import android.os.AsyncTask;
import android.os.Handler;
import android.os.Message;
import android.util.Log;

/**
 * Represents an async thread that uses the NYC Opendata API to fetch the list
 * of fountain locations in a JSON format.
 * @author Joel
 */
public class GetOpenFountainsAsyncTask extends AsyncTask<String, Integer, Integer>
{
	private static final String TAG = "GetOpenFountainsAsyncTask";
	private static final String SERVER_URL = "http://nycopendata.socrata.com/api/views/4z75-dszx/";
	//Pointer to the database adapter for db operations.
	private DBAdapter dbAdapter;
	//The handler that can receive this thread's messages
	private Handler messageHandler;

	public GetOpenFountainsAsyncTask(DBAdapter db, Handler messageHandler) 
	{
		dbAdapter = db;
		this.messageHandler = messageHandler;
		Log.d(TAG, "Async Task Intialized.");
	}
	
	/**
	 * @param url parameter supplied by action bar. Allows us to 
	 * pull from multiple servers.
	 */
	@Override
	protected Integer doInBackground(String... url)
	{
		//Poll the server and grab the JSON input stream response
		InputStream instream = RequestFountainsInputStream(SERVER_URL + url[0]);
		//Incrementally process and store the fountains
		int numFountainsProcessed = InputStreamToFountains(instream);
		if(numFountainsProcessed == 0){
			Log.e(TAG, "doInBackground: 0 Fountains Processed!");
			//Send a message to the UI indicating that the response was bad!
			Message msg = Message.obtain();
			//This message is coming from the refresh action (GetAsyncTask)
			msg.what = MyActionBar.Actions.REFRESH;
			//We'll use -1 to indicate an error
			msg.arg1 = -1;
			//Post the message to the observer
			messageHandler.sendMessage(msg);
		}
		//Return the number of parsed fountains
		return numFountainsProcessed;
	}
	
	@Override
	protected void onPostExecute(Integer result)
	{		
		Message msg = Message.obtain();
		msg.what = MyActionBar.Actions.REFRESH;
		//Pack the number of fountains processed from the server
		msg.arg1 = result;
		//Post the message to the observer
		messageHandler.sendMessage(msg);
		Log.d(TAG, "onPostExecute: Result sent to UI thread.");
	}
	
	/**
	 * Uses the JacksonStreaming parser to parse the large JSON retrieved from the
	 * restful server. The parser parses incrementally, creating fountain objects,
	 * and flushing the objects to the DB after a certain capacity.
	 * 
	 * @param instream Contains the NYC Opendata's API response
	 * @return The total number of processed fountains.
	 * 
	 * Notes: This function is vital in preventing OutofMemory errors.
	 * 	It is not possible to store the entire JSON as a string and do parsing
	 * 		on the whole string at once. It must be done incrementally. To avoid
	 *		the large string in memory, we parse the raw input stream.
	 */
	private int InputStreamToFountains(InputStream instream)
	{
        ArrayList<Fountain> readFountains = new ArrayList<Fountain>();
        String lon = null, lat = null, idVal = null;
        int numFountains = 0;
        try{
			JsonParser jp = new JsonFactory().createJsonParser(instream);
			jp.nextToken(); 									//Starting element			
			while (jp.nextToken() != JsonToken.END_OBJECT) { 	//Find the data element
				String fieldname = jp.getCurrentName();
				jp.nextToken(); 								//Get value
				if ("data".equals(fieldname)) break;
				jp.skipChildren();
			}						
			JsonToken dataArray = jp.nextToken();
			while(dataArray != JsonToken.END_ARRAY){
				JsonToken sub = jp.nextToken();
				while (sub != JsonToken.END_ARRAY) {					
					if(sub == JsonToken.VALUE_STRING){			//ID of fountain
						idVal = jp.getText();
						sub = jp.nextToken();
					} else if(sub == JsonToken.START_OBJECT){	//Start of fountain obj
						while(jp.nextToken() != JsonToken.END_OBJECT){
							String namefield = jp.getCurrentName();
							jp.nextToken(); //Get value
							if ("longitude".equals(namefield))		lon = jp.getText();
							else if ("latitude".equals(namefield))	lat = jp.getText();
							else if ("geometry".equals(namefield))	jp.skipChildren();							
						}					   
						readFountains.add(createFountain(idVal, lon, lat));
						numFountains++;					
						//Flush fountains to preserve pool
						if(numFountains % 500 == 0) pushAndRelease(readFountains);
						jp.nextToken(); 						//Skip park ID
						sub = jp.nextToken();
					} else sub = jp.nextToken();				//If it's an unused int or null, skip it
				}				
				dataArray = jp.nextToken(); //Skip to the next data array representing a fountain
		  	}
			if(readFountains.size() > 0) pushAndRelease(readFountains);	//Clean up	   
		} catch (JsonParseException e1){
			Log.e(TAG, "InputStreamToFountains: " + e1.toString());
		} catch (IOException e1){
			Log.e(TAG, "InputStreamToFountains: " + e1.toString());
		}
		Log.d(TAG, "InputStreamToFountains: " + numFountains + " processed!");
		return numFountains;
	}

	/**
	 * Helper to create a fountain from the raw JSON string data for a fountain.
	 * @param id String representing a fountain's id
	 * @param lon String representing a fountain's longitude
	 * @param lat String representing a fountain's latitude
	 * @return A pooled fountain object representation of the passed data.
	 */
	private Fountain createFountain(String id, String lon, String lat)
	{
		//Create a fountain object from the lon lat coords
		Fountain fountain = DBAdapter.pool.borrow();
		if(fountain == null){
			Log.e(TAG, "JSONtoFountain: Fountain object not borrowed. Pool is possibly full!");
			return null;
		}
	   
		//Set the properties of the reusable fountain
		fountain.setId(Integer.parseInt(id));
		fountain.setLatitude(Double.parseDouble(lat));
		fountain.setLongitude(Double.parseDouble(lon));
		return fountain;
	}
	
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
		Log.d(TAG, "pushAndRelease: " + num + "Fountains Sent to DB");
		
		//Release the fountain objects back to the pool
		for (int j = 0; j < num; j++)
			DBAdapter.pool.release(fountains.get(j));
		Log.d(TAG, "pushAndRelease: " + num + "Fountains Released to Pool");
		
		fountains.clear();
		Log.d(TAG, "pushAndRelease: Fountain Array Cleared.");
	}

	/**
	 * Uses the Rest client to initiate a GET request to the remote
	 * server identified by the passed URL. Expects the JSON to be too large
	 * to fit in a string and prepares the input stream of the Rest Client.
	 * @param absoluteURL The full URL to be queried.
	 * @return The server's JSON response in an input stream
	 */
	private InputStream RequestFountainsInputStream(String absoluteURL)
	{
		Log.d(TAG, "URL Created: " + absoluteURL);
		
		RestClient client = new RestClient(absoluteURL);
		try{
			Log.d(TAG, "RequestFountains: Get Request Started...");
			//Since the fetched JSON is HUGE, prepare for the input stream
			client.shouldDestroyInputStream(false);
			client.shouldConvertToString(false);
			client.Execute(RequestMethod.GET);
		}
		catch (Exception e){
			Log.e(TAG, "RequestFountains: " + e);
		}
		
		InputStream result = client.getInputStream();
		Log.d(TAG, "RequestFountains: Server response stream retrieved!");		
		
		return result;
	}
}