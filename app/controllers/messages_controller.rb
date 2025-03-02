class MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: %i[ edit update destroy ]

  # GET /messages
  def index
    @messages = @chat.messages
  end

  def new
    @message = @chat.messages.build
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  def create
    @message = @chat.messages.build(message_params)

    if @message.save
      @message.broadcast_append_to(@chat, target: "messages", partial: "messages/message", locals: { chat: @chat, message: @message })

      redirect_to chat_messages_url(@chat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      @message.broadcast_replace_to(@chat, target: "message_#{@message.id}", partial: "messages/message", locals: { chat: @chat, message: @message })

      redirect_to chat_messages_url(@chat)
    else
      render :edit, status: :unprocessable_entity, status: :see_other
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy!
    @message.broadcast_remove_to(@chat, target: "message_#{@message.id}")

    redirect_to chat_messages_url(@chat), notice: "Message was successfully destroyed.", status: :see_other
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
