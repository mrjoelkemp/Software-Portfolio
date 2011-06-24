package com.findafountain;

import com.google.android.maps.OverlayItem;
import com.readystatesoftware.mapviewballoons.R;

import android.content.Context;
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

public class FountainBalloonOverlayView<Item extends OverlayItem> extends FrameLayout 
{
	private LinearLayout layout;
	//Widgets of the fountain balloon view
	private TextView status;
	private TextView parkName;
	private RatingBar ratingBar;
	private ImageView closeImage;
	
	public FountainBalloonOverlayView(Context context, int balloonBottomOffset)
	{
		super(context);
		
		setPadding(10, 0, 10, balloonBottomOffset);
		layout = new LinearLayout(context);
		layout.setVisibility(VISIBLE);

		//Prepare the layout inflater to inflate the login gui
		LayoutInflater inflater = (LayoutInflater) context
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		
		//Create an inflated view from the fountain balloon view
		View v = inflater.inflate(R.layout.fountainballoon, layout);

		//Locate the widgets
		parkName = (TextView) v.findViewById(R.id.fountain_park_name);
		status = (TextView) v.findViewById(R.id.fountain_status);
		ratingBar = (RatingBar) v.findViewById(R.id.fountain_ratingbar);
		
		//DEBUG: Set test data
		ratingBar.setRating((float) 2.0);
		parkName.setText("Park Name here!");
		status.setText("Drinkable");
		
		closeImage = (ImageView) v.findViewById(R.id.close_img_button);
		closeImage.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				layout.setVisibility(GONE);
			}
		});

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
	public void setData(Item item) 
	{
//		
//		layout.setVisibility(VISIBLE);
//		if (item.getTitle() != null) {
//			title.setVisibility(VISIBLE);
//			title.setText(item.getTitle());
//		} else {
//			title.setVisibility(GONE);
//		}
//		if (item.getSnippet() != null) {
//			snippet.setVisibility(VISIBLE);
//			snippet.setText(item.getSnippet());
//		} else {
//			snippet.setVisibility(GONE);
//		}
//		
	}
}
