class PagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def home
    redirect_to user_root_path and return if current_user
  end

end