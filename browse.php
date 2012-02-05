<?php

// This file lists products in a specific category



// Validate the required values:
$type = $sp_type = $sp_cat = $category = false;
if (isset($_GET['type'], $_GET['category'], $_GET['id']) && filter_var($_GET['id'], FILTER_VALIDATE_INT, array('min_range' => 1))) {
	
	// Make the associations:
	$category = $_GET['category'];
	$sp_cat = $_GET['id'];
	
	// Validate the type:
	if ($_GET['type'] == 'goodies') {
		
		$sp_type = 'other';
		$type = 'goodies';
		
	} elseif ($_GET['type'] == 'coffee') {
		
		$type = $sp_type = 'coffee';	
		
	}

}

// If there's a problem, display the error page:
if (!$type || !$sp_type || !$sp_cat || !$category) {
	$page_title = 'Error!';
	include ('./includes/header.html');
	include ('./views/error.html');
	include ('./includes/footer.html');
	exit();
}

// Create a page title:
$page_title = ucfirst($type) . ' to Buy::' . $category;

// Include the header file:
include ('./includes/header.html');

// Require the database connection:
require ('mysql.inc.php');

// Call the stored procedure:
$r = mysqli_query($dbc, "CALL select_products('$sp_type', $sp_cat)");

// For debugging purposes:
if (!$r) echo mysqli_error($dbc);

// If records were returned, include the view file:
if (mysqli_num_rows($r) > 0) {
	if ($type == 'goodies') {
	
		include ('./views/list_products3.html');
	} elseif ($type == 'coffee') {
		include ('./views/list_coffees2.html');
	}
} else { // Include the "noproducts" page:
	include ('./views/noproducts.html');
}

// Include the footer file:
include ('./includes/footer.html');
?>