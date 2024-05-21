class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
   if @book.save
     flash[:notice] = "You have created book successfully."
     redirect_to book_path(@book)
   else
     @books = Book.all
     @user = current_user
     render :index
   end
  end

  def index
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if@user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      flash[:notice]
      render :edit
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

   def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
   end

end
