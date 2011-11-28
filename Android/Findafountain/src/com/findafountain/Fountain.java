package com.findafountain;

import com.findafountain.ObjectPool.Poolable;
import com.google.android.maps.GeoPoint;

/**
 * Represents a fountain object in the system. We use this class to represent a row in the
 * fountains database table to ease data passing between the system and the database.
 * @author Joel
 *
 */
public class Fountain implements Poolable{
	//Database Attributes
	private int id;
	private double longitude;
	private double latitude;
	
	//Whether or not the fountain has been drawn as an overlay
	//Note, this is not a DB attribute
	private boolean isReleased;
	
	public Fountain(){
		id = 0;
		longitude = 0;
		latitude = 0;		
		isReleased = false;
	}
	
	public int getId(){
		return id;
	}

	public void setId(int id){
		this.id = id;
	}

	public double getLongitude(){
		return longitude;
	}

	public void setLongitude(double longitude){
		this.longitude = longitude;
	}

	/**
	 * Returns the lat and long coords as a micro-degree Geopoint
	 */
	public GeoPoint getCoordinates(){
		GeoPoint point = new GeoPoint((int)(latitude * 1E6), (int)(longitude * 1E6));
		return point;
	}
	
	/**
	 * Returns the coordinates in LongLat format
	 * @return A LongLat object with the coordinates
	 */
	public LongLat getCoordinatesLongLat(){
		return new LongLat(longitude, latitude);
	}
	
	public double getLatitude(){
		return latitude;
	}

	public void setLatitude(double latitude){
		this.latitude = latitude;
	}

	@Override
	public boolean isReleased(){
		return isReleased;
	}

	@Override
	public void setReleased(boolean b){
		isReleased = b;
	}

}
