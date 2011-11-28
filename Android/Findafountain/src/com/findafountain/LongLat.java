package com.findafountain;

import com.google.android.maps.GeoPoint;

/**
 * Represents a (longitude, latitude) tuple.
 * We implement comparable to use the LongLat object as a sortable key
 * to be used in sorted sets like TreeSet.
 * 
 * We can also use this class in an object pool.
 * @author Joel
 */
public class LongLat{
	//Declared public to avoid useless accessor lookups
	public double longitude;
	public double latitude;
	private int cachedHashCode;
	/**
	 * Initializes the LongLat object to a zero state.
	 */
	public LongLat(){
		longitude = 0;
		latitude = 0;
		cachedHashCode = 0;
	}
	
	/**
	 * Constructs a new LongLat from the passed coordinates
	 * @param longitude Longitude coordinate.
	 * @param latitude Latitude coordinate.
	 */
	public LongLat(double longitude, double latitude){
		this.longitude = longitude;
		this.latitude = latitude;
	}
	
	/**
	 * Purpose:The hash function for the LongLat object.
	 * Note: We avoid creating temporary Double objects by implementing the hash computation 
	 * of the Double object directly.
	 * @return The hashcode for this object.
	 */
	public int hashCode(){
		//long v = Double.doubleToLongBits(longitude) + Double.doubleToLongBits(latitude);
		//return new Double(longitude).hashCode() + new Double(latitude).hashCode();
		//return (int)(v^(v>>>32));
		//return new Double(longitude).hashCode() ^ new Double(latitude).hashCode();
		int hc = cachedHashCode;
		if(hc == 0){
			String s = Double.toString(longitude) + Double.toString(latitude);
			hc = s.hashCode();
			cachedHashCode = hc;
		}
		return hc;
	}
	
	@Override
	public boolean equals(Object o){
		//Self check
		if(o == this) return true;
		//Null or non-matching type check
		if(o == null || !(o instanceof LongLat)) return false;
		
		//Return true if longitudes and latitudes respectively match. 
		LongLat cp = LongLat.class.cast(o);
		
		boolean isEqual = (longitude == cp.longitude) && (latitude == cp.latitude);
		return isEqual;
	}
	
	/**
	 * Initializes the longlat attributes from the passed Geopoint
	 * @param p A geopoint whose values will populate this object's attributes.
	 */
	public void initFromGeoPoint(GeoPoint p){
		longitude = LongLat.microdegreeToCoordinate(p.getLongitudeE6());
		latitude = LongLat.microdegreeToCoordinate(p.getLatitudeE6());
	}
	
	/**
	 * Returns the lat and long coords as a micro-degree Geopoint
	 */
	public static GeoPoint toGeoPoint(double latitude, double longitude)
	{
		return new GeoPoint((int) (latitude * 1E6), (int)(longitude * 1E6));
	}

	/**
	 * Converts a GeoPoint object into a LongLat object
	 * @param g A GeoPoint to be converted.
	 * @return LongLat object with the longitude and latitude information.
	 */
	public static LongLat toLongLat(GeoPoint g)
	{
		return new LongLat(g.getLongitudeE6()/1E6, g.getLatitudeE6()/1E6);
	}
	
	/**
	 * Converts a passed microdegree into a geocoordinate (longitude or latitude value).
	 * @param mdegree A microdegree value.
	 * @return The geocoordinate equivalent of the passed microdegree.
	 */
	public static double microdegreeToCoordinate(int mdegree)
	{
		return mdegree / 1E6;
	}
}
