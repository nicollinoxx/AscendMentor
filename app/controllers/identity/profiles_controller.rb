class Identity::ProfilesController < ApplicationController
  def index
    set_page_and_extract_portion_from search_profiles, per_page: 10

    sleep 3.seconds unless @page.first?
  end

  def show
    @user = User.find_by!(name: params[:name])
  end

  private

    def search_profiles
      return User.order(:name) unless params[:name].present?
      User.joins(:tags).where("users.name LIKE ? OR tags.name LIKE ?", "#{params[:name]}%", "#{params[:name]}%").distinct.order(:name)
    end
end
