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

    var ready = function(e) {
        new GMaps({
            div: '#map-div',
            lat: -12.043333,
            lng: -77.028333
        });
    };

    $(document).ready(ready);

    $(window).scroll(onScroll);
})();
