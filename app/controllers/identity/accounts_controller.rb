class Identity::AccountsController < ApplicationController
  include Identity::UserScoped

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to identity_account_path(@user), notice: "Profile was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

    def user_params
      params.expect(user: [ :name ])
    end
end
