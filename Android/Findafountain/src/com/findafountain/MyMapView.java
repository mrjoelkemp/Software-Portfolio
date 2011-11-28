package com.findafountain;

import android.content.Context;
import android.util.AttributeSet;
import android.view.GestureDetector;
import android.view.GestureDetector.OnDoubleTapListener;
import android.view.GestureDetector.OnGestureListener;
import android.view.MotionEvent;

import com.google.android.maps.MapView;

/**
 * Extends the google map view to allow for double tap detection
 * @author Joel
 *
 */
public class MyMapView extends MapView
{
	//Detects various gestures including double tap
	private GestureDetector gestureDetector;
	
	public MyMapView(Context context, AttributeSet attrs)
	{
		super(context, attrs);
		gestureDetector = new GestureDetector((OnGestureListener) context);
		gestureDetector.setOnDoubleTapListener((OnDoubleTapListener)context);
	}

	/**
	 * Override the onTouchEvent() method to intercept events and pass them
	 * to the GestureDetector. If the GestureDetector doesn't handle the event,
	 * propagate it up to the MapView.
	 */
	public boolean onTouchEvent(MotionEvent ev) 
	{
		//If the gestureDetector handled the event, then it was a double tap
		if(this.gestureDetector.onTouchEvent(ev))
			return true;
		//Otherwise, pass the event to the map view
		else
			return super.onTouchEvent(ev);
	}
}
