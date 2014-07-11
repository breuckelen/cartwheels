(function(e) {
    //Abstract class for search forms
    var SearchForm = function(element, options) {
        this.$el = element;

        this.$el.on('submit', _.bind(this.submit, this));
        this.search = options.searchCallback;
    }

    //Catches current location on location input
    SearchForm.prototype.submit = function(e) {
        e.preventDefault();

        var searchForm = this;
        var inputs = _.reduce(this.$el.find('input'), function(memo, input) {
            memo[input.name] = input.value;
            return memo;
        }, {});
        var $loc = this.$el.find('.location-input');

        if($loc.length > 0) {
            if ((/^\s*[Cc]urrent\s+[Ll]ocation\s*$/g).test($loc.val())) {
                navigator.geolocation.getCurrentPosition(
                    function(position) {
                        var val = position.coords.latitude + " "
                                + position.coords.longitude;
                        inputs[$loc.attr('name')] = val;
                        searchForm.search(inputs);
                    },
                    function(error){
                    }, {
                    enableHighAccuracy: true
                    ,timeout : 5000
                });
            } else {
                searchForm.search(inputs);
            }
        }
        else {
            searchForm.search(inputs);
        }
    }

    $.fn.searchForm = function(options) {
        $.each(this, function(el) {
            var searchForm = new SearchForm($(this), options);
        });
    }

    $.fn.searchForm.Constructor = SearchForm;
})();
