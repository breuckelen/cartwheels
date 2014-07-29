(function() {
    $.fn.render_form_errors = function(errors) {
        var model = this.data('model');
        var $container = $(this);

        this.clear_previous_errors();
        // show error messages in input form-group help-block
        $.each(errors, function(field, messages) {
            $input = $container.find(
                'input[name="' + model + '[' + field + ']"]');
            if ($input.length > 0) {
                $input.closest('.form-group').addClass('has-error')
                    .find('.help-block').html( messages[0] );
            }
            else {
                $(this).find('.form-group').addClass('has-error')
                    .find('.help-block').html(messages);
            }
        });

    };

    $.fn.clear_previous_errors = function() {
        $('.form-group.has-error', this).each(function() {
            $('.help-block', $(this)).html('');
            $(this).removeClass('has-error');
        });
    };

    var WheelsForm = function(element, options) {
        this.$el = element;
        var $form = this;

        this.$el.addClass('form:bound');
        this.$el.find('.img-input').change(function(e) {
            $form.readUrl(this);
        });

        if (this.$el.attr('enctype') !== undefined) {
            this.$el.on('submit', function(e) {
                e.preventDefault();

                $(this).ajaxSubmit({
                    contentType: 'application/json'
                });
            });
        }
    }

    WheelsForm.prototype.readUrl = function(input) {
        var $container = this.$el;

        if (input.files && input.files[0]) {
            var label = input.files[0].name;
            $container.find('.file-btn .label').text(label);
        }
    }

    $.fn.wheels_form = function(options) {
        $.each(this, function(el) {
            if (!$(this).hasClass('form:bound')) {
                var form = new WheelsForm($(this), options);
            }
        });
    }

    $.fn.wheels_form.Constructor = WheelsForm;

    var controller;

    var init = function() {
        controller = $('form');
    }

    var ready = function() {
        init();

        if(controller.length === 0) return;

        controller.wheels_form();
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
