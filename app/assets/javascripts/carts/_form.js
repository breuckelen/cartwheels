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

        controller.find('.form-input').focus(function(e) {
            controller.parent().find('.form-desc').slideUp();
            controller.parent().find('.form-header').slideUp();
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
