$(document).ready(function() {
	title = $('.title');
	$('.gallery').bind({
		'mouseover': function() {
			$(this).find(title).css("text-decoration","underline");
		},
		'mouseout': function() {
			$(this).find(title).css("text-decoration","none");
		}
	});
	$('.icons').hide();
});
/* on-type
$('.gallery').on('mouseover',function() {
	$(this).find(title).css("text-decoration","underline");
})
$('.gallery').on('mouseout',function() {
	$(this).find(title).css("text-decoration","none");
})
*/