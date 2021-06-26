class UsersController < ApplicationController
  before_action :authenticate_user!



  def show
    @user = User.find_by(id: current_user.id)
    @tag_list = current_user.tags.all
    @wishes = current_user.wishes.all
  end

  def edit
    @user = User.find_by(id: current_user.id)
  end

  def update
    @user = User.find_by(id: current_user.id)
    @user.update_attributes(user_params)
    if @user.save
      flash[:notice] = '会員情報の更新が完了しました'
      redirect_to users_path
    else
      @customer.attributes = user_params
      flash[:failed] = '会員情報の更新が失敗しました。'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_image_id, :introduction, :email)
  end
end
