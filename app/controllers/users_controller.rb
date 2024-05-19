class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
  end
  
  def user_params
    params.require(:user).permit(:name, :introduction)
  end
end
