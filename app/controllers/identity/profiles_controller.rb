class Identity::ProfilesController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by!(name: params[:name])
  end
end
