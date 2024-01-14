// メッセージを最新の投稿が表示されるように自動でスクロールしておく
document.addEventListener("turbolinks:load", function() {
    var messagesContainer = document.getElementById("messages");
    if (messagesContainer) {
      messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
});
