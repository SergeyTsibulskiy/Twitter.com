$(document).ready(function () {

    $.ajaxSetup({
        beforeSend: function (xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        }
    });

    var ta_for_tweet = $('#ta_for_tweet');

    ta_for_tweet.addClass('no-expand');

    ta_for_tweet.focusin(function () {
        $(this).attr('rows', '4');
        $('#panel_btn_add_tweet').attr('style', 'display: block');
        var disabled = $(this).val().length == 0;
        $('#btn_add_tweet').attr("disabled", disabled);
    });

    ta_for_tweet.blur(function () {
        if ($(this).val().length == 0) {
            $('#ta_for_tweet').attr('rows', '1');
            $('#panel_btn_add_tweet').attr('style', 'display: none')
        }
    });

    $('button.btn-follow').click(function () {
        var following_id = $(this).attr('id');
        $.ajax({
            url: "/follow",
            method: "POST",
            data: {follow: following_id},
            complete: function (msg) {
//                alert(msg.responseText);
                $(location).attr('href', $(location).attr('href'));
            }
        })
    });

    $('button.btn-danger').click(function () {
        var following_id = $(this).attr('id');
        $.ajax({
            url: "/unfollow",
            method: "DELETE",
            data: {follow_id: following_id},
            complete: function (msg) {
//                alert(msg.responseText)
                $(location).attr('href', $(location).attr('href'));
            }
        })
    });

    var nav_active = $('li.col-md-4');

    nav_active.mousemove(function () {
        $(this).find('a').find('span.span').addClass('hover');
    });

    nav_active.mouseout(function () {
        $(this).find('a').find('span.span').removeClass('hover');
    });

    ta_for_tweet.keyup(function () {
        const max_len_tweet = 139;
        var count = $(this).val().length;
        count--;
        $('#counter').text(max_len_tweet - count);

        var disabled = count > max_len_tweet;
        $('#btn_add_tweet').attr('disabled', disabled);
    });


    var img_reply = $('img.reply');
    var img_retweet = $('img.retweet');
    var img_star = $('img.star');
    var img_points = $('img.points');

    img_reply.mousemove(function () {
        $(this).attr('src', '/img/replyH.png');
    });

    img_reply.mouseout(function () {
        $(this).attr('src', '/img/reply.png');
    });

    img_retweet.mousemove(function () {
        $(this).attr('src', '/img/retweetH.png');
    });

    img_retweet.mouseout(function () {
        $(this).attr('src', '/img/retweet.png');
    });

    img_star.mousemove(function () {
        $(this).attr('src', '/img/starH.png');
    });

    img_star.mouseout(function () {
        $(this).attr('src', '/img/star.png');
    });

    img_points.mousemove(function () {
        $(this).attr('src', '/img/pointsH.png');
    });

    img_points.mouseout(function () {
        $(this).attr('src', '/img/points.png');
    });

})
;