class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if session[:group_token].present?
      new_membership_path(token: session.delete(:group_token))
    else
      super
    end
  end
end