$(document).ready(function() {
	title = $('.title');
	$('.gallery').on('mouseover',function() {
		console.log(this);
		console.log($(this));
		title.css("text-decoration","underline");
	})
	$('.gallery').on('mouseout',function() {
		title.css("text-decoration","none");
	})
});