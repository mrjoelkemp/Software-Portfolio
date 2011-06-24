package com.findafountain;

import android.location.Location;
import android.os.Handler;
import android.os.Message;
import android.util.Log;

import com.google.android.maps.GeoPoint;
import com.google.android.maps.MapView;

public class PanHandler extends Handler
{
	private static final String TAG = "PanHandler";
	//The millisecond delay for polling
	private static final int panCheckingDelay = 500;
	//The previously stored map center
	private GeoPoint oldPanCenter;
	//Whether or not a panning sequence has been initiated.
	private boolean isPanning;
	//The kilometer distance threshold between two geopoints
	private double DISTANCE_THRESHOLD = .01;

	//Caller mapview instance to give us map center
	private MapView mapView;
	//Caller handler to accept our messages
	private Handler panHandler;
	public PanHandler(MapView mapView, Handler panHandler)
	{
		this.mapView = mapView;
		this.panHandler = panHandler;
		oldPanCenter = mapView.getMapCenter();
		isPanning = false;
	}
	
	private Runnable panChecker = new Runnable()
	{
		@Override
		public void run()
		{
			//Poll the viewing center of the map as a geopoint
	        GeoPoint newPanCenter = mapView.getMapCenter();
	        
	        //Holds the computed point distance
	        //results[0] contains the real distance
	        float [] results = new float[3];
	        //Compute the distance between the old center and new center
	        Location.distanceBetween(newPanCenter.getLatitudeE6(),
	        		newPanCenter.getLongitudeE6(), oldPanCenter.getLatitudeE6(), 
	        		oldPanCenter.getLongitudeE6(), results);
			float distance = results[0];
			
	        //If the center has changed, a swipe has been triggered
	        if(distance > DISTANCE_THRESHOLD && !isPanning)
	        {
	        	Log.d(TAG, "panChecker: Panning Started... OldCenter: " + oldPanCenter.toString() + " NewCenter " + newPanCenter.toString());
	        	//We are now panning
	        	isPanning = true;
	        	oldPanCenter = newPanCenter;
	        }
	        //If the centers have converged and we were panning
	        else if(distance < DISTANCE_THRESHOLD && isPanning)
	        {
	        	//Turn off the panning flag
	        	isPanning = false;
	        	//Pack a message to tell the caller that we're done.
	        	Message msg = Message.obtain();
	        	msg.what = 1;
	        	panHandler.sendMessage(msg);
	        	Log.d(TAG, "panChecker: Panning Finished!");
	        }
	        //Otherwise, the map is still panning and hasn't converged
	        else if(distance > DISTANCE_THRESHOLD && isPanning)
	        {
	           	//Keep track of the changing center to later test for convergence.
	        	oldPanCenter = newPanCenter;
	        }
	        
	        //Remove the old callback
	        removeCallbacks(); 
	        //Register a new one
	        postDelayed();
		}
	};
	
	//Purpose: Simplifies the rehooking of the handle into the view 
	//	by autofilling the attributes.
	public void postDelayed()
	{
		super.postDelayed(panChecker, panCheckingDelay);
	}
	
	//Purpose: Remove the handle from the UI.
	public void removeCallbacks()
	{
		super.removeCallbacks(panChecker);
	}
}
