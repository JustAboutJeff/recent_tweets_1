$(document).ready(function() {
  $("form#user_select").on('submit', function(e){
    $('div.tweet_container').empty();
    e.preventDefault();
    var data = $(this).serialize();
    $.post('/tweets', data, function(response){
      $(response).appendTo('div.tweet_container');
    }, "html");
  });
});
