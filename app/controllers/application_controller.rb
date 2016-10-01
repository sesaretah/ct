class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!, :except => [:after_sign_in_path_for,:after_inactive_sign_up_path_for,     :after_sign_up_path_for]
 before_filter :configure_permitted_parameters, if: :devise_controller?

 def configure_permitted_parameters

 end

 def after_sign_in_path_for(user)
   if !user.profile.blank?
     root_path
   else
     '/registeration_steps?step=1'
   end
 end

 def after_sign_up_path_for(user)
   if !user.profile.blank?
     root_path
   else
     '/registeration_steps?step=1'
   end
 end

 def after_inactive_sign_up_path_for(user)
   if !user.profile.blank?
     root_path
   else
     '/registeration_steps?step=1'
   end
 end

  layout :layout_by_resource

  require 'jalali_date'
  require 'remote_link_pagination_helper'
  protected

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
