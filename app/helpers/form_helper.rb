module FormHelper

  def handle_errors(object)
    flash.now[:alert] = raw(object.errors.full_messages.join('<br />'))
  end

end