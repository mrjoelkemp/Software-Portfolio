class Chicken extends Animal
{
	function onLoad()
	{
		animalAttribsObject.foodCost = 5;
		produceAttribsObject.produceValue[0] = 15;	/* Death good */
		produceAttribsObject.produceValue[1] = 5;
		produceAttribsObject.produceValue[2] = 5;
		produceAttribsObject.produceInterval = 150;	//5s
		needAttribsObject.needInterval = 90;		//3s
	}
	
	function onEnterFrame()
	{
		if(animalAttribsObject.health)
		{
			clearDynamicText(_root.chickenText);
			updateAnimal(needAttribsObject, produceAttribsObject, animalAttribsObject);
			showDynamicOutput(_root.chickenText, needAttribsObject, produceAttribsObject, animalAttribsObject);
		}
		if(animalAttribsObject.health <= 0)
		{
			clearDynamicText(_root.chickenText);
			die(_x,_y);
			this.removeMovieClip();
		}
	}
}