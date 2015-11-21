module FormHelper

  def handle_errors(object)
    if object.errors.any?
      flash.now[:alert] = raw(object.errors.full_messages.join('<br />'))
    end
  end

end