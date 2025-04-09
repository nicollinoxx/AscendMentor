class Identity::TagsController < ApplicationController
  include Identity::UserScoped
  before_action :set_tag, only: %i[ edit update destroy ]

  def new
    @tag = @user.tags.build
  end

  def edit
    @tag = @user.tags.find(params[:id])
  end

  def create
    @tag = @user.tags.build(tag_params)

    respond_to do |format|
      if @tag.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag.destroy
    redirect_to identity_account_path(@user), notice: "Tag was successfully destroyed."
  end

  private

    def set_tag
      @tag = @user.tags.find(params[:id])
    end

    def tag_params
      params.expect(tag: [ :name ])
    end
end
