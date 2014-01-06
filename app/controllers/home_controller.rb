class HomeController < ApplicationController

  def index
    if !user_signed_in?
      redirect_to :user_session
    elsif !current_user.user_setting
      redirect_to :new_user_setting
    end
  end
end
