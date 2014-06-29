(function() {
    var ready = function(e) {
        var sidebar = $('#sidebar-wrapper'),
            content = $('#content-wrapper');

        sidebar.find('.glyphicon.glyphicon-remove-circle').on('click', function(e) {
            e.preventDefault();
            sidebar.removeClass('open');
            sidebar.addClass('closed');
        });

        sidebar.find('.attached-btn').on('click', function(e) {
            e.preventDefault();
            e.stopPropagation();

            if (sidebar.hasClass('closed')) {
                sidebar.removeClass('closed');
                sidebar.addClass('open');
            }
            else {
                sidebar.removeClass('open');
                sidebar.addClass('closed');
            }
        });

        content.on('click', function(e) {
            sidebar.removeClass('open');
            sidebar.addClass('closed');
        });

    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
