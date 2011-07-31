package com.findafountain;

import android.content.Context;
import android.view.View;
import android.view.View.OnClickListener;
import net.londatiga.android.ActionItem;
import net.londatiga.android.QuickAction;

public class FilterQuickAction  extends QuickAction
{
	public FilterQuickAction(Context c, View anchor)
	{
		super(anchor);
		final ActionItem all = new ActionItem();
		 
		all.setTitle("All");
		all.setIcon(c.getResources().getDrawable(R.drawable.droplet_action));
		all.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//TODO: Implement rate quickaction
				//Open up rate dialog 
				//Rate diaglog has the droplets
				//TODO: Implement haptic feedback on click
				dismiss();
			}
		});	
		 
		final ActionItem drinkable = new ActionItem();
		drinkable.setTitle("Drinkable");
		drinkable.setIcon(c.getResources().getDrawable(R.drawable.report));
		drinkable.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//TODO: Implement Status QuickAction
				//TODO: Implement haptic feedback on click
				dismiss();
			}
		});
		
		//Handles sending an email to the department of parks and recreation
		//TODO: Only make this active if the status is broken
		//TODO: Prefill the email form with the user's email, a subject, and a body
		//TODO: Create an intent to the mail application to submit the mail
		//TODO: Abstract into its own class
		final ActionItem pending = new ActionItem();
		 
		pending.setTitle("Pending");
		pending.setIcon(c.getResources().getDrawable(R.drawable.report));
		pending.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//TODO: Implement Report QuickAction
				//TODO: Implement haptic feedback on click
				dismiss();
			}
		});
		
		final ActionItem broken = new ActionItem();
		 
		broken.setTitle("Pending");
		broken.setIcon(c.getResources().getDrawable(R.drawable.report));
		broken.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//TODO: Implement Report QuickAction
				//TODO: Implement haptic feedback on click
				dismiss();
			}
		});
		
		addActionItem(all);
		addActionItem(drinkable);
		addActionItem(pending);
		addActionItem(broken);
		
		setAnimStyle(QuickAction.ANIM_GROW_FROM_CENTER);
	}

}
