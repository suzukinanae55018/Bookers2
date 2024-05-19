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
     @books = Book.all
     @user = current_user
     render :index
    # @books = Book.allがrenderに必要
   end
  end

  def index
   @books = Book.all
   @book = Book.new
   @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
