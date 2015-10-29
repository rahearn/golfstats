module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController

    skip_before_action    :verify_authenticity_token
    prepend_before_action :require_no_authentication, except: :developer
    before_action         :ensure_development,        only:   :developer
    before_action         :load_auth_and_user
    before_action         :set_attributes

    def open_id
      skip_authorization
      if @user.save || @user.persisted?
        sign_in_and_redirect @user
      else
        Rails.logger.error "Could not create new user: #{@user.errors.full_messages}"
        redirect_to new_user_session_path, alert: "There was a registration error. #{@user.errors.full_messages.join('. ')}."
      end
    end
    alias :google    :open_id
    alias :twitter   :open_id
    alias :facebook  :open_id
    alias :developer :open_id

    private

    def load_auth_and_user
      @auth = request.env["omniauth.auth"]
      Rails.logger.debug "omniauth.auth: #{@auth.inspect}"
      @user = User.find_or_initialize_by openid_uid: @auth.uid, openid_provider: @auth.provider
    end

    def set_attributes
      @user.remember_me = true
      @user.email       = @auth.info.email if @auth.info.email.present?
      @user.name        = @auth.info.name  if @auth.info.name.present?
    end

    def ensure_development
      head :forbidden unless Rails.env.development?
    end
  end
end
