(function() {
    /**
     * Class representing a directions modal and all of its view functionality
     * @param {element} element
     * @param {object} options
     * @constructor
     */
    var DirectionsModal = function(element, options) {
        this.$el = element;
        var $modal = this;

        /*
         * Event binding
         */
        this.$el.on('shown.bs.modal', _.bind(this.open, this));
    }

    /**
     * Bind map events once the modal has been opened.
     */
    DirectionsModal.prototype.open = function(e) {
        var $modal = this;
        this.initDirections();

        this.$el.find('.search-form').searchForm({
            searchCallback: _.bind($modal.search, $modal)
        });
    }

    /**
     * Initialize google maps directions services and map once the modal is
     *      opened.
     */
    DirectionsModal.prototype.initDirections = function() {
        var $modalMap = this.$el.find('.directions-map');
        var lat = $modalMap.attr('data-latitude'),
            lon = $modalMap.attr('data-longitude');

        this.directionsDisplay = new google.maps.DirectionsRenderer();
        this.directionsService = new google.maps.DirectionsService();
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

    /**
     * Calculate and draw a route between two endpoints on the modal's map.
     * @param {google.maps.LatLng} start
     * @param {google.maps.LatLng} end
     * @param {google.maps.DirectionsRenderer} display
     * @param {google.maps.DirectionsService} service
     */
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

    /**
     * Calculate the routes and directions once an address is entered. Used as
     *      the search method of a SearchForm object.
     * @param {array} inputs
     */
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

    /**
     * All functionality in the javascript context acts on this DOM element
     *      and its children.
     */
    var controller;

    /**
     * Initialization function for this javascript context.
     */
    var init = function() {
        controller = $('.directions-modal');
    }

    /**
     * Function to execute context functionalisty when the DOM content loads.
     */
    var ready = function() {
        init();

        if (controller.length === 0) return;

        controller.directions_modal();
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
