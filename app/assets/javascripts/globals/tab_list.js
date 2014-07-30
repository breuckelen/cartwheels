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
        controller = $('.tab-list');
    }

    /**
     * Function to change the highlighted tab, and show the content of the
     *      target item.
     */
    var changeTab = function(e) {
        e.preventDefault();

        var $container = $(this).parent();
        var target = $(this).attr('data-target');
        var last = $container.find('li.active').attr('data-target');

        $(last).hide();
        $(target).show();

        $container.find('li.active').removeClass('active');
        $(this).addClass('active');
    }

    /**
     * Function to execute context functionalisty when the DOM content loads.
     */
    var ready = function() {
        init();

        if (controller.length === 0) return;

        controller.find('li').click(changeTab);
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
