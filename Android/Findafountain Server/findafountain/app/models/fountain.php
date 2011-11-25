<?php
class Fountain extends AppModel {
	var $name = 'Fountain';	
	           
    var $belongsTo = array(
		'Status' => array(
            'className'     => 'Status',
            'foreignKey'    => 'status_id'
        )
	);
}
?>