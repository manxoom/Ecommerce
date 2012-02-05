<?php

// This file manages the wish list.




// Check for, or create, a user session:
if (isset($_COOKIE['SESSION'])) {
	$uid = $_COOKIE['SESSION'];
} else {
	$uid = md5(uniqid('biped',true));
}

// Send the cookie:
setcookie('SESSION', $uid, time()+(60*60*24*30));

// Include the header file:
$page_title = 'Coffee - Your Wish List';
include ('./includes/header.html');

// Require the database connection:
require ('mysql.inc.php');

// Need the utility functions:
include ('./includes/product_functions.inc.php');

// If there's a SKU value in the URL, break it down into its parts:
if (isset($_GET['sku'])) {
	list($sp_type, $pid) = parse_sku($_GET['sku']);
}

if (isset ($sp_type, $pid, $_GET['action']) && ($_GET['action'] == 'remove') ) { // Remove it from the wish list.
	
	$r = mysqli_query($dbc, "CALL remove_from_wish_list('$uid', '$sp_type', $pid)");

} elseif (isset ($sp_type, $pid, $_GET['action'], $_GET['qty']) && ($_GET['action'] == 'move') ) { // Move it to the wish list.

	// Determine the quantity:
	$qty = (filter_var($_GET['qty'], FILTER_VALIDATE_INT, array('min_range' => 1))) ? $_GET['qty'] : 1;

	// Add it to the wish list:
	$r = mysqli_query($dbc, "CALL add_to_wish_list('$uid', '$sp_type', $pid, $qty)");
	
	// For debugging purposes:
	//if (!$r) echo mysqli_error($dbc);
	
	// Remove it from the cart:
	$r = mysqli_query($dbc, "CALL remove_from_cart('$uid', '$sp_type', $pid)");
	
	// For debugging purposes:
	//if (!$r) echo mysqli_error($dbc);

} elseif (isset($_POST['quantity'])) { // Update quantities in the wish list.
	
	// Loop through each item:
	foreach ($_POST['quantity'] as $sku => $qty) {
		
		// Parse the SKU:
		list($sp_type, $pid) = parse_sku($sku);
		
		if (isset($sp_type, $pid)) {

			// Determine the quantity:
			$qty = (filter_var($qty, FILTER_VALIDATE_INT, array('min_range' => 0)) !== false) ? $qty : 1;

			// Update the quantity in the wish list:
			$r = mysqli_query($dbc, "CALL update_wish_list('$uid', '$sp_type', $pid, $qty)");

			}

		} // End of FOREACH loop.
	
}// End of main IF.
		
// Get the wish list contents:
$r = mysqli_query($dbc, "CALL get_wish_list_contents('$uid')");

if (mysqli_num_rows($r) > 0)  // Products to show!
	include ('./views/wishlist.html');
 else { // Empty cart!
	include ('./views/emptylist.html');
}

// Finish the page:
include ('./includes/footer.html');
?>
