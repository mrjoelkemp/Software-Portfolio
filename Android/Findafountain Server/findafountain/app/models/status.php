<?php
class Status extends AppModel {
	var $name = 'Status';
	var $useTable = 'statuses';
	//var $hasMany = array('Fountain');
	var $hasMany = array(
        'Fountain' => array(
            'className'     => 'Fountain',
            'foreignKey'    => 'status_id'
        )
    );

}
?>