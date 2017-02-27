class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  def search
    if !params[:q].blank?
      @events = Event.where("name LIKE ? OR description LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    #search params[:q], :star => true
  end

  def view_content
    @event = Event.find(params[:id])
    if params[:page].blank?
      @page = 1
    else
      @page = params[:page].to_i
    end
    @rnd = params[:rnd]
  end


  def upload_avatar
    @event = Event.find(params[:id])
  end


  def crop
    @event = Event.find(params[:id])
    @caller = params[:caller]
    respond_to do |format|
      format.js
    end
  end

  def change_avatar
    @event = Event.find(params[:id])
  end
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @event = Event.find_by_id(params[:event_id])
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.event_date = JalaliDate.to_gregorian(params[:event_date_yyyy],params[:event_date_mm],params[:event_date_dd])
    @event.user_id = current_user.id

    respond_to do |format|
      if @event.save
        format.html { redirect_to '/events/change_avatar/'+ @event.id.to_s, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if !params[:event_date_yyyy].blank?
        @event.event_date = JalaliDate.to_gregorian(params[:event_date_yyyy],params[:event_date_mm],params[:event_date_dd])
      end
      if @event.update(event_params)
        format.html { redirect_to '/events/change_avatar/'+ @event.id.to_s, notice: 'Event was successfully updated.' }
        format.json { render action: 'crop' }
        if @event.cropping?
          format.js { render action: 'crop', :locals => {:caller => @caller, :id => @event.id} }
        else
          format.js { render action: 'update' }
        end
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description,:i_type,:p_type, :g_type, :location ,:event_date, :start_time, :end_time, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :caller)
    end
end
