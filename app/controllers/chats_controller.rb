class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show edit update destroy ]
  before_action :set_participants, only: %i[ create ]

  # GET /chats
  def index
    @chats = Current.user.chats
  end

  # GET /chats/1
  def show
  end

  # GET /chats/new
  def new
    @chat = Chat.new
  end

  # GET /chats/1/edit
  def edit
  end

  # POST /chats
  def create
    @chat = Chat.new(chat_params)
    @participants = [ @chat.participants.build(user_id: @host.id), @chat.participants.build(user_id: @guest.id) ]

    if @chat.save
      @participants.each(&:save)
      redirect_to @chat, notice: "Chat was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /chats/1
  def update
    if @chat.update(chat_params)
      redirect_to @chat, notice: "Chat was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    @chat.destroy!
    redirect_to chats_path, notice: "Chat was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.expect(chat: [ :title ])
    end

    def set_participants
      @host = Current.user
      @guest = User.find_by!(name: params[:name])

      rescue ActiveRecord::RecordNotFound
        redirect_to root_path, alert: "Profile not found."
    end
end
