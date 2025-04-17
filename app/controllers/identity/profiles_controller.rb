class Identity::ProfilesController < ApplicationController
  def index
    set_page_and_extract_portion_from search_profiles, per_page: 10

    sleep 3.seconds unless @page.first?
  end

  def show
    @user = User.find_by!(name: params[:name])
    @chat = @user.participants.find_by(chat_key: set_chat_key)&.chat
  end

  private

    def search_profiles
      return User.order(:name) unless params[:name].present?
      User.search_by_name_or_tag(params[:name])
    end

    def set_chat_key
      [ Current.user.id, @user.id ].sort.join("-")
    end
end
