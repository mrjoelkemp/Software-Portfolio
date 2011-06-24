package com.findafountain;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.findafountain.MyActionBar.RefreshAction;
import com.findafountain.RestClient.RequestMethod;
import com.google.android.maps.GeoPoint;
import com.google.android.maps.MapActivity;
import com.google.android.maps.MapController;
import com.google.android.maps.MapView;
import com.google.android.maps.MyLocationOverlay;
import com.google.android.maps.Overlay;
import com.google.android.maps.OverlayItem;
import com.markupartist.android.widget.ActionBar;
import com.markupartist.android.widget.ActionBar.AbstractAction;

import android.app.ProgressDialog;
import android.graphics.Point;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.GestureDetector;
import android.view.GestureDetector.OnDoubleTapListener;
import android.view.GestureDetector.OnGestureListener;
import android.view.MotionEvent;
import android.view.View;
import android.view.GestureDetector.SimpleOnGestureListener;
import android.view.View.OnClickListener;
import android.view.ViewGroup.LayoutParams;
import android.widget.LinearLayout;
import android.widget.Toast;

//Shows map with MapActivity
//Handles screen touches with OnTouchListener
public class MainActivity extends MapActivity implements OnDoubleTapListener, OnGestureListener
{
	private static String TAG = "MainActivity";
	
	private MyMapView mapView;
	
	//Keeps track of the user's location
	private MyLocationOverlay myLocationOverlay;
	//Handles polling for changes in the zoom level
	private ZoomHandler zoomHandler;
	//Handles the polling for panning/dragging changes
	private PanHandler panHandler;
	//Handles the messages coming from the PanHandler
	private Handler panMessageHandler;
	//Handles the messages coming from the action bar
	private Handler actionbarMessageHandler;
	//Handles the message coming from the zoom handler
	private Handler zoomMessageHandler;
	
	//Whether or not the UI is drawing the fountains
	//This will help prevent other threads from signaling another drawing
	private boolean isDrawingFountains;
	
	//Create a drawable linked to the custom blue and red markers
	private Drawable drinkableDrawable, brokenDrawable, pendingDrawable;
	//A customized list of drinkable/blue map overlays
	private CustomItemizedOverlay drinkableItemizedOverlay, brokenItemizedOverlay, pendingItemizedOverlay;
	
