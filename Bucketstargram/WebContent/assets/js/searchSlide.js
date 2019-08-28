$(document).ready(function() {
	var libSlider = $('.libSlider').bxSlider({
	    mode: 'horizontal', //가로 방향 수평 슬라이드
	    pause: 10000,
	    speed: 500, // 이동속도
	    pager: false, //현재위치 페이징 표시여부
	    moveSlides: 5,//슬라이드 이동 갯수
	    slideWidth: 350,//슬라이드 너비
	    minSlides: 5,// 최소 노출 개수
	    maxSlides: 5,// 최대 노출 개수
	    slideMargin: 5,// 슬라이드 간격
	    auto: true,// 자동 실행
	    autoHover: true,// 마우스 호버, 정지여부(슬라이드에 마우스가 들어오면 슬라이드정지)
	    nextText :'<i class="fas fa-chevron-right"></i>',
	    prevText :'<i class="fas fa-chevron-left"></i>',
	    touchEnabled : false, // 터치 이벤트 disabled
	    onSlideBefore: function() { // 전환 직전에 호출
		    $(".bx-prev").hide(); // 연속클릭으로 인한 슬라이드 넘어가는 것 방지
		    $(".bx-next").hide();
	    },
	    onSlideAfter: function() { // 슬라이드 전환 후 호출
		    $(".bx-prev").show();
		    $(".bx-next").show();
	    	libSlider.stopAuto();
	    	libSlider.startAuto();
	    	console.log(libSlider.getCurrentSlide());
	    },
	})
	var bucketSlider = $('.bucketSlider').bxSlider({
	    mode: 'horizontal', //가로 방향 수평 슬라이드
	    pause: 10000,
	    speed: 500, // 이동속도
	    pager: false, //현재위치 페이징 표시여부
	    moveSlides: 5,//슬라이드 이동 갯수
	    slideWidth: 350,//슬라이드 너비
	    minSlides: 5,// 최소 노출 개수
	    maxSlides: 5,// 최대 노출 개수
	    slideMargin: 5,// 슬라이드 간격
	    auto: true,// 자동 실행
	    autoHover: true,// 마우스 호버, 정지여부
	    touchEnabled : false, // 터치 이벤트 disabled
	    nextText :'<i class="fas fa-chevron-right"></i>',
	    prevText :'<i class="fas fa-chevron-left"></i>',
	    onSlideBefore: function() {
		    $(".bx-prev").hide(); // 연속클릭으로 인한 슬라이드 넘어가는 것 방지
		    $(".bx-next").hide();
	    },
	    onSlideAfter: function() { //slide auto:true일 경우 화면 전환을 계속했을 때 멈춤현상 제거
		    $(".bx-prev").show();
		    $(".bx-next").show();
	    	bucketSlider.stopAuto();
	    	bucketSlider.startAuto();
	    	console.log(bucketSlider.getCurrentSlide());
	    }
  });
});