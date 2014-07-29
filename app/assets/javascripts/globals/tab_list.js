(function() {
    var controller;

    var init = function() {
        controller = $('.tab-list');
    }

    var ready = function() {
        init();

        if (controller.length === 0) return;

        controller.find('li').click(function(e) {
            e.preventDefault();
            var $container = $(this).parent();
            var $target = $(this).attr('data-target');
            var $last = $container.find('li.active').attr('data-target');

            $($last).hide();
            $($target).show();

            $container.find('li.active').removeClass('active');
            $(this).addClass('active');
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
