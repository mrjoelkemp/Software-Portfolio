package com.findafountain;

import com.facebook.android.DialogError;
import com.facebook.android.Facebook;
import com.facebook.android.FacebookError;
import com.facebook.android.Facebook.DialogListener;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.Editable;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Toast;


/**
 * Singleton representing a balloon overlay that allows a user to supply login information.
 * @author Joel
 */
public class LoginBalloonOverlayView extends FrameLayout 
{
	
	private static LoginBalloonOverlayView instance = null;
	
	/**
	 * Gets a new or reused LoginBalloonOverlayView object.
	 * @param context UI Activity/Context for resource loading and FB login.
	 * @param offset Balloon distance from marker
	 * @param mainHandler Message handler for main UI thread.
	 * @return
	 */
	public static LoginBalloonOverlayView getInstance(Activity context, int offset, final Handler mainHandler)
	{		
		if(instance == null)
			instance = new LoginBalloonOverlayView(context, offset, mainHandler);
		
		return instance;
	}
	
	/**
	 * Handles the view generation and formatting for login.
	 * @param context View context.
	 * @param balloonBottomOffset Distance from the overlay item to display balloon.
	 */
	private LoginBalloonOverlayView(final Activity context, int balloonBottomOffset, final Handler mainHandler)
	{
		super(context);
	
		setPadding(10, 0, 10, balloonBottomOffset);
		LinearLayout layout = new LinearLayout(context);
		layout.setVisibility(VISIBLE);

		//Prepare the layout inflater to inflate the login gui
		LayoutInflater inflater = (LayoutInflater) context
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		
		//Create an inflated view form the login form
		View v = inflater.inflate(R.layout.login, layout);
		
		//Locate the edittext fields
		final EditText username = (EditText) v.findViewById(R.id.login_username);
		
		//The username edittext should be focused
		username.requestFocus();
		
		final EditText password = (EditText) v.findViewById(R.id.login_password);

		//Set up the login ok button
        final Button okButton = (Button) v.findViewById(R.id.login_OK_Button);
        
        okButton.setOnClickListener(new OnClickListener() {
            public void onClick(View v) 
            {
            	boolean result = false;
            
            	//Grab information from textfields
            	String uname = username.getText().toString();
            	String pass = password.getText().toString();
            	
            	
            	
            	//TODO: Perform Authentication here with the Facebook API using uname and pass
            	
            	
            	//Need async thread?
            	
            	Toast.makeText(v.getContext(), "User: " + uname + " Pass: " + pass, Toast.LENGTH_SHORT).show();
            	
            	Message msg = Message.obtain();
            	//If login was successful, send true (1) to main UI
            	if(result)
            		msg.what = 1;
            	//Else send false (0) to the main UI
            	else
            		msg.what = 0;
            	
            	mainHandler.sendMessage(msg);
            }
        });

        //Set up the login cancel button
        final Button cancelButton = (Button) v.findViewById(R.id.login_cancel_Button);     
        cancelButton.setOnClickListener(new OnClickListener() {
            public void onClick(View v) 
            {
            	setVisibility(GONE);
            }
        });
        
        //Set the key listener in case the user presses enter on the keyboard
        password.setOnKeyListener(new OnKeyListener() {
          	@Override
			public boolean onKey(View v, int keyCode, KeyEvent event) {
                // If the event is a key-down event on the "enter" button
                if ((event.getAction() == KeyEvent.ACTION_DOWN) && (keyCode == KeyEvent.KEYCODE_ENTER)) {
                	//Signal the click of the okButton
                	okButton.performClick();
                	return true;
                }
                return false;
            }
        });
        
		FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(
				LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
		params.gravity = Gravity.NO_GRAVITY;

		addView(layout, params);

	}
}
