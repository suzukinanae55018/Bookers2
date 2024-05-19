class BooksController < ApplicationController

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
     @user = current_user
     render 'homes/about'
    # 後で変える
   end
  end

  def index
   @books = Book.all
   @book = Book.new
   @user = current_user
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
