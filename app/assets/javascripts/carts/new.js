(function() {
    var controller;
    var lat, lng;

    /*
     * Call init funcitons once the page loads.
     */
    var init = function() {
        controller = $('#carts-new');
    }

    var showSubmit = function(position) {
        getPositionSuccess(position);
        controller.find('input[type=submit]').show();
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
        var inputLat = controller.find('#cart_lat'),
            inputLon = controller.find('#cart_lon');

        lat = position.coords.latitude;
        lng = position.coords.longitude;

        inputLat.val(lat);
        inputLon.val(lng);
    }

    /*
     * Read data from image on file select
     */
    var readUrl = function(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            var img = controller.find('#img-preview');
            var label = input.files[0].name;

            reader.onload = function (e) {
                img.attr('src', e.target.result);
                controller.find('.img-preview').slideDown();
                controller.find('.file-btn .label').text(label);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }

    var formComplete = function(xhr, textStatus) {
        var response = $.parseJSON(xhr.responseText);

        if (response.success === true) {
            window.location.replace(xhr.getResponseHeader('Location'));
        }
    }

    /*
     * On page load.
     */
    var ready = function() {
        //Init
        init();

        if(controller.length == 0) return;

        //Calls
        navigator.geolocation.getCurrentPosition(showSubmit);

        //Variables
        var watchId = navigator.geolocation.watchPosition(getPosition);

        $('#new_cart').submit(function(e) {
            e.preventDefault();

            $('#new_cart').ajaxSubmit({
                contentType: 'application/json',
                complete: formComplete
            });
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
