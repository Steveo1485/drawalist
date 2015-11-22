class GroupDecorator < Draper::Decorator
  delegate_all

  def display_name
    if h.current_user == model.admin_user
      h.raw("#{model.name} #{h.content_tag(:span, '(Administrator)', class: 'group-admin-title')}")
    else
      model.name
    end
  end

end
