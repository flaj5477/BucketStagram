$(document).ready(function() {
	var libSlider = $('.libSlider').bxSlider({
	    mode: 'horizontal', //가로 방향 수평 슬라이드
	    pause: 10000,
	    speed: 500, // 이동속도
	    pager: false, //현재위치 페이징 표시여부
	    moveSlides: 4,//슬라이드 이동 갯수
	    slideWidth: 350,//슬라이드 너비
	    minSlides: 4,// 최소 노출 개수
	    maxSlides: 4,// 최대 노출 개수
	    slideMargin: 5,// 슬라이드 간격
	    auto: true,// 자동 실행
	    autoHover: true,// 마우스 호버, 정지여부(슬라이드에 마우스가 들어오면 슬라이드정지)
	    controls: true,
	    onSlideBefore: function() {
	    	 // next,prev disable 작업
	    },
	    onSlideAfter: function() {
	    	libSlider.stopAuto();
	    	libSlider.startAuto();
	    	console.log(libSlider.getCurrentSlide());
	    }
	})
	var bucketSlider = $('.bucketSlider').bxSlider({
	    mode: 'horizontal', //가로 방향 수평 슬라이드
	    pause: 10000,
	    speed: 500, // 이동속도
	    pager: false, //현재위치 페이징 표시여부
	    moveSlides: 4,//슬라이드 이동 갯수
	    slideWidth: 350,//슬라이드 너비
	    minSlides: 4,// 최소 노출 개수
	    maxSlides: 4,// 최대 노출 개수
	    slideMargin: 5,// 슬라이드 간격
	    auto: true,// 자동 실행
	    autoHover: true,// 마우스 호버, 정지여부
	    controls: true,// 이전 다음 버튼 노출여부
	    onSlideAfter: function() { //slide auto:true일 경우 화면 전환을 계속했을 때 멈춤현상 제거
	    	bucketSlider.stopAuto();
	    	bucketSlider.startAuto();
	    }
  });
});