<?php echo $xml->header(); ?>
<fountains>
  <status><?php echo $status; ?></status>
  <?php echo $xml->serialize($fountains); ?>
</fountains>