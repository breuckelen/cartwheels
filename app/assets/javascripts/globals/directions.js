(function() {
    var DirectionsModal = function(element, options) {
        this.$el = element;
        var $modal = this;

        this.$el.on('shown.bs.modal', function(e) {
            $modal.initDirections();

            $(this).find('.search-form').searchForm({
                searchCallback: _.bind($modal.search, $modal)
            });
        });

    }

    DirectionsModal.prototype.initDirections = function() {
        var $modalMap = this.$el.find('.directions-map');
        this.directionsDisplay = new google.maps.DirectionsRenderer();
        this.directionsService = new google.maps.DirectionsService();
        var lat = $modalMap.attr('data-latitude'),
            lon = $modalMap.attr('data-longitude');
        this.directionsMap = new GMaps({
            div: $modalMap.get(0),
            zoom: 13,
            lat: lat,
            lng: lon,
            scrollwheel: false
        });

        this.directionsMap.refresh();
        this.directionsMap.removeMarkers();
        this.directionsMap.addMarker({
            lat: lat,
            lng: lon,
        });
        this.directionsDisplay.setMap(this.directionsMap.map);
        this.directionsDisplay.setPanel(
                this.$el.find('.directions-panel .container').get(0));
    }

    DirectionsModal.prototype.getRoute = function(start, end, display, service)
    {
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

    DirectionsModal.prototype.search = function(inputs) {
        var $modal = this;
        var $modalMap = this.$el.find('.directions-map');
        var lat = $modalMap.attr('data-latitude'),
            lon = $modalMap.attr('data-longitude');
        GMaps.geocode({
            address: inputs.lq,
            callback: function(results, status) {
                if(status == 'OK') {
                    var start = results[0].geometry.location;
                    var end = new google.maps.LatLng(lat, lon);

                    $modal.directionsMap.removeMarkers();
                    $modal.getRoute(start, end, $modal.directionsDisplay,
                        $modal.directionsService);
                }
            }
        });
    }

    $.fn.directions_modal = function(options) {
        $.each(this, function(el) {
            if (!$(this).hasClass('directions:bound')) {
                var modal = new DirectionsModal($(this), options);
            }
        });
    }

    $.fn.directions_modal.Constructor = DirectionsModal;

    var controller;

    var init = function() {
        controller = $('.directions-modal');
    }

    var ready = function() {
        init();

        if (controller.length === 0) return;

        controller.directions_modal();
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
