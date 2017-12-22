class ChannelsController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show, :view_remote, :search]
  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  def search
    if !params[:q].blank?
      @channels = Channel.where("name LIKE ? OR description LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    if params[:user_id].blank?
      @activity =  Activity.create(user_id: current_user.id, activity_type: 'Search', target_type: 'Channel')
    end
    respond_to do |format|
      format.html
      format.js
      format.json
    end
  end


  def join
    @channel = Channel.find(params[:id])
    @involvement = Involvement.create(user_id: current_user.id, channel_id: @channel.id, role: 3)
    if params[:page].blank?
      @page = 1
    end
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Join', target_type: 'Channel', target_id: @channel.id , middle_type: 'Involvement', middle_id: @involvement.id)

  end

  def view_remote
    @channels = []
    case params['section']
    when 'trophy'
      @j = 0
      for i in Involvement.group('channel_id').order('count_id desc').count('id')
        if @j < 10
          @channels << Channel.find(i[0])
        end
        @j = @j+1
      end
    when 'mine'
      for pr in Involvement.where(user_id: params[:user_id])
        @channels << pr.channel
      end
    when 'related'
      for sug in Suggestion.where(user_id: params[:user_id], suggested_type: 'Channel')
        @ev =  sug.suggested_type.classify.constantize.find_by_id(sug.suggested_id)
        if !@ev.blank?
          @channels << @ev
        end
      end
    end
  end

  def view_content
    @channel = Channel.find(params[:id])
    if params[:page].blank?
      @page = 1
    else
      @page = params[:page].to_i
    end
    @rnd = params[:rnd]
    @visit = Visit.where(user_id: current_user.id, visitable_id: @channel.id, visitable_type: 'Channel').first
    if !@visit.blank?
      @visit.destroy
    end
    Visit.create(user_id: current_user.id, visitable_id: @channel.id, visitable_type: 'Channel')
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'View', target_type: 'Channel', target_id: @channel.id)
  end

  def upload_avatar
    @channel = Channel.find(params[:id])
  end

  def cropper
    @channel = Channel.find(params[:id])
    @caller = params[:caller]
  end

  def crop
    @channel = Channel.find(params[:id])
    @caller = params[:caller]
    respond_to do |format|
      format.js
    end
  end

  def change_avatar
    @channel = Channel.find(params[:id])
  end
  # GET /channels
  # GET /channels.json
  def index
    @channels = Channel.all
    @channel = Channel.find_by_id(params[:channel_id])
    if !@channel.blank?
      @visit = Visit.where(user_id: current_user.id, visitable_id: @channel.id, visitable_type: 'Channel').first
      if !@visit.blank?
        @visit.destroy
      end
      Visit.create(user_id: current_user.id, visitable_id: @channel.id, visitable_type: 'Channel')
      @activity =  Activity.create(user_id: current_user.id, activity_type: 'View', target_type: 'Channel', target_id: @channel.id)
    end
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
  end

  # GET /channels/new
  def new
    @channel = Channel.new
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels
  # POST /channels.json
  def create
    @channel = Channel.new(channel_params)
    @tags = params[:tags].split(',')
    @tagged = []
    if !current_user.id.blank?
      @channel.user_id = current_user.id
    end
    respond_to do |format|
      if @channel.save
        @activity =  Activity.create(user_id: current_user.id, activity_type: 'Create', target_type: 'Channel', target_id: @channel.id)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.create(taggable_id: @channel.id, taggable_type: 'Channel', tag_id: @tag.id)
          end
        end
        if params[:channel][:avatar].blank?
          format.html { redirect_to '/channels?channel_id='+@channel.id.to_s, notice: :channel_was_successfully_created }
        else
          format.html { redirect_to '/channels/cropper/'+@channel.id.to_s}
        end
        format.json { render :show, status: :created, location: @channel }
      else
        format.html { render :new }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
    @tags = params[:tags].split(',')
    @tagged = []
    for prev in Tagging.where(taggable_id: @channel.id, taggable_type: 'Channel')
      prev.destroy
    end
    respond_to do |format|
      if @channel.update(channel_params)
        @activity =  Activity.create(user_id: current_user.id, activity_type: 'Update', target_type: 'Channel', target_id: @channel.id)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.where(taggable_id: @channel.id, taggable_type: 'Channel', tag_id: @tag.id).first
            if @tagging.blank?
              @tagging = Tagging.create(taggable_id: @channel.id, taggable_type: 'Channel', tag_id: @tag.id)
            end
          end
        end
        if params[:channel][:avatar].blank?
          format.html { redirect_to '/channels?channel_id='+@channel.id.to_s, notice: :Channel_was_successfully_updated }
        else
          format.html { redirect_to '/channels/cropper/'+@channel.id.to_s}
        end
      else
        format.html { render :edit }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Destroy', target_type: 'Channel', target_id: @channel.id)
    @channel.destroy
    respond_to do |format|
      format.html { redirect_to channels_url, notice: 'Channel was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params.require(:channel).permit(:name, :description, :p_type, :g_type, :i_type ,:avatar, :crop_x, :crop_y, :crop_w, :crop_h, :caller)
    end
end
