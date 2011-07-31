package com.findafountain;

import com.findafountain.ObjectPool.Poolable;
import com.google.android.maps.GeoPoint;

/**
 * Represents a fountain object in the system. We use this class to represent a row in the
 * fountains database table to ease data passing between the system and the database.
 * @author Joel
 *
 */
public class Fountain implements Poolable
{
	//Database Attributes
	private int id;
	private double longitude;
	private double latitude;
	//private int status;
	private String status;
	
	//Whether or not the fountain has been drawn as an overlay
	//Note, this is not a DB attribute
	private boolean isReleased;
	
	/**
	 * A list of possible statuses for the fountain. 
	 * We expect the values to mirror the server's possible fountain status values
	 * This isn't ideal, as any change in that table of the server will result in 
	 * a loss of the association we are establishing with this class.
	 * However, we don't anticipate the status' ever changing.
	 * @author Joel
	 */
	public final class Status
	{
		public static final String DRINKABLE = "Drinkable";
		public static final String PENDING = "Pending";
		public static final String BROKEN = "Broken";
	}
	
	public Fountain()
	{
		id = 0;
		longitude = 0;
		latitude = 0;
		status = "";
		
		isReleased = false;
	}
	
	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public double getLongitude()
	{
		return longitude;
	}

	public void setLongitude(double longitude)
	{
		this.longitude = longitude;
	}

	/**
	 * Returns the lat and long coords as a micro-degree Geopoint
	 */
	public GeoPoint getCoordinates()
	{
		GeoPoint point = new GeoPoint((int) (latitude * 1E6), (int)(longitude * 1E6));
		return point;
	}
	
	/**
	 * Returns the coordinates in LongLat format
	 * @return A LongLat object with the coordinates
	 */
	public LongLat getCoordinatesLongLat()
	{
		return new LongLat(longitude, latitude);
	}
	
	public double getLatitude()
	{
		return latitude;
	}

	public void setLatitude(double latitude)
	{
		this.latitude = latitude;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	@Override
	public boolean isReleased()
	{
		return isReleased;
	}

	@Override
	public void setReleased(boolean b)
	{
		isReleased = b;
	}

}
