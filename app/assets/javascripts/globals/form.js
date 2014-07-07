(function() {
    $.fn.render_form_errors = function(errors) {
        this.clear_previous_errors();
        model = this.data('model');

        // show error messages in input form-group help-block
        $.each(errors, function(field, messages){
            $input = $('input[name="' + model + '[' + field + ']"]');
            if ($input.length > 0) {
                $input.closest('.form-group').addClass('has-error').find('.help-block').html( messages[0] );
            }
            else {
                $('.form-group').addClass('has-error').find('.help-block').html( messages);
            }
        });

    };

    $.fn.clear_previous_errors = function() {
        $('.form-group.has-error', this).each(function(){
            $('.help-block', $(this)).html('');
            $(this).removeClass('has-error');
        });
    };

    var ready = function() {
        $(document).bind('ajaxError', 'form[data-remote=true]', function(event, jqxhr, settings, exception){
            var errors = $.parseJSON(jqxhr.responseText).errors;
            if (errors === undefined) {
                var loc = jqxhr.getResponseHeader('Location');
                if(loc) {
                    window.location.replace(loc);
                }
            }
            $(event.data).render_form_errors( errors );
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
