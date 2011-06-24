package com.findafountain;

import android.content.Context;
import android.os.Handler;
import android.os.Message;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;
import android.widget.Toast;
import com.markupartist.android.widget.ActionBar;
import com.markupartist.android.widget.ActionBar.AbstractAction;

//Purpose: Represents an action bar that lives at the top of the main activity and triggers
//	asynchronous get requests and other actions.
public class MyActionBar extends ActionBar
{
	private static final String TAG = "MyActionBar";
	//private ActionBar actionBar;
	//The context of the calling view
	private Context context;
	private DBAdapter db;
	
	//Public enumeration of the available actions
	public final class Actions{
		public static final int ADD = 1;
		public static final int FILTER = 2;
		public static final int REFRESH = 3;
		public static final int MY_LOCATION = 4;
	}
	
	//Handles messages coming from the async task
	private Handler asyncHandler;
	
	//Caller's message handler
	private Handler mapHandler;
	
	//Whether or not we can start an async task.
	//This regulates the number of active tasks.
	private boolean canStartTask;
	
	//Purpose: Constructor that sets up an async task and action bar actions
	public MyActionBar(Context context, AttributeSet attrs)
	{
		//Since we're inflating from an xml file, we need to pass the 
		//	xml attributes to the super constructor
		super(context, attrs);
		this.context = context;
		
	}//end constructor
	
	//Purpose: Sets up the handled actions.
	//Notes: mapHandler is final due to necessary access within asyncHandler
	public void Initialize(DBAdapter db, final Handler mapHandler)
	{
		//this.mainActivity = mainActivity;
		this.db = db;
		this.mapHandler = mapHandler;
		
		//We have no task yet, so it's okay to start one.
		canStartTask = true;
		this.setTitle(R.string.app_name);
		
		//Initialize progress to exist but be invisible
		this.setProgressBarVisibility(View.GONE);
		this.addAction(new AddFountainAction());
		this.addAction(new FilterAction());
		this.addAction(new RefreshAction());
		this.addAction(new MyLocationAction());
		
		//Handles messages from the GetFountainsAsyncTask
		asyncHandler = new Handler()
		{
			public void handleMessage(Message msg) 
			{
				super.handleMessage(msg);
				switch (msg.what) 
				{
					//The async task finished, so kill the progress visibility
					case Actions.REFRESH:
						if(getProgressBarVisibility() == View.VISIBLE)
							setProgressBarVisibility(View.GONE);
						
						//Send a message to the main UI to let them know that the task finished
						Message msg2 = Message.obtain();
						msg2.what = Actions.REFRESH;
						mapHandler.sendMessage(msg2);
						
						canStartTask = true;
						Log.d(TAG, "handleMessage: Refresh Action - Async Task Finished!");
						break;						
				}
			}
		};	
		Log.d(TAG, "Action bar Initialized.");
		
	}
	
	//Purpose: Represents an action to add fountains to the map
    public class AddFountainAction extends AbstractAction {

        public AddFountainAction() {
            super(R.drawable.menu_add);
        }

        @Override
        public void performAction(View view) {
        	Toast.makeText(context, "Sit tight! I need to sleep too!", Toast.LENGTH_SHORT).show();
        	Log.d(TAG,"AddFountainAction: Pressed!");
        }
    }

    //Purpose: Represents an action to perform an async get request.
    public class RefreshAction extends AbstractAction{
    	public RefreshAction() 
    	{
            super(R.drawable.menu_refresh);
        }

        @Override
        public void performAction(View view) 
        {
        	//If we are allowed to start another async task.
        	if(canStartTask)
        	{
        		//Prevent another async task from starting
        		canStartTask = false;
        		
        		if(getProgressBarVisibility() == View.GONE)
					setProgressBarVisibility(View.VISIBLE);
        		
	        	//Perform a async rest get to grab all fountain locations
        		//Note: We don't send a message to the main UI just yet.
        		//	We have to wait until the async task notifies us of its completion.
        		//	The notification comes to our asynchandler.
	        	new GetFountainsAsyncTask(context, db, asyncHandler).execute("fountains/index.json");
	        	Log.d(TAG, "RefreshAction: Async Task Started...");
        	}
        	else
        	{
        		Toast.makeText(context, "Still working!", Toast.LENGTH_SHORT).show();
        		Log.d(TAG, "RefreshAction: Duplicate Prevented.");
        	}
        }
    }
    
    public class MyLocationAction extends AbstractAction{
    	public MyLocationAction() 
    	{
            super(R.drawable.menu_mylocation);
        }

        @Override
        public void performAction(View view) 
        {
        	//Pack a message to send to the main UI
        	Message msg = Message.obtain();
        	msg.what = Actions.MY_LOCATION;
        	mapHandler.sendMessage(msg);
        	Log.d(TAG, "MyLocationAction: My Location Message sent to main UI.");
        	
        }
    }
    
    //Purpose: Represents an action to filter the drawn overlay lists
    public class FilterAction extends AbstractAction {

        public FilterAction() {
            super(R.drawable.menu_filter);
        }

        @Override
        public void performAction(View view) 
        {	
          	//Notify the main UI that we want to filter the fountains
        	Message msg = Message.obtain();
        	msg.what = Actions.FILTER;
        	mapHandler.sendMessage(msg);
        	Log.d(TAG,"FilterAction: Filter Message sent to main UI.");
        }
    }    
}
