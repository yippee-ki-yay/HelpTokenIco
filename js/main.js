$(window).load(function() {
    $("#preloader").fadeOut("slow");
});

$(document).ready(function(){

    wow = new WOW({
        mobile:       false,       // default
      }
    )
    wow.init();

     $('#top-nav').onePageNav({
        currentClass: 'current',
        changeHash: true,
        scrollSpeed: 1200
    });

     
    //animated header class
    $(window).scroll(function () {
        if ($(window).scrollTop() > 100) {
            $(".navbar-default").addClass("animated");
        } else {
            $(".navbar-default").removeClass('animated');
        }
    });

    $('#countdown_dashboard').countDown({
        targetDate: {
            'day':      12,
            'month':    9,
            'year':     2018,
            'hour':     02,
            'min':      37,
            'sec':      01,
        },
        omitWeeks: true
    });

    $('.init-slider').owlCarousel({
        items:1,
        merge:true,
        loop:true,
        video:true,
        smartSpeed: 600
    });


});
