class BG extends MovieClip
{
	function onLoad()
	{
		//Create player?
		
		//Create animals
		var pig = _root.attachMovie("Pig", "Pig", _root.getNextHighestDepth(), _root.getNextHighestDepth());
		pig._x = 72;
		pig._y = 135;
		
		var chicken = _root.attachMovie("Chicken", "Chicken", _root.getNextHighestDepth(), _root.getNextHighestDepth());
		chicken._x = 256;
		chicken._y = 133;
		
		var cow = _root.attachMovie("Cow", "Cow", _root.getNextHighestDepth(), _root.getNextHighestDepth());
		cow._x =440;
		cow._y =125;
		
		var customer = _root.attachMovie("Customer","Customer", _root.getNextHighestDepth(), _root.getNextHighestDepth());
		customer._x = 253;
		customer._y = 445;
	}
	
}