# frozen_string_literal: true

# internal use
class SessionsController < ApplicationController
  before_action :check_register, only: [:register, :register_post]
  before_action :check_recovery, only: [:recovery, :confirm_recovery]
  before_action :redirect_to_home, only: :login
  before_action :require_current_user, only: %i(profile profile_post profile_remove_video settings recovery logout confirm_recovery)

  def register
    @title = "Register"
  end

  def register_post
    profile = Profile.create!(profile_params)

    login_profile(profile)
    redirect_to recovery_sessions_path, notice: "Welcome"
  end

  def profile
    @title = "Profile"
  end

  def profile_post
    profile_params = params.require(:profile).permit(:name, :gender, :about, :country_code, :city_name, uploaded_file: {})
    uploaded_file_params = profile_params[:uploaded_file]

    uploaded_file = uploaded_file_params ? UploadsService::HandleSingleUpload.new(uploaded_file_params).call! : nil
    ProfileService::Update.new(uploaded_file, profile_params, current_user).call!

    redirect_to profile_sessions_path, notice: "Saved"
  end

  def profile_remove_video
    current_user.profile_video_attachment&.destroy

    redirect_to profile_sessions_path, notice: "Removed"
  end

  def settings
    @title = "Settings"
  end

  def login
    @title = "Login"

    recovery_key = params[:recovery_key]
    return if recovery_key.blank?

    profile = ProfileService::Authenticate.new(recovery_key).call!

    unless profile
      return redirect_to login_sessions_path, error: "Invalid login" if profile.blank?
    end

    login_profile(profile)
    redirect_to root_path
  end

  def login_post
    login_params = params.require(:login).permit(:recovery_code, :file)
    profile = ProfileService::Authenticate.new(login_params[:recovery_code]).call!

    unless profile
      flash[:error] = "Invalid code"
      return render :login
    end
    login_profile(profile)
    redirect_to root_path, notice: "Welcome"
  end

  def recovery
    @title = "Account Recovery"

    @recovery_key = current_user.recovery_key_plain
  end

  def logout
    session[:profile_recovery_key_digest] = nil
    redirect_to login_sessions_path, notice: "Logged out"
  end

  def confirm_recovery
    current_user.update!(recovery_key_plain: nil)
    redirect_to root_path, notice: "Done"
  end

  private
    def profile_params
      params.require(:profile).permit(:name, :username, :gender)
    end

    def check_register
      head 404 if (Profile.count > 0 && !Rails.env.development?) ||
        params[:login_token] != Rails.application.secrets.dig(:profile, :login_token)
    end

    def login_profile(profile)
      session[:profile_recovery_key_digest] = profile.recovery_key_digest
    end

    def check_recovery
      render json: { error: "recovery key already saved" }, status: 422 if current_user.recovery_key_plain.blank?
    end

    def redirect_to_home
      redirect_to root_path if signed_in?
    end
end
