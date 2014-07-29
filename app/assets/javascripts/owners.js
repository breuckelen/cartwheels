(function() {
    var controller;

    var init = function() {
        controller = $('#owners-show');
    }

    var ready = function() {
        init();

        if(controller.length === 0) return;
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
