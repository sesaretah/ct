class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  before_filter :authenticate_user!, :except => [:after_sign_in_path_for,:after_inactive_sign_up_path_for,     :after_sign_up_path_for]
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def base64_url_decode(str)
    str += '=' * (4 - str.length.modulo(4))
    Base64.decode64(str.tr('-_','+/'))
  end
  def decrypt(text, secret, iv )
    cipher = OpenSSL::Cipher.new 'aes-256-cbc'
    cipher.decrypt
    @secret = OpenSSL::PKCS5.pbkdf2_hmac(secret, 'salt', 1, 32, OpenSSL::Digest::SHA512.new)
    cipher.key = @secret
    cipher.iv = Base64.decode64 iv.gsub(/\s/,'+').encode('ascii-8bit')
    @enc = Base64.decode64 text.gsub(/\s/,'+').encode('ascii-8bit')
    #@enc = text.encode('ascii-8bit')
    @decrypted = cipher.update @enc
    @decrypted << cipher.final
    return @decrypted
  end
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
