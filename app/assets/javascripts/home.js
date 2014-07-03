(function() {
    var controller, cartMap, searchInput;
    var lastVertPos, searchOffset, searchLimit;

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
        var bounds = [];
        cartMap.removeMarkers();

        $.each(data.data, function(i, d) {
            //Extend the bounds of the map
            var latlng = new google.maps.LatLng(d.lat, d.lon);
            bounds.push(latlng);

            var icon = {
                scaledSize: new google.maps.Size(25, 32),
                url: "assets/pin.jpg"
            };
            //Add a marker
            cartMap.addMarker({
                lat: d.lat,
                lng: d.lon,
                title: d.name,
                icon: icon,
                animation: google.maps.Animation.DROP
            });

            //Center on the last data point
            if (i === data.data.length - 1) {
                cartMap.setCenter(d.lat, d.lon);
            }
        });

        cartMap.fitLatLngBounds(bounds);

        //Increase search offset if more results, else reset
        if (data.data.length === searchLimit) {
            searchOffset += searchLimit;
        } else {
            searchOffset = 0;
        }

        $('.more').removeClass('hide');
    }

    var loadSearchResults = function(tq, lq) {
        if ((/^\s*[Cc]urrent\s+[Ll]ocation\s*$/g).test(lq)) {
            navigator.geolocation.getCurrentPosition(
                function(position) {
                    loadSearchResults(tq, position.coords.latitude + " " + position.coords.longitude);
                },
                function(error){
                    alert(error.message);
                }, {
                enableHighAccuracy: true
                ,timeout : 5000
            });
        } else {
            var data = {
                "tq": tq,
                "lq": lq,
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
    }

    var onMapSearch = function(e) {
        var textQuery = searchInput[0].value;
        var locationQuery = searchInput[1].value;

        loadSearchResults(textQuery, locationQuery);
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
