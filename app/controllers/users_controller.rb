# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

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
    @today_post_count = @user.books.where("created_at >= ?", Time.zone.now.beginning_of_day).count
    @yesterday_post_count = @user.books.where(created_at: Date.yesterday.all_day).count

    end_of_week = Date.today.beginning_of_day # 本日の開始時間を終点に指定する
    start_of_week = end_of_week - 6.days # 1週間前の日付を起点にする
    @weekly_post_count = @user.books.where(created_at: start_of_week..end_of_week).count

    last_week_end = Date.today.beginning_of_day - 1.week # 先週の終了日を取得
    last_week_start = last_week_end - 6.days # 先週の開始日を取得
    @last_weekly_post_count = @user.books.where(created_at: last_week_start..last_week_end).count

    if @yesterday_post_count != 0
      @ratio = (@today_post_count.to_f / @yesterday_post_count.to_f) * 100
    else
      @ratio = 0
    end

    if @last_weekly_post_count != 0
      @weekly_ratio = ((@weekly_post_count.to_f / @last_weekly_post_count.to_f) * 100).to_i.to_s + "%"
    else
      @weekly_ratio = "0%"
    end

    @dates = []
    @posts_counts = []

    7.times do |i|
      date = Date.today - i.days
      days_ago = (Date.today - date).to_i
      formatted_date = "#{days_ago}日前"
      @dates << formatted_date
      post_count = @user.books.where("DATE(created_at) = ?", date).count
      @posts_counts << post_count
    end
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      flash[:notice]
      render :edit
    end
  end

  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日付を選択してください"
    else
      create_at = params[:created_at]
      @search_book = @books.where(["created_at LIKE ? ", "#{create_at}%"]).count
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
