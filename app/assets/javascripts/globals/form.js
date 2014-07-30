(function() {
    /**
     * Function available to all jquery objects. Adds errors to correct parts
     *      of the form.
     */
    $.fn.render_form_errors = function(errors) {
        var model = this.data('model');
        var $container = $(this);

        this.clear_previous_errors();

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

    /**
     * Function available to all jquery objects. Clears all errors from the
     *      form to prepare for re-rendering of errors.
     */
    $.fn.clear_previous_errors = function() {
        $('.form-group.has-error', this).each(function() {
            $('.help-block', $(this)).html('');
            $(this).removeClass('has-error');
        });
    };

    /**
     * Class representing a cartwheels form and all of its view functionality.
     * @param {element} element
     * @param {object} options
     * @constructor
     */
    var WheelsForm = function(element, options) {
        this.$el = element;
        var $form = this;

        /*
         * Mark as bound
         */
        this.$el.addClass('form:bound');

        /*
         * Event binding
         */
        this.$el.find('.img-input').change(_.bind(this.changeLabel, this));

        if (this.$el.attr('enctype') !== undefined) {
            this.$el.on('submit', this.multipartSubmit);
        }
    }

    /**
     * Change the label of a file input to match the name of the file.
     */
    WheelsForm.prototype.changeLabel = function(e) {
        var input = e.target;

        if (input.files && input.files[0]) {
            var label = input.files[0].name;
            this.$el.find('.file-btn .label').text(label);
        }
    }

    /**
     * Submit callback for all forms with multipart data. Sends the request as
     *      JSON instead of JS.
     */
    WheelsForm.prototype.multipartSubmit = function(e) {
        e.preventDefault();

        $(this).ajaxSubmit({
            contentType: 'application/json'
        });
    }

    $.fn.wheels_form = function(options) {
        $.each(this, function(el) {
            if (!$(this).hasClass('form:bound')) {
                var form = new WheelsForm($(this), options);
            }
        });
    }

    $.fn.wheels_form.Constructor = WheelsForm;

    /**
     * All functionality in the javascript context acts on this DOM element
     *      and its children.
     */
    var controller;

    /**
     * Initialization function for this javascript context.
     */
    var init = function() {
        controller = $('form');
    }

    /**
     * Function to execute context functionalisty when the DOM content loads.
     */
    var ready = function() {
        init();

        if(controller.length === 0) return;

        controller.wheels_form();
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
