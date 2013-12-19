#jQuery ->
#  window.chatController = new Chat.Controller('localhost:3000/websocket', true);

window.Chat = {}

class Chat.Controller

  constructor: (url,useWebSockets) ->
    @messageQueue = []
    @dispatcher = new WebSocketRails(url,useWebSockets)
    @dispatcher.on_open = @createGuestUser 
    @bindEvents()

  bindEvents: =>
    @dispatcher.bind 'new_message', @newMessage
    @dispatcher.bind 'user_list', @userListMessage
    $('#send').on 'click', @sendMessage

  newMessage: (message) =>
    @messageQueue.push message
    @appendMessage message

  userListMessage: (message) =>
    console.log('ccc');

  sendMessage: (event) =>
    event.preventDefault()
    message = $('#message').val()
    @dispatcher.trigger 'new_message', {user_name: $('#__current_user').val() + '', msg_body: message}

  appendMessage: (message) ->
    messageTemplate = @template(message)
    $('#__histories').append messageTemplate

  createGuestUser: =>
    console.log('bbb');
    @dispatcher.trigger 'new_user', { user_id: $('#__current_user').val() + '' }

  template: (message) ->
    html =
      """
      <li>
        <img class="gravatar" src="https://secure.gravatar.com/avatar/012b99e0db096f19a89c1ca1252b569c" alt="#{message.user_name}"></img>
        <a href="/users/2">#{message.user_name}</a>
        <span class="content">#{message.msg_body}</span>
        <span class="timestamp">#{message.received}</span>
      </li>
      """
    $(html)
