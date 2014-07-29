(function() {
    /**
     * Function to execute context functionalisty when the DOM content loads.
     */
    var ready = function() {
        $('.alert').delay(2000).fadeOut(500);
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
