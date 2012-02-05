<?php

// This script defines functions used by the catalog.


// Function for indicating the availability.
// Takes one argument, the stock as an integer.
// Returns a string.
function get_stock_status($stock) {
	
	if ($stock > 5) { // Plenty!
		return 'In Stock';
	} elseif ($stock > 0) { // Low!
		return 'Low Stock';
	} else { // Out!
		return 'Currently Out of Stock';
	}
	
} // End of get_stock_status() function.

// Function for indicating the price.
// Takes into account the potential sales price.
// Takes three arguments: the product type, the regular price, and the sale price.
// Returns a string.
function get_price($type, $regular, $sales) {
	
	// Prices are handled different based upon the product type:
	if ($type == 'coffee') {
		
		// Only add the sale price if it's greater than 0 
		// and less than the regular price:
		if ((0 < $sales) && ($sales < $regular)) {
			return ' Sale: $' . $sales . '!';
		}
		
	} elseif ($type == 'goodies') {
		
		// Display the sale price if it's greater than 0
		// and less than the regular price:
		if ((0 < $sales) && ($sales < $regular)) {
			return "<strong>Sale Price:</strong> \$$sales! (normally \$$regular)<br />";
		} else {
			// Otherwise, display the regular price:
			return '<strong>Price:</strong> $' . $regular . '<br />';			
		}		
		
	}
	
} // End of get_price() function.

// Function for indicating the price.
// Takes into account the potential sales price.
// Takes two arguments: the regular price and the sale price.
// Returns a float.
function get_just_price($regular, $sales) {
	
	// Return the sale price, when appropriate:
	if ((0 < $sales) && ($sales < $regular)) {
		return number_format($sales, 2);
	} else {
		return number_format($regular, 2);
	}
	
} // End of get_just_price() fucntion.

// Function for parsing a SKU.
// Takes one argument: the SKU (such as C390 or O28).
// Returns an array.
function parse_sku($sku) {
	
	// Grab the first character:
	$type_abbr = substr($sku, 0, 1);
	
	// Grab the remaining characters:
	$pid = substr($sku, 1);	
	
	// Validate the type:
	if ($type_abbr == 'C') {
		$sp_type = 'coffee';
	} elseif ($type_abbr == 'O') {
		$sp_type = 'other';
	} else {
		$sp_type = NULL;
	}
	
	// Validate the product ID:
	$pid = (filter_var($pid, FILTER_VALIDATE_INT, array('min_range' => 1))) ? $pid : NULL;
	
	// Return the values:
	return array($sp_type, $pid);

} // End of parse_sku() function.

// Function for calculating the shipping and handling.
// Takes one argument: the current order total.
// Returns a float.
function get_shipping($total = 0) {
	
	// Set the base handling charges:
	$shipping = 3;
	
	// Rate is based upon the total:
	if ($total < 10) {
		$rate = .25;
	} elseif ($total < 20) {
		$rate = .20;
	} elseif ($total < 50) {
		$rate = .18;
	} elseif ($total < 100) {
		$rate = .16;
	} else {
		$rate = .15;
	}
	
	// Calculate the shipping total:
	$shipping = $shipping + ($total * $rate);

	// Return the shipping total:
	return number_format($shipping, 2);
	
} // End of get_shipping() function.
