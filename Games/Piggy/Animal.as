class Animal extends MovieClip
{
	var foodCost;
	var health;

	/*
	0: Low
	1: Medium
	2: High
	*/
	private var productivityLevel;
	
	/*
	0: Food
	1: Attention
	2: Cleaning
	*/
	private var need;
	/* Keeps track of how long the need hasn't been fulfilled. */
	private var needDuration;
	private var needTimer, needInterval;
	
	/* Array of produce items */
	private var produceList;		/* Num 0-2  generated based on productivityLevel*/
	private var produceValue;	/* List of values for numbers 0-2*/
	/* Used to control event time intervals. */
	private var produceTimer;
	//When counter hits this number, we trigger a produce
	private var produceInterval;
	
	public var produceAttribsObject, needAttribsObject, animalAttribsObject;
	
	public function Animal()
	{
		needAttribsObject = [];
		produceAttribsObject = [];
		animalAttribsObject = [];
		
		produceAttribsObject.productivityLevel = 2;
		produceAttribsObject.produceList = [];
		produceAttribsObject.produceValue = [];
		produceAttribsObject.produceTimer = 0;
		
		needAttribsObject.need = -1;
		needAttribsObject.needTimer = 0;
		needAttribsObject.needDuration = 0;
		
		animalAttribsObject.foodCost = -1;
		animalAttribsObject.health = 300;
	}
	
	//Generate produce based on productivity level and interval
	public static function generateProduce(pAttribs)
	{						
		if(pAttribs.produceTimer >= pAttribs.produceInterval)
		{
			//Generate produce based on productivity level
			pAttribs.produceList.push(pAttribs.productivityLevel);
			//Reset the passed timer
			pAttribs.produceTimer = 0;
		}
	}
	
	//Generate random need 0-2 based on interval
	public static function generateNeed(nAttribs)
	{
		if(nAttribs.needTimer >= nAttribs.needInterval && nAttribs.need == -1)
		{
			nAttribs.need = Math.ceil(Math.random() % 3);			
			//Reset duration
			nAttribs.needDuration = 0;
			nAttribs.needTimer = 0;
		}
	}
	
	//Modifies the animal's productivity level based on the active need duration.
	public static function checkProductivity(nAttribs, pAttribs, aAttribs)
	{
		//If need hasn't been serviced in 5s
		if(nAttribs.needDuration == 150)
			pAttribs.productivityLevel = 1;
		//10s
		else if(nAttribs.needDuration == 300)
			pAttribs.productivityLevel = 0;
		//15s -- start to die
		else if(nAttribs.needDuration >= 450)
			aAttribs.health--;
	}
	
	//Update the animal's attributes and behavior
	public static function updateAnimal(nAttribs, pAttribs, aAttribs)
	{
		//Increment timers
		pAttribs.produceTimer++;
		nAttribs.needTimer++;
		
		//Handle the generation of produce
		generateProduce(pAttribs);
		
		//If you still need something
		if(nAttribs.need != -1)
			nAttribs.needDuration++;
			
		//Handle the generation of a need
		generateNeed(nAttribs);
		
		//Check if productivity should be modified
		checkProductivity(nAttribs, pAttribs, aAttribs);
	}
	
	//Clears the passed in component's text field (pass in _root.com)
	public static function clearDynamicText(com)
	{
		com.text = "";
	}
	
	public static function showDynamicOutput(com, nAttribs, pAttribs, aAttribs)
	{
		//Debug outputs
		com.text += "\nNeed: " + nAttribs.need;
		com.text += "\nNeed Duration: " + nAttribs.needDuration;
		com.text += "\nProduceList Size: " + pAttribs.produceList.length; 
		com.text += "\nProductivityLevel: " + pAttribs.productivityLevel;
		com.text += "\nHealth: " + aAttribs.health;
	}
	
	public function die(xPos,yPos)
	{
		//Show a tombstone
		var tombstone = _root.attachMovie("Tombstone", "Tombstone", _root.getNextHighestDepth(), _root.getNextHighestDepth());
		tombstone._x = xPos;
		tombstone._y = yPos;
		
	}
}