	//TODO: Create the DBAdapter instance in the Application subclass.
	public DBAdapter dbAdapter;
	//List of fountains retrieved from the Db
	private ArrayList<Fountain> fountains;
	//The activity's action bar.
	//Note: This needs to be accessible within all subclasses.
	private MyActionBar actionBar;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.mainactivity);
        
        //Init the class objects
        Initialize();
        
        //Draw the user's current location
		CreateMyLocation();
		
		//Load all existing fountains from the database
        LoadAllFountains();

        //Draw all existing fountain locations
        DrawFountainLocations();
       
        //Simulate a clicking of the actionbar refresh button
        actionBar.new RefreshAction().performAction(mapView);
    }
       
	@Override
	protected void onPause()
	{
    	super.onPause();
    	//When the application is paused, turn off the location tracking
		myLocationOverlay.disableMyLocation();
		myLocationOverlay.disableCompass();
		//Stop polling
		panHandler.removeCallbacks();
		zoomHandler.removeCallbacks();
	}

	@Override
	protected void onResume()
	{
		super.onResume();
		//Point to the user's current location and draw marker.
		//When the application comes into the foreground, turn location tracking on
		myLocationOverlay.enableMyLocation();
		myLocationOverlay.enableCompass();
		//Register a new polling handler
		zoomHandler.postDelayed();
		panHandler.postDelayed();
	}
		
	@Override
	protected boolean isRouteDisplayed()
	{
		// TODO Auto-generated method stub
		return false;
	}
	
	//Purpose: Sets up the mapView, mapController, and other objects
    private void Initialize()
    {    
        //Create an instance of our custom map view
        mapView = (MyMapView) findViewById(R.id.mymapview);
        mapView.setBuiltInZoomControls(true);		
		
		//Set up the map controller
		MapController mapController = mapView.getController();
		mapController.setZoom(16);
		
		//Set the drawing flag
		isDrawingFountains = false;
		
		//Handles all incoming messages from the zoom-level polling handler
		zoomMessageHandler = new Handler()
		{
			public void handleMessage(Message msg) 
			{
				super.handleMessage(msg);
				switch (msg.what) 
				{
					//The zoom level changed
					case 1:
						if(!isDrawingFountains) DrawFountainLocations();
						Log.d(TAG, "zoomMessageHandler: Zoom Message Handled!");
						break;
				}
			}
		};
		
		//Create the handler that maintains the changing zoom level overlay renderings
		zoomHandler = new ZoomHandler(mapView, zoomMessageHandler);
		
		//Handles all incoming messages from the pan polling handler
		panMessageHandler = new Handler()
		{
			public void handleMessage(Message msg) 
			{
				super.handleMessage(msg);
				switch (msg.what) 
				{
					//The pan finished
					case 1:
						if(!isDrawingFountains) DrawFountainLocations();
						Log.d(TAG, "panMessageHandler: PanHandling Complete!");
						break;
				}
			}
		};
		
		panHandler = new PanHandler(mapView, panMessageHandler);

		//Handles all incoming messages from the action bar
		actionbarMessageHandler = new Handler()
		{
			public void handleMessage(Message msg) 
			{
				super.handleMessage(msg);
				switch (msg.what) 
				{
					//Refresh
					case MyActionBar.Actions.REFRESH:
						if(!isDrawingFountains) DrawFountainLocations();
						Log.d(TAG, "actionbarMessageHandler: Refresh Message Handled!");
						break;
					//Add 
					case MyActionBar.Actions.ADD:
						Log.d(TAG, "actionbarMessageHandler: Add Message Handled!");
						break;
					//My Location
					case MyActionBar.Actions.MY_LOCATION:
						Toast.makeText(MainActivity.this, "Returning to Your Location", Toast.LENGTH_SHORT).show();
						//Animate to the user's last known location
						mapView.getController().animateTo(myLocationOverlay.getMyLocation());
						Log.d(TAG, "actionbarMessageHandler: MyLocation message handled!");
						break;
					//Filter
					case MyActionBar.Actions.FILTER:
						Toast.makeText(MainActivity.this, "Filter Soon!", Toast.LENGTH_SHORT).show();
						Log.d(TAG, "actionbarMessageHandler: Filter Message Handled!");
						break;
				}
			}
		};
		
		//Initialize the database adapter for all database operations
		dbAdapter = new DBAdapter(this);
		if(dbAdapter != null)
		{
			Log.d(TAG, "Initialize: dbAdapter Created.");
			//Create the action bar
			actionBar = (MyActionBar) findViewById(R.id.myactionbar);
			//actionBar = new MyActionBar(this, dbAdapter, actionbarMessageHandler);
			actionBar.Initialize(dbAdapter, actionbarMessageHandler);
			
			if(actionBar != null)
				Log.d(TAG, "Initialize: Actionbar Created.");
		}

		//Create the drawable images used in the map overlays
		drinkableDrawable = (Drawable) this.getResources().getDrawable(R.drawable.drinkable);
		brokenDrawable = (Drawable) this.getResources().getDrawable(R.drawable.broken);
		pendingDrawable = (Drawable) this.getResources().getDrawable(R.drawable.pending);
		
		//A customized list of drinkable/blue map overlays
		drinkableItemizedOverlay = new CustomItemizedOverlay(drinkableDrawable, mapView);
		brokenItemizedOverlay = new CustomItemizedOverlay(brokenDrawable, mapView);
		pendingItemizedOverlay = new CustomItemizedOverlay(pendingDrawable, mapView);
		
		Log.d(TAG, "Initialize: Initialization Complete!");
    }//end Initialize()
    
    //Purpose: Sets up the MyLocationOverlay object that maintains the user's
    //	current location and renders both a marker and approximation radius.
    private void CreateMyLocation()
    {
    	//Create the My Location overlay
		myLocationOverlay = new MyLocationOverlay(this, mapView);
        mapView.getOverlays().add(myLocationOverlay);
        myLocationOverlay.enableCompass();
        myLocationOverlay.enableMyLocation();
        myLocationOverlay.runOnFirstFix(new Runnable() 
        {
        	//Purpose: Handles what occurs when the location overlay object
        	//	is first created!
            public void run() 
            {
            	//Grab the user's best known location and move the map to it.
                mapView.getController().animateTo(myLocationOverlay.getMyLocation());
            }
        });
        
        Log.d(TAG, "CreateMyLocation: MyLocationOverlay Created!");
    }
    
    //Purpose: Loads all fountains from the database into the list of fountain objects.
    public void LoadAllFountains()
    {
    	this.fountains = dbAdapter.SelectFountains();
    	Log.d(TAG, "LoadAllFountains: " + fountains.size() + " existing fountains loaded from DB.");
    }
       
    //Purpose: Creates map markers/overlays for each fountain location based on the user's current location.
    //Precondition: Fountain list must be populated with fountains to be drawn.
    public void DrawFountainLocations()
    {
    	//Restrict other simultaneous draw calls
    	isDrawingFountains = true;
    	
    	//A list of overlays for the current map
		List<Overlay> mapOverlays = mapView.getOverlays();

		//Bounding box of our current view
		//Used to restrict rendering of the overlays
		Rect rect = new Rect(0,0,mapView.getWidth(), mapView.getHeight());
		
		//For each loaded fountain
    	for(int i = 0; i < fountains.size(); i++)
    	{
    		//Cache the current fountain
          	Fountain f = fountains.get(i);
          
          	if(f != null)
          	{
	          	//Convert the fountains geolocation data into microdegrees
	    		GeoPoint point = f.getCoordinates();
	    		Point out = new Point();
	    		//Get the pixel coordinates of our fountain's location
	    		mapView.getProjection().toPixels(point, out);
	    		//If the view's bounding rectangle contains the current fountain
	    		// and the fountain hasn't been drawn
	    		if(rect.contains(out.x, out.y) && !f.getIsDrawn())
	    		{
	    			//Set the fountain as drawn to prevent it from being redrawn
	    			f.setIsDrawn(true);
	    			
		    		//Create an overlay item for the current fountain point
	    			//TODO: Change the text that gets displayed in the balloon overlay
	    			//Get address as title
	     			//Show details:
	    			//	Rating
	    			//	Show
	    			try
	    			{	    			
			    		OverlayItem overlayitem = new OverlayItem(point, "Hello", "I'm fountain " + i + "!");
			    		//mapView.getOverlays().
			    		//Add the overlay to the appropriate overlay
			    		if(f.getStatus() == 1)
			    			drinkableItemizedOverlay.addOverlay(overlayitem);	
			    		else if(f.getStatus() == 0)
			    			brokenItemizedOverlay.addOverlay(overlayitem);
			    		else if(f.getStatus() == 2)
			    			pendingItemizedOverlay.addOverlay(overlayitem);
	    			}
	    			catch(Exception e)
	    			{
	    				Log.e(TAG, "DrawFountainLocations: " + e);
	    			}
	    		}//end if
          	}//end if
          	else
          		Log.e(TAG, "DrawFountainLocations: Fountain was equal to null!");
    	}    	
    		
    	//Add the list of overlays to the maps's overlay list
    	if(drinkableItemizedOverlay.size() > 0)
    	{
    		mapOverlays.remove(drinkableItemizedOverlay);
    		mapOverlays.add(drinkableItemizedOverlay);
    	}
    	if(brokenItemizedOverlay.size() > 0)
    	{	
    		mapOverlays.remove(brokenItemizedOverlay);
    		mapOverlays.add(brokenItemizedOverlay);
    	}
    	if(pendingItemizedOverlay.size() > 0)
    	{	
    		mapOverlays.remove(pendingItemizedOverlay);
    		mapOverlays.add(pendingItemizedOverlay);
    	}
    	
    	//Force the redrawing of the mapview to avoid artifacts
    	mapView.postInvalidate();
    	Log.d(TAG, "Map View Invalidated!");
    	//Reset the flag to allow for another draw call
    	isDrawingFountains = false;
    	Log.d(TAG, drinkableItemizedOverlay.size() + " Drinkable Fountain Overlays Drawn!");
    	Log.d(TAG, brokenItemizedOverlay.size() + " Broken Fountain Overlays Drawn!");
    	Log.d(TAG, pendingItemizedOverlay.size() + " Pending Fountain Overlays Drawn!");
    }

    //OnDoubleTapListener's Methods
    
    //Purpose: On a user's double tap, zoom in the map
	@Override
	public boolean onDoubleTap(MotionEvent e)
	{
		//Get the point of the double tap
		//GeoPoint p = mapView.getProjection().fromPixels((int)e.getX(), (int)e.getY());
		//Animate to the double tapped location
		//mapView.getController().animateTo(p);
		//On a double tap, zoom the 
		mapView.getController().zoomIn();
		return true;
	}

	@Override
	public boolean onDoubleTapEvent(MotionEvent e)
	{
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean onSingleTapConfirmed(MotionEvent e)
	{
		// TODO Auto-generated method stub
		return false;
	}
	
	//OnGestureListener Methods
	@Override
	public boolean onDown(MotionEvent e) {
		return false;
	}

	@Override
	public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
		return false;
	}

	@Override
	public void onLongPress(MotionEvent e) {
	}

	@Override
	public boolean onScroll(MotionEvent e1, MotionEvent e2, float distanceX, float distanceY) {
		return false;
	}

	@Override
	public void onShowPress(MotionEvent e) {
	}

	@Override
	public boolean onSingleTapUp(MotionEvent e) {
		return false;
	}
}