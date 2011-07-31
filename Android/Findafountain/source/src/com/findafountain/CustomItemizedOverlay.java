package com.findafountain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

import net.londatiga.android.ActionItem;
import net.londatiga.android.QuickAction;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Toast;

import com.google.android.maps.GeoPoint;
import com.google.android.maps.MapView;

/**
 * Represents a manager of our custom fountain overlay items. 
 * @author Joel
 *
 */
public class CustomItemizedOverlay extends FountainItemizedOverlay {
	private ArrayList<FountainOverlayItem> overlayItems;
	//Holds the locations of each fountainoverlayitem added. We use this to avoid duplicate overlay items
	private ArrayList<LongLat> itemLocations;
	private Context c;
	//private MapView mapView;
	public CustomItemizedOverlay(Drawable defaultMarker, MapView mapView) {
		super(boundCenter(defaultMarker), mapView);
		c = mapView.getContext();
		//this.mapView = mapView;
		overlayItems = new ArrayList<FountainOverlayItem>();
		itemLocations = new ArrayList<LongLat>();
	}

	public void addOverlay(FountainOverlayItem overlay) {
		LongLat olocation = overlay.getFountainData().getCoordinatesLongLat();
		//If the geocoordinates of this overlay aren't already in the managed locations list
		if(itemLocations.contains(olocation)) return;
	   	
		//Otherwise, add the location and the overlay items to their respective lists.
		itemLocations.add(olocation);
		overlayItems.add(overlay);
	    populate();
	}

	@Override
	protected FountainOverlayItem createItem(int i) {
		return overlayItems.get(i);
	}

	@Override
	public int size() {
		return overlayItems.size();
	}

	public void clear()
	{
		itemLocations.clear();
		overlayItems.clear();
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
		//final FountainQuickAction qa = new FountainQuickAction(c, getBalloonView());
		//qa.show();
		return true;
	}

	/**
	 * Allows us to limit the zoom level of the mapview.
	 * This is crude, but seems to be the only solution.
	 */
	@Override
    public void draw(Canvas canvas, MapView mapView, boolean shadow) {
        
        if (mapView.getZoomLevel() < 16)
            mapView.getController().setZoom(16);
        super.draw(canvas, mapView, shadow);
    }
	
}