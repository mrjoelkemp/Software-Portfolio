package com.android.scrimslist;
import android.app.Activity;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class RegisterActivity extends Activity
{
	private DBAdapter dbAdapter;
	
	@Override
	public void onCreate(Bundle savedInstanceState) 
	{
        super.onCreate(savedInstanceState);
        setContentView(R.layout.register);
        
        //Set up the login button
        final Button loginButton = (Button) findViewById(R.id.register_create_account_button);
        loginButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) 
            {            	
            	//Validate data
            	//Ask the user to confirm registration
            	//If user confirms
            		//Save the data to the database using dbAdapter
            }
        });
     
	}
}
