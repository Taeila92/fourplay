<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta charset="UTF-8">
   <title>Document</title>
   <style>
   body { margin:0 auto; }

   .slideshow {
      background:#000; width:100%; height:700px; min-width:960px;   overflow:hidden; 
      position:relative; padding-top:220px;
   }
   .slideshow-slides { height:100%; position:absolute; width:100%; }
   .slideshow-slides .slide {
      height:100%; width:100%; overflow:hidden; position:absolute; 
   }
   .slideshow-slides .slide img {
      left:50%; margin-left:-1030px; position:absolute;
   }
   .slideshow-nav a, .slideshow-indicator a {
      background:rgba(0, 0, 0, 0); overflow:hidden;
   }
   .slideshow-nav a:before, .slideshow-indicator a:before {
      content:url("images/sprites.png"); 
      display:inline-block; font-size:0; line-height:0;
   }
   .slideshow-nav a {
      position:absolute; top:50%; left:50%; width:72px; 
      height:72px; margin-top:70px;
   }
   .slideshow-nav a.prev { margin-left:-790px; }
   .slideshow-nav a.prev:before { margin-top:-20px; }
   .slideshow-nav a.next { margin-left:721px; }
   .slideshow-nav a.next:before { margin:-20px 0 0 -80px; }
   .slideshow-nav a.disabled { display:none; }

   .slideshow-indicator {
      bottom:30px; height:16px; left:0; position:absolute;
      right:0; text-align:center;
   }
   .slideshow-indicator a {
      display:inline-block; width:16px; height:16px; margin:0 3px; 
   }
   .slideshow-indicator a.active { cursor:default; }
   .slideshow-indicator a:before { margin-left:-110px; }
   .slideshow-indicator a.active:before { margin-left:-130px; }
   </style>
   <script src="jquery-3.5.1.js"></script>
   <script src="jquery-ui-1.10.3.custom.min.js"></script>
   <script>
   $(document).ready(function() {
      $(".slideshow").each(function() { 
         var $container = $(this),   
            $slideGroup = $container.find(".slideshow-slides"), 
            $slides = $slideGroup.find(".slide"), 
            $nav = $container.find(".slideshow-nav"), 
            $indicator = $container.find(".slideshow-indicator"), 
            slideCount = $slides.length, 
            indicatorHTML = "", 
            currentIndex = 0, 
            duration = 500, 
            easing = "easeInOutExpo", 
            interval = 4000, 
            timer; 

         $slides.each(function(i) {
            $(this).css({left:100 * i + "%"});
            indicatorHTML += "<a href='#'>" + (i + 1) + "</a>";
         });
         $indicator.html(indicatorHTML);

         function goToSlide(idx) {
            $slideGroup.animate({left:-100 * idx + "%"}, duration, easing);
            currentIndex = idx;
            updateNav();
         }

         function updateNav() {
            var $navPrev = $nav.find(".prev");  
            var $navNext = $nav.find(".next");   

            if (currentIndex == 0) {   //첫번째 슬라이드일 경우
               $navPrev.addClass("disabled");
            } else {   //첫번째 슬라이드가 아닐 경우
               $navPrev.removeClass("disabled");
            }
            if (currentIndex == slideCount - 1) {// 마지막 슬라이드일 경우
               $navNext.addClass("disabled");
            } else {   //마지막 슬라이드가 아닐 경우
               $navNext.removeClass("disabled");
            }

            $indicator.find("a").removeClass("active").eq(currentIndex).addClass("active");
         }

         function startTimer() {
            timer = setInterval(function() {
               var nextIndex = (currentIndex + 1) % slideCount;
               goToSlide(nextIndex);
            }, interval);
         }

         function stopTimer() {
            clearInterval(timer);
         }

         $nav.on("click", "a", function(event) {
            event.preventDefault();
            if ($(this).hasClass("prev")) {
            // 이벤트를 일으킨 $nav영역에 prev라는 클래스가 있으면
            // 이전 슬라이드 버튼을 클릭했으면
               goToSlide(currentIndex - 1);
            } else {   
            // 아니면(이벤트를 일으킨 $nav영역에 next라는 클래스가 있으면)
            // 다음 슬라이드 버튼을 클릭했으면
               goToSlide(currentIndex + 1);
            }
         });

         $indicator.on("click", "a", function(event) {
            event.preventDefault();
            if (!$(this).hasClass("active")) {
            // 이벤트를 일으킨 $indicator영역에 active라는 클래스가 없으면
               goToSlide($(this).index());
            }
         });

         $container.on({
            mouseenter:stopTimer,   
            mouseleave:startTimer  
         });

         goToSlide(currentIndex);

         startTimer();
      });
   });
   </script>
</head>
<body>
<div class="slideshow">
   <div class="slideshow-slides">
      <a href="#" class="slide" id="slide-1"><img  width="2050" height="700"src="images/slide-1.JPG" /></a>
      <a href="#" class="slide" id="slide-2"><img  width="2050" height="700"src="images/slide-2.JPG" /></a>
      <a href="#" class="slide" id="slide-3"><img  width="2050" height="700"src="images/slide-3.JPG" /></a>
      <a href="#" class="slide" id="slide-4"><img  width="2050" height="700"src="images/slide-4.JPG" /></a>
   </div>
   <div class="slideshow-nav">
      <a href="#" class="prev"></a>
      <a href="#" class="next"></a>
   </div>
   <div class="slideshow-indicator"></div>
</div>
</body>
</html>