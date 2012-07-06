module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController

    prepend_before_filter :require_no_authentication, except: :developer
    before_filter         :ensure_development,        only:   :developer
    before_filter         :load_auth_and_user
    skip_authorization_check

    def open_id
      @user.email = @auth.info.email if @auth.info.email.present?
      @user.name  = @auth.info.name  if @auth.info.name.present?
      if @user.save || @user.persisted?
        sign_in_and_redirect @user
      else
        Rails.logger.error "Could not create new user: #{@user.errors.full_messages}"
        redirect_to new_user_session_path, alert: "There was an error registering you. #{@user.errors.full_messages.join('. ')}."
      end
    end
    alias :google    :open_id
    alias :developer :open_id

    private

    def load_auth_and_user
      @auth = request.env["omniauth.auth"]
      Rails.logger.debug "omniauth.auth: #{@auth.inspect}"
      @user = User.find_or_initialize_by_openid_uid @auth.uid
      @user.remember_me = true
    end

    def ensure_development
      head :forbidden unless Rails.env.development?
    end
  end
end
