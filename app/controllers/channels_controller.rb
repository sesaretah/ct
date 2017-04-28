class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  def search
    if !params[:q].blank?
      @channels = Channel.where("name LIKE ? OR description LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    #search params[:q], :star => true
  end


  def join
    @channel = Channel.find(params[:id])
    @involvement = Involvement.create(user_id: current_user.id, channel_id: @channel.id, role: 3)
    if params[:page].blank?
      @page = 1
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
    @channel.user_id = current_user.id
    respond_to do |format|
      if @channel.save
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
    respond_to do |format|
      if @channel.update(channel_params)
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
