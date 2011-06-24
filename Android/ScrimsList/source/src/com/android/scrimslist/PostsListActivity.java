package com.android.scrimslist;
import android.app.ListActivity;
import android.database.Cursor;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.widget.ArrayAdapter;
import android.widget.SimpleCursorAdapter;

public class PostsListActivity extends ListActivity
{
	private DBAdapter dbAdapter;
	
	@Override
	public void onCreate(Bundle savedInstanceState) 
	{
        super.onCreate(savedInstanceState);
        setContentView(R.layout.scrim_list);
        
        //fillScrimData();
        
        //TEST DATA
        String[] items = new String[] {"Foo", "Bar", "Fizz", "Bin"};
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, R.layout.scrim_row, R.id.scrim_text, items);
        setListAdapter(adapter);
	}

	private void fillScrimData()
	{
		Cursor scrimsCursor = dbAdapter.fetchAllScrims();
        startManagingCursor(scrimsCursor);
        
        // Create an array to specify the fields we want to display in the list (only TITLE)
        String[] from = new String[]{DBAdapter.KEY_TITLE};
        
        // and an array of the fields we want to bind those fields to (in this case just text1)
        int[] to = new int[]{R.id.scrim_text};
        
        // Now create a simple cursor adapter and set it to display
        SimpleCursorAdapter scrims = new SimpleCursorAdapter(this, R.layout.scrim_row, scrimsCursor, from, to);
        setListAdapter(scrims);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) 
	{
		super.onCreateOptionsMenu(menu);
		MenuInflater mi = getMenuInflater();
		//Create the menu identified in the scrim_list_menu xml file.
		mi.inflate(R.menu.scrim_list_menu, menu);
		return true;
	}
	
	@Override
	public boolean onMenuItemSelected(int featureId, MenuItem item) 
	{
		switch(item.getItemId()) 
		{ 
			case R.id.scrim_menu_refresh: 
				return true; 
			case R.id.scrim_menu_filter:
				return true;
			case R.id.scrim_menu_insert:
				return true;
		}
		return super.onMenuItemSelected(featureId, item);
	}
}
