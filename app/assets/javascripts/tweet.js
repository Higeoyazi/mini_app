// ツイートにマウスカーソルを合わせた時にスタイルが変更する
$(document).on('turbolinks:load', function() {
  $(function(){
    $(".contents").on("mouseover", ".message", function(){
      $(this).css({"background-color": "#F1940B", "font-weight": "bold"});
    }).on("mouseout", ".message", function(){
      $(this).css({"background-color": "#FFFFFF", "font-weight": "normal"});
    })
  });
});
