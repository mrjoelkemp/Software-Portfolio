package com.findafountain;

import android.content.Context;
import android.content.Intent;
import android.graphics.PorterDuff.Mode;
import android.net.Uri;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RatingBar;
import android.widget.TextView;
import android.widget.Toast;

public class FountainBalloonOverlayView extends FrameLayout 
{
	private LinearLayout layout;
	//Widgets of the fountain balloon view
//	private TextView status;
//	private TextView parkName;
//	private RatingBar ratingBar;
	private Button reportButton;
	//private Button flagButton;
	private ImageView closeImage;
	
	public FountainBalloonOverlayView(final Context context, int balloonBottomOffset)
	{
		super(context);
		
		setPadding(10, 0, 10, balloonBottomOffset);
		layout = new LinearLayout(context);
		layout.setVisibility(VISIBLE);

		//Prepare the layout inflater to inflate the balloon gui
		LayoutInflater inflater = (LayoutInflater) context
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		
		//Create an inflated view from the fountain balloon view
		View v = inflater.inflate(R.layout.simplefountainballoon, layout);
		
		/*
		//Locate the widgets
		reportButton = (Button) v.findViewById(R.id.fountain_report_button);
		//Programatically clear off any background color
		reportButton.getBackground().setColorFilter(0xFFFF0000, Mode.CLEAR);
		reportButton.setHapticFeedbackEnabled(true);
		reportButton.setOnClickListener(new OnClickListener(){
			@Override
			public void onClick(View v){
				reportButton.performHapticFeedback(1);
				Toast.makeText(v.getContext(), "I've reported", Toast.LENGTH_LONG).show();
				
				//Point the browser to http://on.nyc.gov/mDeRkQ
				Uri url = Uri.parse("http://on.nyc.gov/mDeRkQ");
				//Send an intent to open the browser
				Intent launchBrowser = new Intent(Intent.ACTION_VIEW, url);
				context.startActivity(launchBrowser);

				FountainBalloonOverlayView.this.setVisibility(GONE);
			}
		});
		*/
//		flagButton = (Button) v.findViewById(R.id.fountain_flag_button);
//		flagButton.getBackground().setColorFilter(0xFF000000, Mode.CLEAR);
//		flagButton.setHapticFeedbackEnabled(true);
//		flagButton.setOnClickListener(new OnClickListener(){
//			@Override
//			public void onClick(View v){
//				flagButton.performHapticFeedback(1);
//				//Push a flag to the server for this fountain
//				//Have server do cleanup of the fountains, not the client
//			}
//		});
		
//		closeImage = (ImageView) v.findViewById(R.id.close_img_button);
//		closeImage.setOnClickListener(new OnClickListener() {
//			public void onClick(View v) {
//				layout.setVisibility(GONE);
//			}
//		});

		FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(
				LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
		params.gravity = Gravity.NO_GRAVITY;

		addView(layout, params);
	}
	
	/**
	 * Sets the view data from a given overlay item.
	 * 
	 * @param item - The overlay item containing the relevant view data 
	 * (title and snippet). 
	 */
	public void setData(FountainOverlayItem item) 
	{
//		//Get the fountain data associated with the overlay item
//		Fountain f = item.getFountainData();
//		
//		layout.setVisibility(VISIBLE);
//				
//		//If the fountain object data exists
//		if (f != null) 
//		{
//			parkName.setVisibility(VISIBLE);
//			//TODO: Figure out what to show as the main fountain information
//			parkName.setText("Park Name here!");
//			
//			//TODO: Implement fountain rating
//			ratingBar.setVisibility(VISIBLE);
//			ratingBar.setRating((float)2.0);
//			//ratingBar.setClickable(false);
//			//ratingBar.setEnabled(false);
//			
//			//TODO: Set fountain status attribute to text and remove the int
//			status.setVisibility(VISIBLE);
//			status.setText(f.getStatus());			
//		} 
	}
}
