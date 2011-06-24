class Player extends MovieClip
{
	var money; 
	var inventory;
	var score;
	
	function onLoad()
	{
		money = 100;
		inventory = [];
		score = 0;
		Mouse.addListener(this);
	}
	
	function onMouseDown()
	{
		//TODO: Implement checking collision between mouse pointer and animals
		//TODO: Walk toward the animal
		//TODO: Check if you can satisfy animal's needs
	}
	
	function onEnterFrame()
	{
		//Check player clicks
		
		//Print debug information
		showDynamicOutput();
	}
	
	public function addToInventory(produce)	{ inventory.push_back(produce); }
	
	public function updateMoney(amount) { money += amount; }
	public function updateScore(amount) { score += amount; }
	public function showDynamicOutput()
	{
		_root.playerText.text = "";
		_root.playerText.text +="\nMoney: " + money;
		_root.playerText.text +="\nScore: " + score;
		_root.playerText.text +="\nInventory Size: " + inventory.length;
	}
}