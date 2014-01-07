class UserSettingsController < ApplicationController
  def new
    settings = prep_settings(UserSetting.new)

    @user_settings = settings
  end

  def create
    if(UserSetting.create(user_settings_params))
      redirect_to :root, notice: "Your settings were updated"
    else
      render :new
    end
  end

  def edit
    @user_settings = prep_settings(current_user.user_setting)
  end

  def update
    settings = UserSetting.find(params[:id])

    if params[:user_setting][:harvest_password].blank?
      params[:user_setting].delete(:harvest_password)
    end

    if(settings.update(user_settings_params))
      redirect_to :root, notice: "Your settings were updated"
    else
      render :new
    end
  end

private

  def prep_settings(settings)
    settings.project_mappings.build if settings.project_mappings.empty?
    settings
  end

  def user_settings_params
    params[:user_setting][:user_id] = current_user.id
    params.require(:user_setting) \
      .permit(
        :user_id,
        :tracker_full_name,
        :tracker_api_token,
        :harvest_organization,
        :harvest_username,
        :harvest_password,
        project_mappings_attributes: [
          :id,
          :external_project_id,
          :harvest_project_id,
          :harvest_task_id ])
  end
end
