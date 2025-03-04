class Identity::ProfilesController < ApplicationController
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
      redirect_to identity_profile_path(@user.name), notice: 'Profile was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

    def set_user
      @user = User.find_by(name: params[:name])
    end

    def user_params
      params.expect(user: [:name])
    end
end
