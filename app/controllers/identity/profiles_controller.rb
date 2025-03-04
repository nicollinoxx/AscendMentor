class Identity::ProfilesController < ApplicationController
  before_action :set_user, except: %i[ index ]
  before_action :must_be_owner, only: %i[ edit update ]

  def index
    @user = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to identity_profile_path(@user.name), notice: 'Profile was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

    def set_user
      @user = User.find_by(name: params[:name])
    end

    def must_be_owner
      redirect_to root_url unless is_owner?
    end

    def user_params
      params.require(:user).permit(:name)
    end
end
