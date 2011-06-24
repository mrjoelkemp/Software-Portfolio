class Pig extends Animal
{	
	function onLoad()
	{
		animalAttribsObject.foodCost = 10;
		produceAttribsObject.produceValue[0] = 15;	/* Death good */
		produceAttribsObject.produceValue[1] = 5;
		produceAttribsObject.produceValue[2] = 5;
		produceAttribsObject.produceInterval = 300;	//5s
		needAttribsObject.needInterval = 150;		//5s
	}
	
	function onEnterFrame()
	{
		if(animalAttribsObject.health > 0)
		{
			//Clear pigText
			clearDynamicText(_root.pigText);
			//Update animal's needs, produce, and health accordingly.
			updateAnimal(needAttribsObject, produceAttribsObject, animalAttribsObject);
			showDynamicOutput(_root.pigText, needAttribsObject, produceAttribsObject, animalAttribsObject);
		}
		else if(animalAttribsObject.health <= 0)
		{
			clearDynamicText(_root.pigText);
			die(_x,_y);
			this.removeMovieClip();
		}
	}
}