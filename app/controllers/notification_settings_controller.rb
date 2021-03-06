class NotificationSettingsController < ApplicationController
  before_action :set_notification_setting, only: [:show, :edit, :update, :destroy]

  # GET /notification_settings
  # GET /notification_settings.json
  def index
    @notification_settings = NotificationSetting.all
  end

  # GET /notification_settings/1
  # GET /notification_settings/1.json
  def show
  end

  # GET /notification_settings/new
  def new
    @notification_setting = NotificationSetting.new
  end

  # GET /notification_settings/1/edit
  def edit
  end

  # POST /notification_settings
  # POST /notification_settings.json
  def create
    @notification_setting = NotificationSetting.new(notification_setting_params)
    @notification_setting.user_id = current_user.id
    respond_to do |format|
      if @notification_setting.save
        @profile = @notification_setting.user.profile
        @profile.digest_email = params[:digest_email]
        @profile.save
        format.html { redirect_to '/profiles?profile_id=' + @notification_setting.user.profile.id.to_s , notice: 'Notification setting was successfully created.' }
        format.json { render :show, status: :created, location: @notification_setting }
      else
        format.html { render :new }
        format.json { render json: @notification_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notification_settings/1
  # PATCH/PUT /notification_settings/1.json
  def update
    respond_to do |format|
      if @notification_setting.update(notification_setting_params)
        @profile = @notification_setting.user.profile
        @profile.digest_email = params[:digest_email]
        @profile.save
        format.html { redirect_to '/profiles?profile_id=' + @notification_setting.user.profile.id.to_s , notice: 'Notification setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @notification_setting }
      else
        format.html { render :edit }
        format.json { render json: @notification_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notification_settings/1
  # DELETE /notification_settings/1.json
  def destroy
    @notification_setting.destroy
    respond_to do |format|
      format.html { redirect_to notification_settings_url, notice: 'Notification setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification_setting
      @notification_setting = NotificationSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_setting_params
      params.require(:notification_setting).permit(:user_id, :channel_updates, :involvement, :blog_updates, :group_updates, :grouping, :event_updates, :participation, :question_updates, :question_comments, :answers_comments, :project_task, :partnership, :offsession, :membership, :announcement, :contribution, :research_ranking, :research_comments, :poll, :messages)
    end
end
