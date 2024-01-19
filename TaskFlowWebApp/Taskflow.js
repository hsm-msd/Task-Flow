
$(document).ready(function () {
	$('#btn').on('click', function () {
		$('#task-popup').fadeIn();
	});

	$('#submit-btn').on('click', function () {
		// handle form submission
	});
});

$(document).ready(function (e) {
	// Check if the button was clicked
	
	var isButtonClicked = $('#IsButtonClicked').val() === 'true';
	if (isButtonClicked) {
		$('#myModal').modal('show');
	}
});

$("#showTask").click(function (e) {
	e.preventDefault();
	// Code to open the modal goes here
});

//load event for profile image

