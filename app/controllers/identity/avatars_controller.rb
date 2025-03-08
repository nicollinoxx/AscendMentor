class Identity::AvatarsController < ApplicationController
  include Identity::UserScoped

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to identity_account_path(@user), notice: "Avatar was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.avatar.purge

    redirect_to identity_account_path(@user), notice: "Avatar was successfully destroyed"
  end

  private

  def user_params
    params.permit(:avatar)
  end
end
