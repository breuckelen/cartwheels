(function() {
    $.fn.render_form_errors = function(errors) {
        var model = this.data('model');
        var $container = $(this);

        this.clear_previous_errors();
        // show error messages in input form-group help-block
        $.each(errors, function(field, messages) {
            $input = $container.find('input[name="' + model + '[' + field + ']"]');
            if ($input.length > 0) {
                $input.closest('.form-group').addClass('has-error').find('.help-block').html( messages[0] );
            }
            else {
                $(this).find('.form-group').addClass('has-error').find('.help-block').html(messages);
            }
        });

    };

    $.fn.clear_previous_errors = function() {
        $('.form-group.has-error', this).each(function(){
            $('.help-block', $(this)).html('');
            $(this).removeClass('has-error');
        });
    };

    var controller;

    var init = function() {
        controller = $('form[data-remote=true]');
    }

    var readUrl = function(input) {
        var $container = $(input).parents('form');
        if (input.files && input.files[0]) {
            var label = input.files[0].name;
            $container.find('.file-btn .label').text(label);
        }
    }

    var ready = function() {
        init();

        if(controller.length === 0) return;

        if(controller.attr('enctype') !== undefined) {
        }

        controller.find('#img-input').change(function(e) {
            readUrl(this);
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
