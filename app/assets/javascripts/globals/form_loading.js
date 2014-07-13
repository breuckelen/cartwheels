(function() {
    var FormLoading = function(element, options) {
        this.$el = element;

        var cachedFunction = this.$el.submit;
    }


    $.fn.form_loading = function(options) {
        $.each(this, function(el) {
            var formLoading = new FormLoading($(this), options);
        });
    }

    $.fn.form_loading.Constructor = FormLoading;

    var ready = function() {
        $('#loading-div').hide();
        $(document).ajaxStart(function() {
            $('body').addClass('loading');
        })
        .ajaxStop(function() {
            $('body').removeClass('loading');
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
