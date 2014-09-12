$(document).ready(function () {

    $.ajaxSetup({
        beforeSend: function (xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        }
    });

    $('#taForTweet').addClass('no-expand');

    $('#taForTweet').focusin(function () {
        $(this).attr('rows', '4');
        $('#panelBtnAddTweet').attr('style', 'display: block');
        if ($(this).val().length == 0) {
            $('#btn_addTweet').attr("disabled", true);
        } else {
            $('#btn_addTweet').attr("disabled", false);
        }
    });
    $('#taForTweet').blur(function () {
        if ($(this).val().length == 0) {
            $('#taForTweet').attr('rows', '1');
            $('#panelBtnAddTweet').attr('style', 'display: none')
        }
    });

    $('a.del').click(function () {
        var user_id = $('#current_user_id').val();
        var tweet_id = $(this).attr('id');
        if (confirm("Delete this tweet?")) {
            $.ajax({
                url: "http://localhost:3000/delTweet",
                method: "DELETE",
                data: {user_id: user_id, tweet_id: tweet_id},
                complete: function (msg) {
                    if (msg.responseText == 'deleted') {
                        $(location).attr('href', $(location).attr('href'));
                    }
                }
            })
        }
    });

    $('button.btn-follow').click(function () {
        var user_id = $('#current_user_id').val();
        var following_id = $(this).attr('id');
        $.ajax({
            url: "http://localhost:3000/follow",
            method: "POST",
            data: {user: user_id, follow: following_id},
            complete: function (msg) {
//                alert(msg.responseText);
                $(location).attr('href', $(location).attr('href'));
            }
        })
    });

    $('button.btn-danger').click(function () {
        var user_id = $('#current_user_id').val();
        var following_id = $(this).attr('id');
        $.ajax({
            url: "http://localhost:3000/unfollow",
            method: "DELETE",
            data: {user_id: user_id, follow_id: following_id},
            complete: function (msg) {
//                alert(msg.responseText)
                $(location).attr('href', $(location).attr('href'));
            }
        })
    });

    $('li.col-md-4').mousemove(function () {
        $(this).find('a').find('span.span').addClass('hover')
    });

    $('li.col-md-4').mouseout(function () {
        $(this).find('a').find('span.span').removeClass('hover')
    });

    $('#taForTweet').keyup(function () {
//        var count = $('#counter').text();
        const len = 139;
        var count = $(this).val().length;
        count--;
        $('#counter').text(len - count);

        if (count > 139) {
            $('#btn_addTweet').attr("disabled", true);
        } else {
            $('#btn_addTweet').attr("disabled", false);
        }
    });

    $('img.reply').mousemove(function () {
        $(this).attr('src', '/img/replyH.png')
    });

    $('img.reply').mouseout(function () {
        $(this).attr('src', '/img/reply.png')
    });

    $('img.retweet').mousemove(function () {
        $(this).attr('src', '/img/retweetH.png')
    });

    $('img.retweet').mouseout(function () {
        $(this).attr('src', '/img/retweet.png')
    });

    $('img.star').mousemove(function () {
        $(this).attr('src', '/img/starH.png')
    });

    $('img.star').mouseout(function () {
        $(this).attr('src', '/img/star.png')
    })

    $('img.points').mousemove(function () {
        $(this).attr('src', '/img/pointsH.png')
    });

    $('img.points').mouseout(function () {
        $(this).attr('src', '/img/points.png')
    })

});