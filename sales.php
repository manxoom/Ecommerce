<?php

// This file is the sales page. 
// It lists every sales item.




// Include the header file:
$page_title = 'Sale Items';
include ('./includes/header.html');

// Require the database connection:
require ('mysql.inc.php');

// Invoke the stored procedure:
$r = mysqli_query ($dbc, 'CALL select_sale_items(true)');

if (mysqli_num_rows($r) > 0) {
	include ('./views/list_sales.html');
} else {
	include ('./views/noproducts.html');
}

// Include the footer file:
include ('./includes/footer.html');
?>