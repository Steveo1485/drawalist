class ListItem < ActiveRecord::Base

  belongs_to :list

  validates :list_id, numericality: true
  validates :name, presence: true

  def user
    list.user
  end

end