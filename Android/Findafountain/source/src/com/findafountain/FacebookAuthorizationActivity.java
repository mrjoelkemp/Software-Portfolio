package com.findafountain;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import com.facebook.android.Facebook.*;
import com.facebook.android.*;
import android.util.Log;
/**
 * Necessary activity for showing Facebook Authorization allowing
 * app access to a user's email and information.
 * @author Joel
 *
 */
public class FacebookAuthorizationActivity extends Activity
{
	private static final String TAG = "FacebookAuthorizationActivity";
	//Facebook login helper with Find a Fountain ID
	private Facebook fb;
	
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
    }

	public void initialize(final Facebook fb)
	{
		this.fb = fb;
		fb.authorize(this, new String[] { "email", "user_about_me"},
			      new DialogListener() {
			           @Override
			           public void onComplete(Bundle values) {}

			           @Override
			           public void onFacebookError(FacebookError error) {
			        	   Log.e(TAG, "onFacebookError: " + error.getMessage());
			           }

			           @Override
			           public void onError(DialogError e) {
			        	   Log.e(TAG, "onError: " + e.getMessage());
			           }

			           @Override
			           public void onCancel() {
			        	   Log.d(TAG, "onCancel: Action Cancelled!");
			           }
			      }
		    	);
	}
	
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        //Set internal data and permissions
        fb.authorizeCallback(requestCode, resultCode, data);
        finishActivity(1);
    }
}
