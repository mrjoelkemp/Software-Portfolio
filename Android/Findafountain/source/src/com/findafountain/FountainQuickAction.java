package com.findafountain;

import net.londatiga.android.ActionItem;
import net.londatiga.android.QuickAction;
import android.content.Context;
import android.view.View;
import android.view.View.OnClickListener;

public class FountainQuickAction extends QuickAction
{
	public FountainQuickAction(Context c, View anchor)
	{
		super(anchor);
		final ActionItem rate = new ActionItem();
		 
		rate.setTitle("Rate");
		rate.setIcon(c.getResources().getDrawable(R.drawable.droplet_action));
		rate.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//TODO: Implement rate quickaction
				//Open up rate dialog 
				//Rate diaglog has the droplets
				//TODO: Implement haptic feedback on click
				dismiss();
			}
		});	
		 
		final ActionItem status = new ActionItem();
		status.setTitle("Status");
		status.setIcon(c.getResources().getDrawable(R.drawable.report));
		status.setOnClickListener(new OnClickListener() {
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
		final ActionItem report = new ActionItem();
		 
		report.setTitle("Report");
		report.setIcon(c.getResources().getDrawable(R.drawable.report));
		report.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//TODO: Implement Report QuickAction
				//TODO: Implement haptic feedback on click
				dismiss();
			}
		});
		
		addActionItem(rate);
		addActionItem(status);
		
		addActionItem(report);
		setAnimStyle(QuickAction.ANIM_GROW_FROM_CENTER);
	}

}
