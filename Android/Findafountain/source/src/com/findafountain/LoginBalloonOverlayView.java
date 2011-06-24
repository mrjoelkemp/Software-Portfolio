package com.findafountain;

import android.content.Context;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.readystatesoftware.mapviewballoons.R;

//Purpose: Represents a balloon overlay that allows a user to supply login information.
public class LoginBalloonOverlayView extends FrameLayout 
{
	private LinearLayout layout;

	//Purpose: Handles the view generation and formatting for login.
	public LoginBalloonOverlayView(Context context, int balloonBottomOffset)
	{
		super(context);
	
		setPadding(10, 0, 10, balloonBottomOffset);
		layout = new LinearLayout(context);
		layout.setVisibility(VISIBLE);

		//Prepare the layout inflater to inflate the login gui
		LayoutInflater inflater = (LayoutInflater) context
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		
		//Create an inflated view form the login form
		View v = inflater.inflate(R.layout.login, layout);
		
		//title = (TextView) v.findViewById(R.id.balloon_item_title);
		//snippet = (TextView) v.findViewById(R.id.balloon_item_snippet);

        //Set up the login button
        final Button loginButton = (Button) findViewById(R.id.login_Button);
        loginButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) 
            {
            	//TODO: Perform Authentication here with the Facebook API
            	Toast.makeText(v.getContext(), "Login Coming Soon!", Toast.LENGTH_SHORT).show();
            }
        });

		ImageView close = (ImageView) v.findViewById(R.id.close_img_button);
		close.setOnClickListener(new OnClickListener() {
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
//		public void setData(Item item) {
//			
//			layout.setVisibility(VISIBLE);
//			if (item.getTitle() != null) {
//				title.setVisibility(VISIBLE);
//				title.setText(item.getTitle());
//			} else {
//				title.setVisibility(GONE);
//			}
//			if (item.getSnippet() != null) {
//				snippet.setVisibility(VISIBLE);
//				snippet.setText(item.getSnippet());
//			} else {
//				snippet.setVisibility(GONE);
//			}
//			
//		}

}
