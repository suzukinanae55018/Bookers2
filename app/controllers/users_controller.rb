class UsersController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
   if @book.save
     flash[:notice] = "Book was successfully created."
     redirect_to book_path(@book)
   else
     @books = Book.all
     @user = current_user
     render :index
   end
  end

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
  end

  def user_params
    params.require(:user).permit(:name, :introduction)
  end
end
