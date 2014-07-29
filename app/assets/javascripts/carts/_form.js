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
        controller = $('form[data-model=cart]');
    }

    /**
     * Function to execute context functionalisty when the DOM content loads.
     */
    var ready = function() {
        init();

        if(controller.length === 0) return;
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
