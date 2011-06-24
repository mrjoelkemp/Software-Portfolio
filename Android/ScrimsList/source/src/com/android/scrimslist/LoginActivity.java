package com.android.scrimslist;
import android.app.Activity;
import android.app.ListActivity;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.SimpleCursorAdapter;

public class LoginActivity extends Activity
{
	private DBAdapter dbAdapter;
	
	@Override
	public void onCreate(Bundle savedInstanceState) 
	{
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login);
        
        //Set up the login button
        final Button loginButton = (Button) findViewById(R.id.login_Button);
        loginButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) 
            {
            	//TODO: Perform Authentication here with dbAdapter
            	
            	//Open the PostsList Activity
                Intent i = new Intent();
                i.setClassName("com.android.scrimslist", "com.android.scrimslist.PostsListActivity");
                startActivity(i);
            }
        });
        
        //Set up the register button
        final Button registerButton = (Button) findViewById(R.id.register_Button);
        registerButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) 
            {
            	//Open the Register Activity
            	Intent i = new Intent();
                i.setClassName("com.android.scrimslist", "com.android.scrimslist.RegisterActivity");
                startActivity(i);
            }
        });
	}
}
