(function() {
    var ready = function(e) {
        new GMaps({
            div: '#map-div',
            lat: -12.043333,
            lng: -77.028333
        });
    };

    $(document).ready(ready);
})();
