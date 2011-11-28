package com.findafountain;

import android.graphics.drawable.Drawable;

import com.google.android.maps.GeoPoint;
import com.google.android.maps.OverlayItem;

/**
 * A custom fountain overlay item/marker that points to a fountain object and
 * contains a geopoint location where it should be rendered.
 * 
 * We kept the associated fountain object in case we needed additional
 * fountain information to be shown in FountainBalloons which accept 
 * FountainOverlayItems to set their data.
 * 
 * Unfortunately, the position of the overlay is Final and
 * can't be modified. Hence, these overlay items can't be
 * pooled or reused.
 * @author Joel
 */
public class FountainOverlayItem extends OverlayItem
{
	//Pointer to the fountain data that associated with the overlay item
	private Fountain fountain;
	
	/**
	 * Constructor for the fountain overlay
	 * @param f Fountain information associated with overlay
	 * @param marker Drawable to be rendered
	 */
	public FountainOverlayItem(Fountain f, Drawable marker)
	{
		//Overlay position is the fountain's coordinates
		super(f.getCoordinates(), "", "");
		super.setMarker(marker);
		this.fountain = f;		
	}
	
	public Fountain getFountainData(){
		return fountain;
	}
	
	/**
	 * Releases the fountain to the pool.
	 */
	public void releaseFountain(){
		DBAdapter.pool.release(fountain);
	}
}
