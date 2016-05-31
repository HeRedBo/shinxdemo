<?php

//
// $Id: test.php 2055 2009-11-06 23:09:58Z shodan $
//

require ( "sphinxapi.php" );
$sc  = new SphinxClient();
$sc -> setServer('localhost',9312);
$res = $sc->query('Android');
echo "<pre/>";
print_r($res);