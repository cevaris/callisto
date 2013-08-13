class SettingsController < ApplicationController

  before_filter :require_session


  def index
    @user = @current_user
    @setting = @current_user.setting

    respond_to do |format|
      format.html
    end
  end

  # PUT /settings/1
  # PUT /settings/1.json
  def update
    @setting = Setting.find(params[:id])

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        format.html { redirect_to settings_url, notice: 'Setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

end
