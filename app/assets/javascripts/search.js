(function(e) {
    var controller;

    var init = function() {
        controller = $('#search-index');
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

        if(controller.length === 0) return;

        controller.find('.pagination a').click(function(e) {
            var str = window.location.search.split('&').slice(0, 2)
                .join('&');
            str += '&offset=' + parseInt($(this).attr('data-page')) * 20;
            window.location.assign(str);
        });
    }

    $(document).ready(ready);
})();
