package com.android.scrimslist;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

public class MainActivity extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        //Create the intent to trigger the PostsListActivity
        //Intent i = new Intent(this, PostsListActivity.class);

        //Create a new thread that will be delayed
        Thread splashThread = new Thread() 
        {
            @Override
            public void run() 
            {
               try 
               {
                  int waited = 0;
                  //Wait for two seconds
                  while (waited < 1000) 
                  {
                     sleep(100);
                     waited += 100;
                  }
               } 
               catch (InterruptedException e) 
               {
                  // do nothing
               } 
               finally 
               {
            	   finish();
		
            	   Intent i = new Intent();
            	   i.setClassName("com.android.scrimslist", "com.android.scrimslist.LoginActivity");
			       startActivity(i);
               }
            }
        };
       
        //Start the newly created thread
        splashThread.start();
    }
}