$(document).ready(function () {

    $.ajaxSetup({
        beforeSend: function (xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        }
    });

    var ta_forTweet = $('#ta_for_tweet');

    ta_forTweet.addClass('no-expand');

    ta_forTweet.focusin(function () {
        $(this).attr('rows', '4');
        $('#panel_btn_add_tweet').attr('style', 'display: block');
        var disabled = $(this).val().length == 0;
        $('#btn_add_tweet').attr("disabled", disabled);
    });

    ta_forTweet.blur(function () {
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

    var navActive = $('li.col-md-4');

    navActive.mousemove(function () {
        $(this).find('a').find('span.span').addClass('hover');
    });

    navActive.mouseout(function () {
        $(this).find('a').find('span.span').removeClass('hover');
    });

    ta_forTweet.keyup(function () {
        const max_len_tweet = 139;
        var count = $(this).val().length;
        count--;
        $('#counter').text(max_len_tweet - count);

        var disabled = count > max_len_tweet;
        $('#btn_add_tweet').attr('disabled', disabled);
    });


    var imgReply = $('img.reply');
    var imgRetweet = $('img.retweet');
    var imgStar = $('img.star');
    var imgPoints = $('img.points');

    imgReply.mousemove(function () {
        $(this).attr('src', '/img/replyH.png');
    });

    imgReply.mouseout(function () {
        $(this).attr('src', '/img/reply.png');
    });

    imgRetweet.mousemove(function () {
        $(this).attr('src', '/img/retweetH.png');
    });

    imgRetweet.mouseout(function () {
        $(this).attr('src', '/img/retweet.png');
    });

    imgStar.mousemove(function () {
        $(this).attr('src', '/img/starH.png');
    });

    imgStar.mouseout(function () {
        $(this).attr('src', '/img/star.png');
    });

    imgPoints.mousemove(function () {
        $(this).attr('src', '/img/pointsH.png');
    });

    imgPoints.mouseout(function () {
        $(this).attr('src', '/img/points.png');
    });

})
;