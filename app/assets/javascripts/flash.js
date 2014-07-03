(function() {
    var ready = function() {
        $('.alert').delay(2000).fadeOut(500);
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
