$(document).ready(function () {

    $.ajaxSetup({
        beforeSend: function (xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        }
    });

    var ta_forTweet = $('#taForTweet');

    ta_forTweet.addClass('no-expand');

    ta_forTweet.focusin(function () {
        $(this).attr('rows', '4');
        $('#panelB' +
            'tnAddTweet').attr('style', 'display: block');
        if ($(this).val().length == 0) {
            $('#btn_addTweet').attr("disabled", true);
        } else {
            $('#btn_addTweet').attr("disabled", false);
        }
    });
    ta_forTweet.blur(function () {
        if ($(this).val().length == 0) {
            $('#taForTweet').attr('rows', '1');
            $('#panelBtnAddTweet').attr('style', 'display: none')
        }
    });

    $('a.del').click(function () {
        var tweet_id = $(this).attr('id');
        if (confirm("Delete this tweet?")) {
            $.ajax({
                url: "http://localhost:3000/delTweet",
                method: "DELETE",
                data: {tweet_id: tweet_id},
                complete: function (msg) {
                    if (msg.responseText == 'deleted') {
                        alert('deleted');
                        $(location).attr('href', $(location).attr('href'));
                    }
                }
            })
        }
    });

    $('button.btn-follow').click(function () {
        var following_id = $(this).attr('id');
        $.ajax({
            url: "http://localhost:3000/follow",
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
            url: "http://localhost:3000/unfollow",
            method: "DELETE",
            data: {follow_id: following_id},
            complete: function (msg) {
//                alert(msg.responseText)
                $(location).attr('href', $(location).attr('href'));
            }
        })
    });

    var navActiv = $('li.col-md-4');

    navActiv.mousemove(function () {
        $(this).find('a').find('span.span').addClass('hover')
    });

    navActiv.mouseout(function () {
        $(this).find('a').find('span.span').removeClass('hover')
    });

    ta_forTweet.keyup(function () {
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


    var imgReply = $('img.reply');
    var imgRetweet = $('img.retweet');
    var imgStar =  $('img.star');
    var imgPoints = $('img.points');

    imgReply.mousemove(function () {
        $(this).attr('src', '/img/replyH.png')
    });

    imgReply.mouseout(function () {
        $(this).attr('src', '/img/reply.png')
    });

    imgRetweet.mousemove(function () {
        $(this).attr('src', '/img/retweetH.png')
    });

    imgRetweet.mouseout(function () {
        $(this).attr('src', '/img/retweet.png')
    });

    imgStar.mousemove(function () {
        $(this).attr('src', '/img/starH.png')
    });

    imgStar.mouseout(function () {
        $(this).attr('src', '/img/star.png')
    });

    imgPoints.mousemove(function () {
        $(this).attr('src', '/img/pointsH.png')
    });

    imgPoints.mouseout(function () {
        $(this).attr('src', '/img/points.png')
    })

});