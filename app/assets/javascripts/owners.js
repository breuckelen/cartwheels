(function() {
    var controller;

    var init = function() {
        controller = $('#owners-show');
    }

    var ready = function() {
        init();

        if(controller.length === 0) return;

        controller.find('.manager-header').click(function(e) {
            $(this).next('.manager-content').toggleClass('show');
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
