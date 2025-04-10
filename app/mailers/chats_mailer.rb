class ChatsMailer < ApplicationMailer
  def notify(chat, host, guest)
    @chat  = chat
    @host  = host
    @guest = guest
    mail subject: "New Chat", to: guest.email_address
  end
end
