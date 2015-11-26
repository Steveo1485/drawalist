class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:new]

  def new
    @user = User.new
    authorize(@user)
    redirect_to root_path and return unless params[:token].present?
    if current_user
      redirect_to new_membership_path(token: params[:token])
    else
      session[:group_token] = params[:token]
    end
  end

  def show
    @user = current_user
    authorize(@user)
  end

end