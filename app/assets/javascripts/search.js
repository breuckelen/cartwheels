(function(e) {
    var controller;

    var init = function() {
        controller = $('#search-index');
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
