class Cow extends Animal
{
	function onLoad()
	{
		animalAttribsObject.foodCost = 15;
		produceAttribsObject.produceValue[0] = 20;	/* Death good */
		produceAttribsObject.produceValue[1] = 10;
		produceAttribsObject.produceValue[2] = 10;
		produceAttribsObject.produceInterval = 450;	//15s
		needAttribsObject.needInterval = 300;		//10s
	}
	
	function onEnterFrame()
	{
		if(animalAttribsObject.health)
		{
			clearDynamicText(_root.cowText);
			updateAnimal(needAttribsObject, produceAttribsObject, animalAttribsObject);
			showDynamicOutput(_root.cowText, needAttribsObject, produceAttribsObject, animalAttribsObject);
		}
		if(animalAttribsObject.health <= 0)
		{
			clearDynamicText(_root.cowText);
			die(_x,_y);
			this.removeMovieClip();
		}
	}
}