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
        controller = $('form[data-model=review]');
    }

    /**
     * Function to execute context functionalisty when the DOM content loads.
     */
    var ready = function() {
        init();

        if(controller.length === 0) return;

        controller.find('.rating').wheels_rating({
            readOnly: false,
            size: 12,
            hints: [1, 2, 3, 4, 5],
            scoreName: 'review[rating]'
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
