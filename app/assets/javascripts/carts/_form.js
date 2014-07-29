(function() {
    var controller;
    var lat, lng;

    var init = function() {
        controller = $('form[data-model=cart]');
    }

    var ready = function() {
        init();

        if(controller.length === 0) return;
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
