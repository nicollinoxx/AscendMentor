class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.build_user_detail

    if @user.save
      start_new_session_for @user
      redirect_to root_url, notice: "Succefully created account"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
    end
end
