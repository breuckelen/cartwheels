(function() {
    var controller;
    var lat, lng;

    /*
     * Call init funcitons once the page loads.
     */
    var init = function() {
        controller = $('form[data-model=cart]');
    }

    /*
     * On page load.
     */
    var ready = function() {
        //Init
        init();

        if(controller.length === 0) return;
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
