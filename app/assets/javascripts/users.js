$(document).ready(function () {

    $('#taForTweet').addClass('no-expand');

    $('#taForTweet').focusin(function () {
        $('#taForTweet').attr('rows', '4')
    });
    $('#taForTweet').blur(function () {
        $('#taForTweet').attr('rows', '1')
    });

    $('a.del').click(function () {
        var user_id = $('#current_user_id').val();
        var tweet_id = $(this).attr('id');

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
    })

    $('li.col-md-4').mousemove(function () {
        $(this).find('a').find('span.span').addClass('hover')
    });

    $('li.col-md-4').mouseout(function () {
        $(this).find('a').find('span.span').removeClass('hover')
    })

    $('#taForTweet').keyup(function () {
//        var count = $('#counter').text();
        const len = 140;
        var count = $(this).val().length;
        count--;
        $('#counter').text(len - count);

        if (count <= 0) {
            $('btn_addTweet').attr("disabled", true);
        }
    })

});