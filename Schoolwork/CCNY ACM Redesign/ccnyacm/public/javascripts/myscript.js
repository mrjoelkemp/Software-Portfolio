/**
 * @author Joel Kemp
 */

function makeVisible(divId)
{	
		//TODO: Include a call to Effect.Slider to make the overlay slide out -- need to import scriptaculous libraries.
	//if(document.getElementById(divId).style.visibility == "hidden")
	if(document.getElementById(divId).style.display == "none")
	
	{
		//new Effects.Appear(divId);
		
		//document.write("I'm hidden you dumbass");
		//document.getElementById(divId).style.visibility = "visible";
		document.getElementById(divId).style.display = "inline";
		new Effect.Appear(divId);
		
	}
	//else if(document.getElementById(divId).style.visibility == "visible")
	else if(document.getElementById(divId).style.display == "inline")
	
	{
		//document.write("I'm visible you dumbass");
		//document.getElementById(divId).style.visibility = "hidden";
		document.getElementById(divId).style.display = "none";
	}
}