(function() {
    /**
     * Initialization function for this javascript context.
     */
    var init = function() {
        controller = $('.map-form');
    }

    /**
     * Class representing all forms with a map component.
     * @param {element} element
     * @param {object} options
     * @constructor
     */
    var MapForm = function(element, options) {
        this.$el = element;
        var $form = this;

        /*
         * Initialization
         */
        if(this.$el.parents('.modal').length > 0) {
            this.$el.parents('.modal').on('shown.bs.modal',
                _.bind(this.initMap, this));
        }
        else {
            this.initMap();
        }

        /*
         * Mark as bound
         */
        this.$el.addClass('map_form:bound');

        /*
         * Event binding
         */
        this.$el.find('form[data-model=checkin]').unbind('submit');
        this.$el.find('form[data-model=checkin]').submit(
            _.bind(this.submit, this));

        /*
         * Object binding
         */
        this.$el.find('.search-form').searchForm({
            searchCallback: function(inputs) {
                $form.moveCheckin(element, inputs.lq);
            }
        });
    }

    MapForm.prototype.initMap = function() {
        var $form = this.$el.find('.wheels-form form');
        var model = $form.attr('data-model');

        this.latInput = this.$el.find('#' + model + '_lat');
        this.lonInput = this.$el.find('#' + model + '_lon');
        this.formMap = new GMaps({
            div: this.$el.find('.map').get(0),
            lat: this.latInput.val(),
            lng: this.lonInput.val(),
            zoom: 13,
            scrollwheel: false
        });

        this.formMap.addMarker({
            lat: this.latInput.val(),
            lng: this.lonInput.val(),
            draggable: true
        });

        GMaps.on('click', this.formMap.map, _.bind(this.placeCheckin, this));
    }

    MapForm.prototype.placeCheckin = function(e) {
        var lat = e.latLng.lat();
        var lng = e.latLng.lng();

        this.formMap.removeMarkers();
        this.formMap.addMarker({
            lat: lat,
            lng: lng,
            draggable: true
        });
    }

    MapForm.prototype.moveCheckin = function($container, address) {
        var $form = this;
        GMaps.geocode({
            address: address,
            callback: function(results, status) {
                if(status == 'OK') {
                    var latlng = results[0].geometry.location;

                    $form.formMap.removeMarkers();
                    $form.formMap.setCenter(latlng.lat(), latlng.lng());
                    $form.formMap.addMarker({
                        lat: latlng.lat(),
                        lng: latlng.lng(),
                        draggable: true
                    });
                    $form.formMap.setZoom(14);
                }
            }
        });
    }

    MapForm.prototype.submit = function(e) {
        e.preventDefault();

        var pos = this.formMap.markers[0].getPosition();
        var lat = pos.lat(), lon = pos.lng();

        this.latInput.val(lat);
        this.lonInput.val(lon);

        $(this).ajaxSubmit({
            contentType: 'application/json'
        });
    }

    $.fn.map_form = function(options) {
        $.each(this, function(el) {
            if (!$(this).hasClass('map_form:bound')) {
                var mapForm = new MapForm($(this), options);
            }
        });
    }

    $.fn.map_form.Constructor = MapForm;

    /**
     * All functionality in the javascript context acts on this DOM element
     *      and its children.
     */
    var controller;

    /**
     * Function to execute context functionalisty when the DOM content loads.
     */
    var ready = function() {
        init();

        if (controller.length === 0) return;

        controller.map_form();
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
