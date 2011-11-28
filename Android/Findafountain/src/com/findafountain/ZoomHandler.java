package com.findafountain;

import com.google.android.maps.MapView;

import android.os.Handler;
import android.os.Message;
import android.util.Log;

//Purpose: Represents a handler for polling the main UI to check for differences
//	in zoom levels due to pinching or zoom controls.
public class ZoomHandler extends Handler{
	private static final String TAG = "ZoomHandler";
	//The millisecond delay for polling
	public static final int zoomCheckingDelay = 500;
	//The remembered zoom level
	private int oldZoomLevel;
	//Caller's message handler
	private Handler zoomHandler;
	//Caller's map view instance
	private MapView mapView;
	
	/**
	 * Represents an enumeration of action values that will be used
	 * in messages sent to the main UI. This way, the main UI doesn't 
	 * need to know the integer values associated with the actions; it
	 * can simply use these constants.
	 * @author Joel
	 */
	public static final class Actions{
		public static final int ZOOM_OUT = 0;
		public static final int ZOOM_IN = 1;
	}
	
	public ZoomHandler(MapView mapView, Handler zoomHandler)
	{
		this.mapView = mapView;
		this.zoomHandler = zoomHandler;
		oldZoomLevel = mapView.getZoomLevel();
	}
	
	//Purpose: Handles the polling of the zoom level
    private Runnable zoomChecker = new Runnable(){
    	public void run(){
    		int newZoomLevel = mapView.getZoomLevel();
    		//If the previous zoom level is not equal to the new zoom level
    		if(oldZoomLevel != newZoomLevel){
    			Log.d(TAG, "zoomChecker: Zoom Level Changed from " + oldZoomLevel + " to " + newZoomLevel);
    			//Send a message to the caller indicating that there was a zoom change.
    			Message msg = Message.obtain();
    			
    			//Indicate whether we zoomed in or out
    			if(newZoomLevel < oldZoomLevel)
    				msg.what = Actions.ZOOM_OUT;
    			else if(newZoomLevel > oldZoomLevel)
    				msg.what = Actions.ZOOM_IN;
    			
    			//msg.what = 1;
    			zoomHandler.sendMessage(msg);
    			//Remember the most recent zoom level
    			oldZoomLevel = newZoomLevel;
    		}
    		//Remove the old callback
            zoomHandler.removeCallbacks(zoomChecker); 
            //Register a new one
            zoomHandler.postDelayed(zoomChecker, zoomCheckingDelay); 
        }
    };
    
    //Purpose: Simplifies the rehooking of the handle into the view 
	//	by autofilling the attributes.
	public void postDelayed()
	{
		super.postDelayed(zoomChecker, zoomCheckingDelay);
	}
	
	//Purpose: Remove the handle from the UI.
	public void removeCallbacks()
	{
		super.removeCallbacks(zoomChecker);
	}
}
