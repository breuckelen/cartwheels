(function() {
    var controller, cartMap, searchInput;
    var lastVertPos, searchOffset, searchLimit;
    var textQuery, locationQuery;

    var init = function() {
        $(window).scrollTop(0);

        controller = $('#home-index');
        searchInput = $('input.gmaps-input');
        searchOffset = 0;
        searchLimit = 20;
        lastVertPos = $(window).scrollTop();
    }

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

    var onSearchSuccess = function(data) {
        cartMap.removeMarkers();
        console.log(data);

        $.each(data.data, function(i, d) {
            cartMap.addMarker({
                lat: d.lat,
                lng: d.lon,
                title: d.name
            });

            if (i === data.data.length - 1) {
                cartMap.setCenter(d.lat, d.lon);
            }
        });

        if (data.data.length === searchLimit) {
            searchOffset += searchLimit;
        } else {
            searchOffset = 0;
        }

        $('.more').removeClass('hide');
    }

    var loadSearchResults = function() {
        var data = {
            "tq": textQuery,
            "lq": locationQuery,
            "offset": searchOffset,
            "limit": searchLimit
        };

        $.ajax({
            dataType: "json",
            url: "/carts/search",
            data: data,
            success: onSearchSuccess
        });
    }

    var onMapSearch = function(e) {
        textQuery = searchInput[0].value;
        locationQuery = searchInput[1].value;

        loadSearchResults();
    }

    var ready = function(e) {
        init();

        if (controller.length == 0) return;

        cartMap = new GMaps({
            div: '#map-div',
            lat: 40.7820015,
            lng: -73.8317032,
            zoom: 11,
            scrollwheel: false
        });

        searchInput.focus(function(e) {
            $('.input-hidden').fadeIn();
        })

        searchInput.keypress(function(e) {
            if(e.which === 13) {
                onMapSearch();
            }
            else {
                controller.find('.more').addClass('hide');
            }
        });

        controller.find('.gmaps-button').click(function(e) {
            onMapSearch();
        });

        controller.find('.more').click(function(e) {
            e.preventDefault();
            loadSearchResults();
        });

        $(window).scroll(onScroll);
    };

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
