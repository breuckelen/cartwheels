(function() {
    /**
     * Sidebar acts as the context for the sidebar and content as the context
     *      for the rest of the dom.
     */
    var sidebar, content;

    /**
     * Search function for the sidebar search.
     */
    var search = function(inputs) {
        str = '';
        for(key in inputs) {
            str += key + '=' + inputs[key] + '&';
        }
        str = str.slice(0, str.length - 1);

        window.location.assign('/search?' + str);
    }

    /**
     * Function to open the sidebar.
     */
    var openSidebar = function(e) {
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
    }

    /**
     * Function to close the sidebar.
     */
    var closeSidebarDefault = function(e) {
        e.preventDefault();
        sidebar.removeClass('open');
        sidebar.addClass('closed');
    }

    /**
     * Function to close the sidebar.
     */
    var closeSidebar = function(e) {
        sidebar.removeClass('open');
        sidebar.addClass('closed');
    }

    /**
     * Initialization function for this javascript context.
     */
    var init = function() {
        sidebar = $('#sidebar-wrapper');
        content = $('#content-wrapper');
    }

    /**
     * Function to execute context functionalisty when the DOM content loads.
     */
    var ready = function(e) {
        init();

        sidebar.find('.search-form').searchForm({
            searchCallback: search
        });

        sidebar.find('.attached-btn').on('click', openSidebar);

        sidebar.find('.glyphicon.glyphicon-remove-circle').on('click',
            closeSidebarDefault);
        content.on('click', closeSidebar);
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
