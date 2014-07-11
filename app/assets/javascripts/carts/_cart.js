(function() {
    var tmp = $.fn.popover.Constructor.prototype.show;

    $.fn.popover.Constructor.prototype.show = function () {
        tmp.call(this);
        if (this.options.callback) {
            this.options.callback();
        }
    }

    var Cart = function(element, options) {
        this.$el = element;
        var $cart = this;

        this.$el.find('.container .rating').raty({
            path: "/assets",
            readOnly: true,
            size: 12,
            score: function() {
                return $(this).attr('data-score');
            }
        });

        this.menuInit();

        this.$el.find('.next').click(function(e) {
            e.preventDefault();
            $cart.nextSection();
        });

        this.$el.find('.prev').click(function(e) {
            e.preventDefault();
            $cart.prevSection();
        });

        this.$el.find('.subname a').click(function(e) {
            e.preventDefault();
            $cart.switchSection($(this));
        });

        this.$el.find('.pop-image').click(function(e) {
            e.preventDefault();
        });

        this.$el.find('.pop-image-top').popover({
            placement: 'top',
            container: 'body',
            trigger: 'hover'
        });

        this.$el.find('.pop-input').popover({
            html: true,
            placement: 'top',
            container: 'body',
            content: function() {
                return $(this).parent().find('.content-popover').html();
            },
            trigger: 'click',
            callback: popoverCallback
        });

        if(options !== undefined && options['startTab'] !== undefined) {
            this.switchSection(
                this.$el.find('.subname a[data-target-class=' + options['startTab'] + ']')
            )
        }
    }

    Cart.prototype.nextSection = function() {
        var $content = this.$el.find('.content');
        var oclass = $content.attr('class').split(' ')[1],
            nclass;

        if($content.hasClass('first')) {
            nclass = 'second';
            $content.addClass('second');
            $content.removeClass('first');
        }
        else if($content.hasClass('second')) {
            nclass = 'third';
            $content.addClass('third');
            $content.removeClass('second');
        }
        else if($content.hasClass('third')) {
            nclass = 'fourth';
            $content.addClass('fourth');
            $content.removeClass('third');
        }
        else if($content.hasClass('fourth')) {
            nclass = 'first';
            $content.addClass('first');
            $content.removeClass('fourth');
        }

        this.$el.find('a[data-target-class=' + nclass + ']').parent().addClass('active');
        this.$el.find('a[data-target-class=' + oclass + ']').parent().removeClass('active');
    }

    Cart.prototype.prevSection = function() {
        var $content = this.$el.find('.content');
        var oclass = $content.attr('class').split(' ')[1],
            nclass;

        if($content.hasClass('first')) {
            nclass = 'fourth';
            $content.addClass('fourth');
            $content.removeClass('first');
        }
        else if($content.hasClass('second')) {
            nclass = 'first';
            $content.addClass('first');
            $content.removeClass('second');
        }
        else if($content.hasClass('third')) {
            nclass = 'second';
            $content.addClass('second');
            $content.removeClass('third');
        }
        else if($content.hasClass('fourth')) {
            nclass = 'third';
            $content.addClass('third');
            $content.removeClass('fourth');
        }

        this.$el.find('a[data-target-class=' + nclass + ']').parent().addClass('active');
        this.$el.find('a[data-target-class=' + oclass + ']').parent().removeClass('active');
    }

    Cart.prototype.switchSection = function($el) {
        var $content = this.$el.find('.content');
        var nclass = $el.attr('data-target-class'),
            oclass = $content.attr('class').split(' ')[1];

        this.$el.find('.subname.active').removeClass('active');
        $el.parent().addClass('active');

        $content.addClass(nclass);
        $content.removeClass(oclass);
    }

    Cart.prototype.menuInit = function() {
        var $carousel = this.$el.find('.menu .carousel');
        var $active = $carousel.find('.item.active');
        var $cart = this;

        this.getMenuNotes();

        $carousel.on('slid.bs.carousel', function(e) {
            $cart.getMenuNotes();
        });
    }

    Cart.prototype.getMenuNotes = function() {
        var $container = this.$el.find('.menu');
        var $menuItem = $container.find('.item.active');

        $container.find('.notes').find('.item').fadeOut(function(e) {
            $container.find('.notes').html('');
        })

        $.getJSON('/menu_items/data', {'menu_item': {'id': $menuItem.attr('id') } }, function(data) {
            var notes = [], index = 0;
            $.each(data.data, function(i, d) {
                $.each(d.notes, function(i, n) {
                    notes.push(n);
                });
            });

            $.each(notes.splice(0, 4), function(i, n) {
                if (i > 1) {
                    index = 1;
                }

                var div = $('<div/>').text('"' + n.text + '"').addClass('item');
                $('<div/>').text(n.user.name).addClass('user')
                    .appendTo(div);
                div.appendTo($container.find('.notes').get(index));
                div.fadeIn();
            });
        });
    }

    $.fn.cart = function(options) {
        $.each(this, function(el) {
            var cart = new Cart($(this), options);
        });
    }

    $.fn.cart.Constructor = Cart;

    var controller;

    var init = function() {
        controller = $('#carts');
    }

    //Popover forms
    var popoverCallback = function() {
        $('.popover-input').keypress(function(e) {
            if(e.which === 13) {
                e.preventDefault();
                $(this).parent().submit();
                $(this).parents('.popover').hide();
            }
        });
    }
    var ready = function() {
        init();

        if (controller.length === 0) return;

        controller.find('.cart').cart();

        controller.find('form[data-model=menu_item]').on('submit', function(e) {
            e.preventDefault();

            $(this).ajaxSubmit({
                contentType: 'application/json'
            });
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
