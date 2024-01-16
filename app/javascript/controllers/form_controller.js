import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // ページがロードされた時に、コンソールにログを出す、最新の投稿までスクロール
  connect() {
    console.log("Loaded form controller!")
    this.scrollToBottom();
  }

  // メッセージBOXの内容をリセット、最新の投稿までスクロール
  reset() {
    this.element.reset();
    // 最新投稿を考慮し、500ms後にスクロール(本来であれば、DOM監視が望ましい)
    setTimeout(() => {
      this.scrollToBottom();
    }, 500);
  }

  scrollToBottom() {
    var messagesContainer = document.getElementById("messages");
    if (messagesContainer) {
      messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
  }
}
