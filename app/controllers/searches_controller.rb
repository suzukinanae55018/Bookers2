# frozen_string_literal: true

class SearchesController < ApplicationController
  before_action :authenticate_user!
  # ログイン状態でしか使えない,rangeはviewで作ったカラム
  def search
    @range = params[:range]

    @users = User.looks(params[:search], params[:word])
    @books = Book.looks(params[:search], params[:word])
  end
end
