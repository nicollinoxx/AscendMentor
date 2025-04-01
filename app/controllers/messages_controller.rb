class MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: %i[ edit update destroy ]

  # GET /messages
  def index
    @participant = @chat.users.where.not(id: Current.user.id).first
    set_page_and_extract_portion_from @chat.messages.order(created_at: :desc), per_page: 30

    sleep 4.seconds unless @page.first?
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  def create
    @message = @chat.messages.build(message_params)
    @message.user_id = Current.user.id

    if @message.save
      @message.broadcast_prepend_to(@chat, partial: "messages/message", locals: { chat: @chat, message: @message })
      render turbo_stream: turbo_stream.update("new_message", partial: "messages/form", locals: { message: @chat.messages.build })
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      @message.broadcast_replace_to(@chat, target: "message_#{@message.id}", partial: "messages/message", locals: { chat: @chat, message: @message })
      render turbo_stream: turbo_stream.update("new_message", partial: "messages/form", locals: { message: @chat.messages.build })
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy!
    @message.broadcast_remove_to(@chat, target: "message_#{@message.id}")
    render turbo_stream: turbo_stream.update("new_message", partial: "messages/form", locals: { message: @chat.messages.build })
  end

  private
    def set_chat
      @chat = Chat.find(params[:chat_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = @chat.messages.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.expect(message: [ :content ])
    end
end
