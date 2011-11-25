<?php
class FountainsController extends AppController {

	var $name = 'Fountains';
	var $components = array('RequestHandler', 'Api');
	var $helpers = array('Javascript');
	
	//Whether or not the API key supplied is valid
	var $isAPIKeyCorrect = false;
	function beforeFilter()
	{
		//Respond in the fashion indicated by the passed extension (xml or json)
		$this->RequestHandler->respondAs($this->params['url']['ext']);
		
		//If the apikey has been supplied in the URL and is a valid API key
		if(isset($this->params['url']['apikey']) && $this->Api->getAPIKey() == $this->params['url']['apikey'])
			//Set the flag to allow actions to take place
			$this->isAPIKeyCorrect = true;
	}
	
	function index() 
	{
		//If the passed API key is our own key
		if($this->isAPIKeyCorrect)
		{
			//Grab one level of assocations
			$this->Fountain->recursive = 0;
			//echo Debugger::dump($this->params['url']);
			
			$fountains = $this->Fountain->find('all');

			//Fetch all of the users
			$this->set('fountains', $fountains);
		}
		//Otherwise, the apikey is bad
		else
		{
			//$this->set('status', '401 Unauthorized');
			$this->set('fountains', array());
		}	
	}

	function view($id = null) 
	{
		if($this->isAPIKeyCorrect)
		{			
			$this->set('fountain', $this->Fountain->read(null, $id));
			//$this->set('status', '200 OK');
		}
		//Otherwise, the apikey is bad
		else
		{
			//$this->set('status', '401 Unauthorized');
			$this->set('fountain', array());
		}	
	}

	function add() 
	{
		if($this->isAPIKeyCorrect)
			if (!empty($this->data)) 
			{
				$data = array();
				//If the posted data is in XML format
				if($this->params['url']['ext'] == 'xml')
					//Parse the XML Object into an array
					$data = Set::reverse($this->data);
				//Otherwise it's in JSON format
				else
					$data = json_decode($this->data);
				
				//Create a fountain model to use the save method
				$this->Fountain->create();
				//If it's possible to save the data
				if ($this->Fountain->save($data)) 
					$this->set('status', '201 Created');
				else 
					$this->set('status', '500 Internal Server Error');
			}
		else
			$this->set('status', '401 Unauthorized');
	}

	function edit($id = null) {
		if (!$id && empty($this->data)) {
			$this->flash(sprintf(__('Invalid fountain', true)), array('action' => 'index'));
		}
		if (!empty($this->data)) {
			if ($this->Fountain->save($this->data)) {
				$this->flash(__('The fountain has been saved.', true), array('action' => 'index'));
			} else {
			}
		}
		if (empty($this->data)) {
			$this->data = $this->Fountain->read(null, $id);
		}
	}
/*
	function delete($id = null) {
		if (!$id) {
			$this->flash(sprintf(__('Invalid fountain', true)), array('action' => 'index'));
		}
		if ($this->Fountain->delete($id)) {
			$this->flash(__('Fountain deleted', true), array('action' => 'index'));
		}
		$this->flash(__('Fountain was not deleted', true), array('action' => 'index'));
		$this->redirect(array('action' => 'index'));
	}
	*/
}
?>