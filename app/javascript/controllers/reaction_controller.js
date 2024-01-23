import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["button"];

  like(event) {
    event.preventDefault();
    const messageId = this.data.get("message-id");
    this.likeMessage(messageId);
  }

  likeMessage(messageId) {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    fetch('/rooms/${roomId}/messages/${messageId}/reactions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({
        message_id: messageId,
        user_id: userId,
        reaction_type: 'like'
      })
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => {
      console.log('Like added:', data);
      // 必要に応じてUIを更新
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }
}
