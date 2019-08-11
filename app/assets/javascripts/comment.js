$(function(){
    function buildHTML(comment){
      var html = `<div class="comment">
                    <p data-p-comment-id="${comment.id}">
                      <strong>
                        <a href=/users/${comment.user_id}>${comment.user_name}</a>
                        ：
                      </strong>
                      ${comment.text}
                      <a href=/tweets/${comment.tweet_id}/comments/${comment.id}/edit class="ajax_edit_button" >編集</a>
                      <span class="ajax_delete_button" data-tweet-id="${comment.tweet_id}" data-comment-id="${comment.id}" method="delete" >削除</span>
                    </p>
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
        $('.comments').animate({ scrollTop: $('.comments')[0].scrollHeight});
        }
      })
    })
  // 非同期通信でコメント削除
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
