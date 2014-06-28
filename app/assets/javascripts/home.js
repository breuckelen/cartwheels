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

    var boxShadow = '0 4px 12px rgba(0, 0, 0, 0.7)'
    var ready = function(e) {
        var cartMap = new GMaps({
            div: '#map-div',
            lat: -12.043333,
            lng: -77.028333,
            scrollwheel: false
        });

        var sidebar = $('#sidebar-wrapper');
        sidebar.find('.glyphicon.glyphicon-remove-circle').on('click', function(e) {
            sidebar.css({'left': '0'});
            sidebar.css({'box-shadow': 'none'});
        });

        var navbar = $('#navbar-wrapper');
        navbar.find('.glyphicon.glyphicon-list').parent().on('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            sidebar.css({'left': '300px'});
            sidebar.css({'box-shadow': boxShadow});
        });

        $('#content-wrapper').on('click', function(e) {
            sidebar.css({'left': '0'});
            sidebar.css({'box-shadow': 'none'});
        });
    };

    $(window).scroll(onScroll);
    $(document).ready(ready);
})();
