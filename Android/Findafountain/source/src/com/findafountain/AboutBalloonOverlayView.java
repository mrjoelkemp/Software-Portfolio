package com.findafountain;

import android.content.Context;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.FrameLayout.LayoutParams;

/**
 * Singleton About (with author info) balloon for the mapview.
 * @author Joel
 */
public class AboutBalloonOverlayView extends FrameLayout 
{
	private static AboutBalloonOverlayView instance = null;
	
	/**
	 * Whether or not the balloon is currently active.
	 * If the close button is pressed, the balloon is inactive.
	 * We'll set this to true from the outside after some mapview init
	 * 	in the mainactivity. This isn't ideal, but otherwise we'd have to 
	 * 	create init logic here and it would be messy.
	 */
	//public boolean isActive = false;
	private LinearLayout layout;
	
	/**
	 * Returns a new or reused AboutBalloonOverlayView
	 * @param context
	 * @param offset Balloon Offset
	 * @return New or reused instance of this object.
	 */
	public static AboutBalloonOverlayView getInstance(Context context, int offset)
	{
		if(instance == null)
			instance = new AboutBalloonOverlayView(context, offset);
		
		return instance;
	}
	
	private AboutBalloonOverlayView(Context context, int balloonBottomOffset)
	{
		super(context);

		setPadding(10, 0, 10, balloonBottomOffset);
		layout = new LinearLayout(context);
		layout.setVisibility(VISIBLE);
		
		//Prepare the layout inflater to inflate the balloon gui
		LayoutInflater inflater = (LayoutInflater) context
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		
		//Create an inflated view from the fountain balloon view
		View v = inflater.inflate(R.layout.aboutballoon, layout);
		
		ImageView closeImage = (ImageView) v.findViewById(R.id.close_img_button);
		closeImage.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				//Set the view, not linearlayout to invisible
				setVisibility(GONE);
				//isActive = false;
			}
		});

		FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(
				LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
		params.gravity = Gravity.NO_GRAVITY;

		addView(layout, params);
	}

}
