(function() {
    var controller;

    var init = function() {
        controller = $('.map-form');
    }

    var MapForm = function(element, options) {
        this.$el = element;
        var $form = this;

        this.$el.find('.search-form').searchForm({
            searchCallback: function(inputs) {
                $form.moveCheckin(element, inputs.lq);
            }
        });

        this.$el.find('form').submit(function(e){
            e.preventDefault();

            var pos = $form.formMap.markers[0].getPosition();
            var lat = pos.lat(), lon = pos.lng();

            $form.latInput.val(lat);
            $form.lonInput.val(lon);
            $(this).ajaxSubmit({
                contentType: 'application/json'
            });

            $(this).trigger('custom');
        });

        if(this.$el.parents('.modal').length > 0) {
            this.$el.parents('.modal').on('shown.bs.modal', function(e) {
                $form.initMap();
            });
        }
        else {
            this.initMap();
        }
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

        GMaps.on('click', this.formMap.map, function(event) {
            var lat = event.latLng.lat();
            var lng = event.latLng.lng();

            this.formMap.removeMarkers();
            this.formMap.addMarker({
                lat: lat,
                lng: lng,
                draggable: true
            });
        });
    }

    MapForm.prototype.moveCheckin = function($container, address) {
        GMaps.geocode({
            address: address,
            callback: function(results, status) {
                if(status == 'OK') {
                    var latlng = results[0].geometry.location;

                    this.formMap.removeMarkers();
                    this.formMap.setCenter(latlng.lat(), latlng.lng());
                    this.formMap.addMarker({
                        lat: latlng.lat(),
                        lng: latlng.lng(),
                        draggable: true
                    });
                    this.formMap.setZoom(14);
                }
            }
        });
    }

    $.fn.map_form = function(options) {
        $.each(this, function(el) {
            var mapForm = new MapForm($(this), options);
        });
    }

    $.fn.map_form.Constructor = MapForm;

    var ready = function() {
        init();

        if (controller.length === 0) return;

        controller.map_form();
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
