(function() {
    var controller;

    var init = function() {
        controller = $('.map-form');
    }

    var initMap = function($container) {
        var form = $container.find('.wheels-form form');
        var model = form.attr('data-model');
        var latInput = $container.find('#' + model + '_lat'),
            lonInput = $container.find('#' + model + '_lon');
        var formMap = new GMaps({
            div: $container.find('.map').get(0),
            lat: latInput.val(),
            lng: lonInput.val(),
            zoom: 13,
            scrollwheel: false
        });

        formMap.addMarker({
            lat: latInput.val(),
            lng: lonInput.val(),
            draggable: true
        });

        var moveCheckin = function($container, address) {
            GMaps.geocode({
                address: address,
                callback: function(results, status) {
                    if(status == 'OK') {
                        var latlng = results[0].geometry.location;

                        formMap.removeMarkers();
                        formMap.setCenter(latlng.lat(), latlng.lng());
                        formMap.addMarker({
                            lat: latlng.lat(),
                            lng: latlng.lng(),
                            draggable: true
                        });
                        formMap.setZoom(14);
                    }
                }
            });
        }

        GMaps.on('click', formMap.map, function(event) {
            var lat = event.latLng.lat();
            var lng = event.latLng.lng();

            formMap.removeMarkers();
            formMap.addMarker({
                lat: lat,
                lng: lng,
                draggable: true
            });
        });

        form.submit(function(e) {
            e.preventDefault();

            var pos = formMap.markers[0].getPosition();
            var lat = pos.lat(), lon = pos.lng();

            latInput.val(lat);
            lonInput.val(lon);
            $(this).ajaxSubmit({
                contentType: 'application/json'
            });
        });

        $container.find('.search-form').searchForm({
            searchCallback: function(inputs) {
                moveCheckin($container, inputs.lq);
            }
        });
    }

    var ready = function() {
        init();

        if (controller.length === 0) return;

        if (controller.parents('.modal').size() > 0) {
            controller.parents('.modal').on('shown.bs.modal', function(e) {
                initMap($(this));
            });
        }
        else {
            initMap(controller);
        }
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
