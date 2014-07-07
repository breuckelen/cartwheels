(function() {
    var controller;
    var checkinMap;

    var init = function() {
        controller = $('form[data-model=checkin]').parent().parent();
    }

    var readUrl = function(input) {
        if (input.files && input.files[0]) {
            var label = input.files[0].name;
            controller.find('.file-btn .label').text(label);
        }
    }

    var formComplete = function(xhr, textStatus) {
        var response = $.parseJSON(xhr.responseText);

        if (response.success === true) {
            window.location.replace(xhr.getResponseHeader('Location'));
        }
    }

    var initMap = function() {
        checkinMap = new GMaps({
            div: '#checkin-map',
            lat: controller.find('#checkin_lat').val(),
            lng: controller.find('#checkin_lon').val(),
            zoom: 13,
            scrollwheel: false
        });
    }

    var moveCheckin = function(address) {
        GMaps.geocode({
            address: address,
            callback: function(results, status) {
                if(status == 'OK') {
                    var latlng = results[0].geometry.location;

                    checkinMap.removeMarkers();
                    checkinMap.setCenter(latlng.lat(), latlng.lng());
                    checkinMap.addMarker({
                        lat: latlng.lat(),
                        lng: latlng.lng(),
                        draggable: true
                    });
                    checkinMap.setZoom(14);
                }
            }
        });
    }

    var ready = function() {
        init();

        if (controller.length === 0) return;

        initMap();

        controller.find('#address-input').on('keypress', function(e) {
            if(e.which === 13) {
                moveCheckin($(this).val());
            }
        });

        GMaps.on('click', checkinMap.map, function(event) {
            var lat = event.latLng.lat();
            var lng = event.latLng.lng();

            checkinMap.removeMarkers();
            checkinMap.addMarker({
                lat: lat,
                lng: lng,
                draggable: true
            });
        });

        controller.find('#img-input').change(function(e) {
            readUrl(this);
        });

        controller.find('form').submit(function(e) {
            e.preventDefault();

            var pos = checkinMap.markers[0].getPosition();
            var lat = pos.lat(), lon = pos.lng();

            $(this).find('#checkin_lat').val(lat);
            $(this).find('#checkin_lon').val(lon);
            $(this).ajaxSubmit({
                contentType: 'application/json',
                complete: formComplete
            });
        });

    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
