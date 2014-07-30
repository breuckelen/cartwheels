(function(e) {
    /**
     * All functionality in the javascript context acts on this DOM element
     *      and its children.
     */
    var controller;

    /**
     * Initialization function for this javascript context.
     */
    var init = function() {
        controller = $('#search-index');
    }

    /**
     * Function to change the result page number and load more results.
     */
    var changePage = function(e) {
        var str = window.location.search.split('&').slice(0, 2)
            .join('&');
        str += '&offset=' + parseInt($(this).attr('data-page')) * 20;
        window.location.assign(str);
    }

    /**
     * Function to execute context functionalisty when the DOM content loads.
     */
    var ready = function() {
        init();

        if(controller.length === 0) return;

        controller.find('.pagination a').click(changePage);
    }

    $(document).ready(ready);
})();
