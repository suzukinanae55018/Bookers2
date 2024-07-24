# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    # 通知の種類によるリダイレクトパスの生成条件分岐
    case notification.notifiable_type
    when "Book"
      redirect_to book_path(notification.notifiable)
    else
      redirect_to user_path(notification.notifiable.user)
    end
  end
end
