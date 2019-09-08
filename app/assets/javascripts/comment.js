// 非同期でコメント送信
$(document).on('turbolinks:load', function() {
  $(function(){
    function buildHTML(comment){
      var html = `<div class="comment" data-comment-id="${comment.id}">
                    <strong>
                      <a href=/users/${comment.user_id}>${comment.user_name}</a>
                      ：
                    </strong>
                      ${comment.text}
                    <li>
                      <a href=/tweets/${comment.tweet_id}/comments/${comment.id}/edit class="ajax_edit_button">
                        編集
                      </a>
                    </li>
                    <li class="ajax_delete_button" data-tweet-id="${comment.tweet_id}" data-comment-id="${comment.id}" method="delete">
                      削除
                    </li>
                  </div>`
      return html;
    }
    $('#new_comment').on('submit', function(e){
      e.preventDefault();
      var formData = new FormData(this);
      var url = $(this).attr('action')
      $.ajax({
        url: url,
        type: "POST",
        data: formData,
        dataType: 'json',
        processData: false,
        contentType: false
      })
      .done(function(comment){
        if (comment.text === ""){
          alert('テキストを入力してください!');
          $('.btn').prop('disabled', false);
        } else {
        var html = buildHTML(comment);
        $('.comments').append(html)
        $("#new_comment")[0].reset();
        $('.btn').prop('disabled', false);
        $('.comments').animate({ scrollTop: $('.comments')[0].scrollHeight}, 'fast');
        }
      })
    })
  });
});

// 非同期でコメント削除
$(function(){
  $(document).on("click",".ajax_delete_button",function(){
    var get_tweet_id = $(this).attr('data-tweet-id');
    var get_comment_id = $(this).attr('data-comment-id');
    $.ajax({
      url: '/tweets/' + get_tweet_id + '/comments/' + get_comment_id,
      type: 'POST',
      data: {'id': get_comment_id,
              '_method': 'DELETE'}
    })
  });
});

// コメントの自動更新
$(function(){
  function buildHTML(comment){
    var html = `<div class="comment" data-comment-id="${comment.id}">
                  <strong>
                    <a href=/users/${comment.user_id}>${comment.user_name}</a>
                    ：
                  </strong>
                    ${comment.text}
                </div>`
    return html;
  }
  var reloadComments = function() {
    if (window.location.href.match(/\/tweets\/\d+/)){
      var last_comment_id = $('.comment') ? $('.comment:last').data('comment-id') : 0;
      var get_tweet_id = $('.comment').attr('data-tweet-id');
      $.ajax({
        url: "/api/tweets/" + get_tweet_id, 
        type: 'GET',
        dataType: 'json',
        data: {last_id: last_comment_id},
      })
      .done(function(comments){
        var insertHTML = '';
        comments.forEach(function(comment){
          insertHTML = buildHTML(comment);
          $('.comments').append(insertHTML);
        });
        $('.comments').animate({scrollTop: $('.comments')[0].scrollHeight}, 'fast');
      })
      // .fail(function() {
      //   alert('自動更新に失敗しました');
      // });
    };
  };
  setInterval(reloadComments, 5000);
});