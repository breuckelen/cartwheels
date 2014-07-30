(function() {
    /**
     * All functionality in the javascript context acts on this DOM element
     *      and its children.
     */
    var controller;

    /**
     * Initialization function for this javascript context.
     */
    var init = function() {
        controller = $('body');
    }

    /**
     * Function to execute context functionalisty when the DOM content loads.
     */
    var ready = function() {
        init();

        controller.find('#loading-div').hide();

        /*
         * Show loading symbol on all ajax requests.
         */
        $(document).ajaxStart(function() {
            controller.addClass('loading');
        })
        /*
         * Remove loading symbol after ajax request completes.
         */
        .ajaxStop(function() {
            controller.removeClass('loading');
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
