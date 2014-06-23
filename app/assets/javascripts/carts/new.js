(function() {
    var carts_controller;
    var lat, lng;

    /*
    * Call init funcitons once the page loads.
    */
    var init = function() {
        carts_controller = $('#carts-new');
        navigator.geolocation.getCurrentPosition(showSubmit);
    }

    var showSubmit = function(position) {
        getPositionSuccess(position);
        carts_controller.find('input[type=submit]').show();
    }

    /*
    * Get the current position of the user.
    */
    var getPosition = function() {
        navigator.geolocation.getCurrentPosition(getPositionSuccess);
    }

    /*
    * Set hiden input fields to the position of the user.
    */
    var getPositionSuccess = function(position) {
        var inputLat = carts_controller.find('#cart_lat'),
            inputLon = carts_controller.find('#cart_lon');

        lat = position.coords.latitude;
        lng = position.coords.longitude;

        inputLat.val(lat);
        inputLon.val(lng);
    }

    /*
    * On page load.
    */
    var ready = function() {
        //Init
        init();

        //Variables
        var watchId = navigator.geolocation.watchPosition(getPosition);
    }

    $(document).ready(ready);
})();
