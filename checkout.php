<?php

// This file is the first step in the checkout process.
// It takes and validates the shipping information.


// Check for the user's session ID, to retrieve the cart contents:
if ($_SERVER['REQUEST_METHOD'] == 'GET') {
	if (isset($_GET['session'])) {
		$uid = $_GET['session'];
		// Use the existing user ID:
		session_id($uid);
		// Start the session:
		session_start();
	} else { // Redirect the user.
		$location = '/ecomCL/cart.php';
		header("Location: $location");
		exit();
	}
} else { // POST request.
	session_start();
	$uid = session_id();
}

// Create an actual session for the checkout process...

// Require the database connection:
require ('mysql.inc.php');

// Validate the checkout form...

// For storing errors:
$shipping_errors = array();

// Check for a form submission:
if ($_SERVER['REQUEST_METHOD'] == 'POST') {

	// Check for Magic Quotes:
	if (get_magic_quotes_gpc()) {
		$_POST['first_name'] = stripslashes($_POST['first_name']);
		// Repeat for other variables that could be affected.
	}

	// Check for a first name:
	if (preg_match ('/^[A-Z \'.-]{2,20}$/i', $_POST['first_name'])) {
		$fn = addslashes($_POST['first_name']);
	} else {
		$shipping_errors['first_name'] = 'Please enter your first name!';
	}
	
	// Check for a last name:
	if (preg_match ('/^[A-Z \'.-]{2,40}$/i', $_POST['last_name'])) {
		$ln  = addslashes($_POST['last_name']);
	} else {
		$shipping_errors['last_name'] = 'Please enter your last name!';
	}
	
	// Check for a street address:
	if (preg_match ('/^[A-Z0-9 \',.#-]{2,80}$/i', $_POST['address1'])) {
		$a1  = addslashes($_POST['address1']);
	} else {
		$shipping_errors['address1'] = 'Please enter your street address!';
	}
	
	// Check for a second street address:
	if (empty($_POST['address2'])) {
		$a2 = NULL;
	} elseif (preg_match ('/^[A-Z0-9 \',.#-]{2,80}$/i', $_POST['address2'])) {
		$a2 = addslashes($_POST['address2']);
	} else {
		$shipping_errors['address2'] = 'Please enter your street address!';
	}
	
	// Check for a city:
	if (preg_match ('/^[A-Z \'.-]{2,60}$/i', $_POST['city'])) {
		$c = addslashes($_POST['city']);
	} else {
		$shipping_errors['city'] = 'Please enter your city!';
	}
	
	// Check for a state:
	if (preg_match ('/^[A-Z]{2}$/', $_POST['state'])) {
		$s = $_POST['state'];
	} else {
		$shipping_errors['state'] = 'Please enter your state!';
	}
	
	// Check for a zip code:
	if (preg_match ('/^(\d{5}$)|(^\d{5}-\d{4})$/', $_POST['zip'])) {
		$z = $_POST['zip'];
	} else {
		$shipping_errors['zip'] = 'Please enter your zip code!';
	}
	
	// Check for a phone number:
	// Strip out spaces, hyphens, and parentheses:
	$phone = str_replace(array(' ', '-', '(', ')'), '', $_POST['phone']);
	if (preg_match ('/^[0-9]{10}$/', $phone)) {
		$p  = $phone;
	} else {
		$shipping_errors['phone'] = 'Please enter your phone number!';
	}
	
	// Check for an email address:
	if (filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
		$e = $_POST['email'];
		$_SESSION['email'] = $_POST['email'];
	} else {
		$shipping_errors['email'] = 'Please enter a valid email address!';
	}
	
	// Check if the shipping address is the billing address:
	if (isset($_POST['use']) && ($_POST['use'] == 'Y')) {
		$_SESSION['shipping_for_billing'] = true;
		$_SESSION['cc_first_name']  = $_POST['first_name'];
		$_SESSION['cc_last_name']  = $_POST['last_name'];
		$_SESSION['cc_address']  = $_POST['address1'] . ' ' . $_POST['address2'];
		$_SESSION['cc_city'] = $_POST['city'];
		$_SESSION['cc_state'] = $_POST['state'];
		$_SESSION['cc_zip'] = $_POST['zip'];
	}

	if (empty($shipping_errors)) { // If everything's OK...
		
		// Add the user to the database...
		
		// Call the stored procedure:
		$r = mysqli_query($dbc, "CALL add_customer('$e', '$fn', '$ln', '$a1', '$a2', '$c', '$s', $z, $p, @cid)");

		// Confirm that it worked:
		if ($r) {
		
			// Retrieve the customer ID:
			$r = mysqli_query($dbc, 'SELECT @cid');
			if (mysqli_num_rows($r) == 1) {

				list($_SESSION['customer_id']) = mysqli_fetch_array($r);
					
				// Redirect to the next page:
				$location = './views/billing.html';
				header("Location: $location");
				exit();

			}

		}

		// Log the error, send an email, panic!

		trigger_error('Your order could not be processed due to a system error. We apologize for the inconvenience.');

	} // Errors occurred IF.

} // End of REQUEST_METHOD IF.
							
// Include the header file:
$page_title = 'Coffee - Checkout - Your Shipping Information';
include ('./includes/checkout_header.html');

// Get the cart contents:
$r = mysqli_query($dbc, "CALL get_shopping_cart_contents('$uid')");

if (mysqli_num_rows($r) > 0) { // Products to show!
	include ('./views/checkout.html');
} else { // Empty cart!
	include ('./views/emptycart.html');
}

// Finish the page:
include ('./includes/footer.html');
?>