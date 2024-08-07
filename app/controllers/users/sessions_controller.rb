# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # devise継承
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: "guestuserでログインしました。"
  end
end
