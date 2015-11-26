class MembershipsController < ApplicationController

  def new
    @membership = Membership.new(user: current_user)
    authorize(@membership)
    if params[:token].present? &&  group = Group.find_by(token: params[:token])
      @membership.group = group
    end
  end

  def create
    @membership = Membership.new(user: current_user)
    authorize(@membership)
    if group = Group.find_by(token: params[:membership][:group_token])
      @membership.group = group
      if @membership.save
        redirect_to user_root_path, notice: 'Successfully join group!'
      else
        render :new
      end
    else
      redirect_to new_membership_path, alert: 'Invalid group token. Please try again.'
    end
  end
end