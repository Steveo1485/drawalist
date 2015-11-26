class ListItemsController < ApplicationController

  def create
    @list_item = ListItem.new(list_item_params)
    authorize(@list_item)
    respond_to do |format|
      if @list_item.save
        format.html { redirect_to user_root_path, notice: 'Item added to list!'}
      else
        format.html { redirect_to user_root_path, alert: 'Something went wrong. Please try again.'}
      end
    end
  end

  private

  def list_item_params
    params.require(:list_item).permit(:list_id, :name, :url)
  end

end