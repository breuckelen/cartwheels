(function(e) {
    var controller;

    var init = function() {
        controller = $('#search-index');
    }

    var ready = function() {
        init();

        if (controller.length === 0) return;

        controller.find('.cart .rating').raty({
            path: "assets",
            readOnly: true,
            score: function() {
                return $(this).attr('data-score');
            }
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);

})();
