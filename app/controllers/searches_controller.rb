class SearchesController < ApplicationController
   before_action :authenticate_user!

  def search
    @range = params[:range]

      @users = User.looks(params[:search], params[:word])
      @books = Book.looks(params[:search], params[:word])

  end
end
