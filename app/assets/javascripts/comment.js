
    $(function(){
      function buildHTML(comment){
        var html = `<div class comment_user>
                      <p data-p-comment-id="${comment.id}">
                        <strong>
                          <a href=/users/${comment.user_id}>${comment.user_name}</a>
                          ：
                        </strong>
                        ${comment.text}
                        <li class="edit_button" >
                          <a href=/tweets/${comment.tweet_id}/comments/${comment.id}>編集</a>
                        </li>
                        <li class="delete_button" data-comment-id="${comment.id}">削除</li>
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
          var html = buildHTML(comment);
          $('.comments').append(html)
          $('.textbox').val('')
          $('.btn').prop('disabled', false);
          })
        })
        // .fail(function(){
        //   alert('error');
        // })
        // 非同期通信後の処理の途中
      $(document).on("click",".delete_button",function(){
        $(this).parent().remove();

        }

      );
      
    });
