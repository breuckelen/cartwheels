(function() {
    var controller;

    var init = function() {
        controller = $('#search-bar');
    }

    var search = function(inputs) {
        var str = '';
        for(key in inputs) {
            str += key + '=' + inputs[key] + '&';
        }
        str = str.slice(0, str.length - 1);

        window.location.assign('/search?' + str);
    }

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
