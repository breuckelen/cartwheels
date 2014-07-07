(function() {
    var controller;

    var init = function() {
        controller = $('.directions-modal');
    }

    var getRoute = function(start, end, display, service) {
        var request = {
            origin: start,
            destination: end,
            travelMode: google.maps.TravelMode.WALKING
        };

        service.route(request, function (response, status) {
            if (status === google.maps.DirectionsStatus.OK) {
                display.setDirections(response);
            } else {
                alert("error displaying directions");
            }
        });
    }

    var initDirections = function(modalMap) {
        var directionsDisplay = new google.maps.DirectionsRenderer(),
            directionsService = new google.maps.DirectionsService();
        var lat = modalMap.attr('data-latitude'),
            lon = modalMap.attr('data-longitude');
        var end = new google.maps.LatLng(lat, lon);
        var directionsMap = new GMaps({
            div: modalMap.get(0),
            zoom: 13,
            lat: lat,
            lng: lon,
            scrollwheel: false
        });
        var rawMap = new google.maps.Map(modalMap.get(0));
        var $container = modalMap.parent();

        directionsMap.removeMarkers();
        directionsMap.addMarker({
            lat: lat,
            lng: lon,
        });
        directionsDisplay.setMap(rawMap);
        directionsDisplay.setPanel($container.find('.directions-panel').get(0));

        $container.find('#address').on('keypress', function(e) {
            if(e.which === 13) {
                GMaps.geocode({
                    address: $container.find('#address').val(),
                    callback: function(results, status) {
                        if(status == 'OK') {
                            var start = results[0].geometry.location;

                            modalMap.addClass('squeezed');
                            modalMap.resize();
                            getRoute(start, end, directionsDisplay, directionsService);
                        }
                    }
                });
            }
        });
    }

    var ready = function() {
        init();

        if (controller.length === 0) return;

        controller.on('shown.bs.modal', function() {
            var modalMap = $(this).find('.directions-map');

            initDirections(modalMap);
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
