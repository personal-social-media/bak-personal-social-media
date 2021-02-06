# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :check_register, only: [:register, :register_post]
  before_action :check_recovery, only: [:recovery, :confirm_recovery]

  def register
    @title = "Register"
  end

  def register_post
    profile = Profile.create!(profile_params)

    session[:user_id] = profile.id
    redirect_to recovery_sessions_path, notice: "Welcome"
  end

  def profile
    @title = "Profile"
  end

  def profile_post
    profile_params = params.require(:profile).permit(:image, :name, :gender, :about, :country_code, :city_name)
    ProfileService::Update.new(profile_params, current_user).call!
    redirect_to profile_sessions_path, notice: "Saved"
  rescue
  end

  def settings
    @title = "Settings"
  end

  def login
    @title = "Login"

    recover_key = params[:recover_key]
    return if recover_key.blank?

    profile = Profile.find_by(recover_key: recover_key)

    return flash[:notice] = "Invalid login" if profile.blank?

    session[:user_id] = profile.id
    redirect_to root_path
  end

  def login_post
    login_params = params.require(:login).permit(:recovery_code, :file)
    profile = Profile.find_by(recover_key: login_params[:recovery_code])

    unless profile
      flash[:notice] = "Invalid code"
      return render :login
    end

    redirect_to root_path, notice: "Welcome"
  end

  def recovery
    @title = "Account Recovery"

    @recover_key = current_user.recover_key
  end

  def logout
    session[:user_id] = nil
    redirect_to login_sessions_path, notice: "Logged out"
  end

  def confirm_recovery
    current_user.update!(recover_key_saved: true)
    redirect_to root_path, notice: "Done"
  end

  private
    def profile_params
      params.require(:profile).permit(:name, :username, :gender)
    end

    def check_register
      head 404 if Profile.count > 0 ||
        params[:login_token] != Rails.application.secrets.dig(:profile, :login_token)
    end

    def check_recovery
      head 404 if current_user.recover_key_saved?
    end
end
