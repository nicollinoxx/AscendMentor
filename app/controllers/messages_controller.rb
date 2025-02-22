class MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: %i[ show edit update destroy ]

  # GET /messages
  def index
    @messages = @chat.messages
  end

  # GET /messages/1
  def show
  end

  # GET /messages/new
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
      @message.broadcast_append_later_to(@chat, target: 'messages', partial: 'messages/message')
      redirect_to chat_message_url(@chat, @message), notice: "Message was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      redirect_to chat_message_url(@chat, @message), notice: "Message was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy!
    redirect_to chat_messages_url(@chat), notice: "Message was successfully destroyed.", status: :see_other
  end

  private
    def set_chat
      @chat = Chat.find(params[:chat_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = @chat.messages.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.expect(message: [ :content ])
    end
end
