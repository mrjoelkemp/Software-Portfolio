class Customer extends MovieClip
{
	var patience;
	var wants;	/* Array of items (numbers 0-2) */
	var waitingTime;
	
	function onLoad()
	{
		patience = 5;
		waitingTime = 0;
		wants = [];
	}
	
	function onEnterFrame()
	{
		//If your needs haven't been satisfied
		if(wants.length)
		{
			//Increase waiting time
			waitingTime++;			
			//Update patience every 5 s
			if(waitingTime % 150 == 0)
				patience--;
				
			if(patience == 0)
			{
				this.removeMovieClip();
				//Update player rating
				//Update player score
			}
		}
		
		showDynamicOutput();
	}
	
	function showDynamicOutput()
	{
		_root.customerText.text = "";
		_root.customerText.text += "\nPatience Level: " + patience;
		_root.customerText.text += "\nWaiting Time: " + waitingTime;
		var wantLength = wants.length;
		_root.customerText.text +="\nWantsList Length: "+wantLength;
		for(var i=0; i<wantLength; i++)
			_root.customerText.text +="\nWant: " + wants[i];
	}
}