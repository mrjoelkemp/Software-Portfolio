package com.findafountain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Toast;

import com.findafountain.MyActionBar.Actions;
import com.google.android.maps.GeoPoint;
import com.google.android.maps.MapView;

/**
 * Represents a manager of our custom fountain overlay items. 
 * @author Joel
 *
 */
public class CustomItemizedOverlay extends FountainItemizedOverlay {
	private static final int MIN_ZOOM_LEVEL = 16;
	private static final int MAX_BUFFER_SIZE = 75;
	public static final int ZOOM_TOO_FAR = 1;
	private ArrayList<FountainOverlayItem> overlayItems;
	//Holds the locations of each fountainoverlayitem added. 
	//We use this to avoid duplicate overlay items
	//private ArrayList<LongLat> itemLocations;
	private HashSet<LongLat> itemLocations;
	private Handler mapHandler;
	private static final String TAG = "CustomItemizedOverlay";
	
	
	public CustomItemizedOverlay(Drawable defaultMarker, MapView mapView, Handler mapHandler) {
		super(boundCenter(defaultMarker), mapView);
		overlayItems = new ArrayList<FountainOverlayItem>();
		//itemLocations = new ArrayList<LongLat>();
		itemLocations = new HashSet<LongLat>();
		this.mapHandler = mapHandler;
	}

	public void addOverlay(FountainOverlayItem overlay) {
		LongLat olocation = overlay.getFountainData().getCoordinatesLongLat();
		//If the geocoordinates of this overlay aren't already in the managed locations list
		//if(itemLocations.contains(olocation)) return;
		
		//Otherwise, add the location and the overlay items to their respective lists.
		itemLocations.add(olocation);
		overlayItems.add(overlay);
	    populate();		//Process new overlay
	}
	
	/**
	 * Adds the passed overlay items into the unique
	 * buffer of overlays. Handles buffer overflow and refresh.
	 * 
	 * Notes:
	 * 
	 *  If the number of unique overlays to add will flush the buffer, then clear
	 *  the buffer and store all of the overlays (including the previously deemed 
	 *  duplicates). If we only store the unique ones after flushing the buffer, then
	 *  we won't see the previously rendered overlays. 
	 *  
	 *  Worst Case: Consider moving the screen only enough to get one new overlay that
	 *  triggers a buffer refresh. If we don't add the previous duplicates, then we'll
	 *  only see the one new overlay being drawn. This is bad.
	 *  
	 *  If the number of unique overlays won't trigger a buffer flush, then we have
	 *  space for the new overlays, so we don't need the duplicates. Hence, we remove
	 *  them from the passed list of overlays. 
	 *  
	 * @param overlays FountainOverlayItems to be added.
	 */
	public void addOverlays(LinkedList<FountainOverlayItem> overlays){
		
		int numDuplicates = countDuplicates(overlays);
		
		int numToBeAdded = overlays.size() - numDuplicates; //Unique overlays to add
		int elementsInBuffer = overlayItems.size();
		int bufferRoomLeft = MAX_BUFFER_SIZE - elementsInBuffer;
		
		//If there's not enough room in the buffer for the new items, clear the buffer
		//	but don't remove the duplicates. We need those to avoid a blank screen.
		if(numToBeAdded > bufferRoomLeft) clear();	
		//Otherwise, there's enough space for the unique items, so get only the 
		//	unique overlays to be added
		else removeDuplicates(overlays);
		
		//Add the overlays to the buffer
		for (FountainOverlayItem f : overlays)
			addOverlay(f);	
		
		Log.d(TAG, numToBeAdded + " overlays added to buffer! Buffer size = " + overlayItems.size());
	}
	
	/**
	 * Iterates through the passed list counting fountain overlays whose
	 * 	internal fountain locations are already managed by our list of locations.
	 * 	i.e., are already being rendered.
	 * @param overlays List of overlays to be added
	 * @param remove Whether or not we should directly remove duplicates
	 */
	private int countDuplicates(LinkedList<FountainOverlayItem> overlays){
		Iterator<FountainOverlayItem> it = overlays.iterator();
		int numDuplicates = 0;
		while(it.hasNext()){
			FountainOverlayItem f = it.next();
			LongLat olocation = f.getFountainData().getCoordinatesLongLat();
			//If the geocoordinates of this overlay exist in the
			//	list of managed locationes, count (and possibly remove) it
			if(itemLocations.contains(olocation)){ 
				numDuplicates++;
			}		
		}		
		Log.d(TAG, "countDuplicates: Number of Duplicates Found: " + numDuplicates);
		return numDuplicates;
	}
	
	private void removeDuplicates(LinkedList<FountainOverlayItem> overlays){
		Iterator<FountainOverlayItem> it = overlays.iterator();
		while(it.hasNext()){
			FountainOverlayItem f = it.next();
			LongLat olocation = f.getFountainData().getCoordinatesLongLat();
			//If the geocoordinates of this overlay exist in the
			//	list of managed locationes, count (and possibly remove) it
			if(itemLocations.contains(olocation)){ 
				it.remove();
			}		
		}		
	}
	
	@Override
	protected FountainOverlayItem createItem(int i) {
		return overlayItems.get(i);
	}

	@Override
	public int size() {
		return overlayItems.size();
	}
	/**
	 * Purges the list of handled locations and overlays
	 */
	public void clear(){
		//Release the fountains to the pool
		//for (FountainOverlayItem f : overlayItems) f.releaseFountain();
		Log.d(TAG, "Fountains Released!");
		itemLocations.clear();
		overlayItems.clear();
		Log.d(TAG, "Buffers Cleared!");
	}
	
	/**
	 * Hides the active balloon when the overlay is tapped.
	 */
	@Override
	public boolean onTap(GeoPoint p, MapView mapView)
	{
		hideBalloon();
		return super.onTap(p, mapView);
	}
	
	/**
	 * Opens a quickaction menu when the balloon is tapped.
	 */
	@Override
	protected boolean onBalloonTap(int index, FountainOverlayItem item) {
		return true;
	}

	/**
	 * Allows us to limit the zoom level of the mapview.
	 * This is crude, but seems to be the only solution.
	 * 
	 * We also turn off shadow rendering for the overlays
	 */
	@Override
    public void draw(Canvas canvas, MapView mapView, boolean shadow) {
        if (mapView.getZoomLevel() < MIN_ZOOM_LEVEL){
        //    mapView.getController().setZoom(MIN_ZOOM_LEVEL);
        	Message msg = Message.obtain();
        	msg.what = ZOOM_TOO_FAR;
        	mapHandler.sendMessage(msg);
        	Log.d(TAG, "draw: ZOOM_TOO_FAR message sent to main UI");
        }
        super.draw(canvas, mapView, false);
    }
	
}