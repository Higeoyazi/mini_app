$(document).on('turbolinks:load', function() {

    $(function() {

    // 関数の定義
      var search_list = $(".append-search-user");

      function appendUser(user) {
        var html = `<div class="search_user" data-user-id="${user.id}">
                      <strong>
                        <a href=/users/${user.id}>${user.name}</a>
                      </strong>
                    </div>`
        search_list.append(html);
      }

      function appendErrMsgToHTML(nothing) {
        var html = `<div class="nothing-search-user">${nothing}</div>`
        search_list.append(html);
      }

    // インクリメンタルサーチのイベント発火
      $(".search__query").on("keyup", function() {
        var input = $(".search__query").val();
        $(".user").remove();
        $(".nothing-search-user").remove();
        $.ajax({
          type: 'GET',
          url: '/users/search',
          data: { keyword: input },
          dataType: 'json'
        })
    // jsonデータの処理
        .done(function(users) {
          $(".append-search-user").empty();
          if (users.length !== 0) {
            users.forEach(function(user){
              appendUser(user);
            });
          }
          else {
            appendErrMsgToHTML("一致するユーザーはいません");
          }
        })

        .fail(function() {
          alert('映画検索に失敗しました');
        })

      })

    });

});