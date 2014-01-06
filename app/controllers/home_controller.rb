class HomeController < ApplicationController

  def index
    redirect_to :user_session unless user_signed_in?
  end
end
