package com.findafountain;

import com.google.android.maps.GeoPoint;
import com.google.android.maps.OverlayItem;

/**
 * A custom fountain overlay item/marker that points to a fountain object and
 * contains a geopoint location where it should be rendered.
 * @author Joel
 */
public class FountainOverlayItem extends OverlayItem
{
	//Pointer to the fountain data that associated with the overlay item
	private Fountain fountain;
	
	public FountainOverlayItem(GeoPoint point, Fountain f)
	{
		super(point, "", "");
		this.fountain = f;
	}
	
	public Fountain getFountainData()
	{
		return fountain;
	}
}
