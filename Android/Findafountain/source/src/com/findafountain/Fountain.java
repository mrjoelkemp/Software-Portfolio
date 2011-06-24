package com.findafountain;

import java.util.Locale;

import android.location.Address;

import com.google.android.maps.GeoPoint;

//Purpose:
//	Represents a fountain object in the system. We use this class to represent a row in the
// 	fountains database table to ease data passing between the system and the database.
public class Fountain
{
	//Database Attributes (in order)
	private int id;
	private double longitude;
	private double latitude;
	private int status;
	private int city_id;
	
	
	//Whether or not the fountain has been drawn as an overlay
	//Note, this is not a DB attribute
	private boolean isDrawn;
	//The address (Street, City & State, Country) of the fountain
//	private Address address;
	
	public Fountain()
	{
		id = 0;
		longitude = 0;
		latitude = 0;
		status = 1;
		city_id = 1;
		isDrawn = false;
		//address = new Address(Locale.getDefault());
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

	//Purpose: Returns the lat and long coords as a micro-degree Geopoint
	public GeoPoint getCoordinates()
	{
		GeoPoint point = new GeoPoint((int) (latitude * 1E6), (int)(longitude * 1E6));
		return point;
	}
	
	public double getLatitude()
	{
		return latitude;
	}

	public void setLatitude(double latitude)
	{
		this.latitude = latitude;
	}

	public int getStatus()
	{
		return status;
	}

	public void setStatus(int status)
	{
		this.status = status;
	}

	public int getCity_id()
	{
		return city_id;
	}

	public void setCity_id(int city_id)
	{
		this.city_id = city_id;
	}

	public boolean getIsDrawn()
	{
		return isDrawn;
	}
	
	public void setIsDrawn(boolean isDrawn)
	{
		this.isDrawn = isDrawn;
	}

//	public void setAddress(Address address)
//	{
//		this.address = address;
//	}
//
//	public Address getAddress()
//	{
//		return address;
//	}
//	
//	//Purpose: Allows the direct setting of the street of the address attribute.
//	public void setStreet(String street)
//	{
//		this.address.setAddressLine(0, street);
//	}
//	
//	public String getStreet()
//	{
//		return this.address.getAddressLine(0);
//	
//	}

}
