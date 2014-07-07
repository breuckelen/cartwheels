(function() {
    var controller;

    var init = function() {
        controller = $('#carts');
    }

    var getMenuNotes = function(cart) {
        var notes = [];
        $.getJSON('/menu_items/data', {'menu_item': {'cart_id': 5 } }, function(data) {
            $.each(data.data, function(i, d) {
            });
            console.log(data);
        });
    }

    var ready = function() {
        init();

        if (controller.length === 0) return;

        controller.find('.cart .rating').raty({
            path: "assets",
            readOnly: true,
            size: 12,
            score: function() {
                return $(this).attr('data-score');
            }
        });


        controller.find('.next').click(function(e) {
            e.preventDefault();
            var $content = $(this).prev('.cart').find('.content');
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

            $content.parent().find('a[data-target-class=' + nclass + ']').parent().addClass('active');
            $content.parent().find('a[data-target-class=' + oclass + ']').parent().removeClass('active');
        });

        controller.find('.prev').click(function(e) {
            e.preventDefault();
            var $content = $(this).next('.cart').find('.content');
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

            $content.parent().find('a[data-target-class=' + nclass + ']').parent().addClass('active');
            $content.parent().find('a[data-target-class=' + oclass + ']').parent().removeClass('active');
        });

        controller.find('.cart .subname a').click(function(e) {
            e.preventDefault();
            var $content = $(this).parents('.cart').find('.content');
            var nclass = $(this).attr('data-target-class'),
                oclass = $content.attr('class').split(' ')[1];

            $(this).parent().siblings('.active').removeClass('active');
            $(this).parent().addClass('active');

            $content.addClass(nclass);
            $content.removeClass(oclass);
        });


        getMenuNotes($('.cart'));

        controller.find('.pop-image').click(function(e) {
            e.preventDefault();
        });

        controller.find('.pop-image-top').popover({
            placement: 'top',
            container: 'body',
            trigger: 'hover'
        });

        controller.find('.pop-image-bottom').popover({
            placement: 'bottom',
            container: 'body',
            trigger: 'hover'
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
