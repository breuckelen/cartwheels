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
        controller = $('#search-bar');
    }

    /**
     * Search function for the top search bar.
     */
    var search = function(inputs) {
        var str = '';
        for(key in inputs) {
            str += key + '=' + inputs[key] + '&';
        }
        str = str.slice(0, str.length - 1);

        window.location.assign('/search?' + str);
    }

    /**
     * Function to execute context functionalisty when the DOM content loads.
     */
    var ready = function() {
        init();

        if (controller.length === 0) return;

        controller.find('.search-form').searchForm({
            searchCallback: search
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
