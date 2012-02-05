<?php

include ('/includes/header.html');

include('/views/cform.html');



// Check for form submission:
if (isset($_POST['submit'])) {

	// Minimal form validation:
	if (!empty($_POST['name']) && !empty($_POST['email']) && !empty($_POST['comments']) ) {
	
		
		
		// Print a message:
		echo '<p><em>Thank you for contacting me. I will reply some day.</em></p>';
		
		// Clear $_POST,if the mail was sent, there’s no need to show the values in the form again.
		//To avoid that, the $_POST array can be cleared of its values using the array() function.
		$_POST = array();
	
	} else {
		echo '<p style="font-weight: bold; color: #C00">Please fill out the form completely.</p>';
	}
	
} // End of main isset() IF.
include ('/includes/footer.html');

?>