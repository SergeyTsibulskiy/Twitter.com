$(document).ready(function(){
    var current_url = $(location).attr('pathname');

    $('.left a').each(function (key, value){
        if ($(value).attr('href') == current_url) {
            $(value).parent().addClass('active');
        }
    });

});