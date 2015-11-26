class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:new]

  def new
    @user = User.new
    authorize(@user)
    redirect_to root_path and return unless params[:token].present?
    redirect_to new_membership_path(token: params[:token]) and return if current_user
  end

  def show
    @user = current_user
    authorize(@user)
  end

end