class GroupsController < ApplicationController

  def new
    @group_form = GroupForm.new(current_user)
    authorize(@group_form.group)
  end

  def create
    @group_form = GroupForm.new(current_user)
    authorize(@group_form.group)
    if @group_form.submit(group_params, params[:group][:invitation_emails])
      redirect_to @group_form.group, notice: 'Group successfully created!'
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