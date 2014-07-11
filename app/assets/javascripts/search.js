(function(e) {
    var controller;

    var init = function() {
        controller = $('#search-index');
    }

    var search = function(inputs) {
        str = '';
        for(key in inputs) {
            str += key + '=' + inputs[key] + '&';
        }
        str = str.slice(0, str.length - 1);

        window.location.assign('/search?' + str);
    }

    var ready = function() {
        init();

        if(controller.length === 0) return;

        controller.find('#search-bar').css({'top': '0px'});

        controller.find('#top-content .search-form').searchForm({
            searchCallback: search
        });
    }

    $(document).ready(ready);
})();
