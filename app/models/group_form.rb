class GroupForm
  include ActiveModel::Model
  include ActiveModel::Validations

  GROUP_FIELDS = [:name]

  delegate *GROUP_FIELDS, to: :group

  validates :name, presence: true

  def self.model_name
    ActiveModel::Name.new(self, nil, 'Group')
  end

  def initialize(current_user, group = nil)
    @user = current_user
    @group = group
  end

  def group
    @group ||= Group.new(user_id: @user.id)
  end

  def submit(group_params, emails_for_invitations)
    group.name = group_params[:name]
    begin
      if valid?
        group.transaction do
          group.save!
          Invitation.send_invites!(group, emails_for_invitations)
        end
        return true
      else
        return false
      end
    rescue ActiveRecord::RecordInvalid => e
      add_errors(e.record)
      return false
    end
  end

  private

  def add_errors(object)
    object.errors.messages.each { |attr, msg| self.errors.add(attr, msg.uniq.join) }
  end

end