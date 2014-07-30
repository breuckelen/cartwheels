(function(e) {
    /**
     * Class representing a search form and all of its view functionality.
     * @param {element} element
     * @param {object} options
     * @constructor
     */
    var SearchForm = function(element, options) {
        this.$el = element;

        /*
         * Initialization
         */
        this.inputs = [];

        /*
         * Configuration
         */
        this.locationRegex = /^\s*[Cc]urrent\s+[Ll]ocation\s*$/g;
        this.search = options.searchCallback;

        /*
         * Event binding
         */
        this.$el.on('submit', _.bind(this.submit, this));
    }

    /**
     * Submit callback for the search form. Catches the words "current location"
     *      for location query and replaces them with current latitude and
     *      longitude.
     */
    SearchForm.prototype.submit = function(e) {
        e.preventDefault();

        this.inputs = _.reduce(this.$el.find('input'), function(memo, input) {
            memo[input.name] = input.value;
            return memo;
        }, {});
        var $loc = this.$el.find('.location-input');

        if($loc.length > 0) {
            if (this.locationRegex.test($loc.val())) {
                navigator.geolocation.getCurrentPosition(
                    _.bind(this.positionSuccess, this),
                    _.bind(this.positionFailure, this), {
                    enableHighAccuracy: true
                    ,timeout : 5000
                });
            } else {
                this.search(this.inputs);
            }
        }
        else {
            this.search(this.inputs);
        }
    }

    /**
     * Success callback for getting current latitude and longitude.
     */
    SearchForm.prototype.positionSuccess = function(position) {
        var val = position.coords.latitude + " "
                + position.coords.longitude;
        var $loc = this.$el.find('.location-input');

        this.inputs[$loc.attr('name')] = val;
        this.search(this.inputs);
    }

    /**
     * Failure callback for getting current latitude and longitude.
     */
    SearchForm.prototype.positionFailure = function(error) {
    }

    $.fn.searchForm = function(options) {
        $.each(this, function(el) {
            var searchForm = new SearchForm($(this), options);
        });
    }

    $.fn.searchForm.Constructor = SearchForm;
})();
