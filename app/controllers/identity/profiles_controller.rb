class Identity::ProfilesController < ApplicationController
  include Identity::UserScoped
  before_action :set_user, except: %i[ index ]
  def index
    @user = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to identity_profile_path(@user), notice: 'Profile was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

    def user_params
      params.require(:user).permit(:name)
    end
end
