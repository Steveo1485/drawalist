class GroupsController < ApplicationController

  def new
    @group = Group.new
    authorize(@group)
  end

  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id
    authorize(@group)
    if @group.save
      redirect_to @group, notice: 'Group successfully created!'
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    authorize(@group)
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

end