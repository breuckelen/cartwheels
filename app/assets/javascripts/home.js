(function() {
    var lastVertPos = $(window).scrollTop();
    var onScroll = function(e) {
        var currVertPos = $(window).scrollTop();
        var delta = currVertPos - lastVertPos;
        $("#poster").each(function(){
            $(this).css("top", parseFloat($(this).css("top")) -
                delta * $(this).attr("speed") + "px");
        });
        lastVertPos = currVertPos;
    }

    var catchMapScroll = function(e) {
        e.stopPropagation();
    }

    var ready = function(e) {
        var controller = $('#home-index');
        if (controller.length == 0) return;

        var cartMap = new GMaps({
            div: '#map-div',
            lat: -12.043333,
            lng: -77.028333,
            scrollwheel: false
        });

        $(window).scroll(onScroll);
    };

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
