class EventsController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show, :create,:view_remote]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  def search
    if !params[:q].blank?
      @events = Event.where("name LIKE ? OR description LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Search', target_type: 'Event')

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @events }
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
    @visit = Visit.where(user_id: current_user.id, visitable_id: @event.id, visitable_type: 'Event').first
    if !@visit.blank?
      @visit.destroy
    end
    Visit.create(user_id: current_user.id, visitable_id: @event.id, visitable_type: 'Event')
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'View', target_type: 'Event', target_id: @event.id)

  end

  def view_remote
    @events = []
    case params['section']
    when 'trophy'
      @j = 0
      for i in Participation.group('event_id').order('count_id desc').count('id')
        if @j < 10
          @events << Event.find(i[0])
        end
        @j = @j+1
      end
    when 'mine'
      for pr in Participation.where(user_id: params[:user_id])
        @events << pr.event
      end
    when 'related'
      for sug in Suggestion.where(user_id: params[:user_id], suggested_type: 'Event')
        @ev =  sug.suggested_type.classify.constantize.find_by_id(sug.suggested_id)
        if !@ev.blank?
          @events << @ev
        end
      end
    end
  end

  def upload_avatar
    @event = Event.find(params[:id])
  end

  def cropper
    @event = Event.find(params[:id])
    @caller = params[:caller]
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
    if !@event.blank?
      @visit = Visit.where(user_id: current_user.id, visitable_id: @event.id, visitable_type: 'Event').first
      if !@visit.blank?
        @visit.destroy
      end
      Visit.create(user_id: current_user.id, visitable_id: @event.id, visitable_type: 'Event')
      @activity =  Activity.create(user_id: current_user.id, activity_type: 'View', target_type: 'Event', target_id: @event.id)

    end
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
    @tags = params[:tags].split(',')
    @tagged = []

    respond_to do |format|
      if @event.save
        @activity =  Activity.create(user_id: current_user.id, activity_type: 'Create', target_type: 'Event', target_id: @event.id)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.create(taggable_id: @event.id, taggable_type: 'Event', tag_id: @tag.id)
          end
        end
        if params[:event][:avatar].blank?
          format.html { redirect_to '/events?event_id='+@event.id.to_s, notice: :Event_was_successfully_created }
        else
          format.html { redirect_to '/events/cropper/'+@event.id.to_s}
        end
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
    @tags = params[:tags].split(',')
    @tagged = []
    for prev in Tagging.where(taggable_id: @event.id, taggable_type: 'Event')
      prev.destroy
    end
    respond_to do |format|
      if !params[:event_date_yyyy].blank?
        @event.event_date = JalaliDate.to_gregorian(params[:event_date_yyyy],params[:event_date_mm],params[:event_date_dd])
      end
      if @event.update(event_params)
        @activity =  Activity.create(user_id: current_user.id, activity_type: 'Update', target_type: 'Event', target_id: @event.id)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.where(taggable_id: @event.id, taggable_type: 'Event', tag_id: @tag.id).first
            if @tagging.blank?
              @tagging = Tagging.create(taggable_id: @event.id, taggable_type: 'Event', tag_id: @tag.id)
            end
          end
        end
        if params[:event][:avatar].blank?
          format.html { redirect_to '/events?event_id='+@event.id.to_s, notice: :Event_was_successfully_updated }
        else
          format.html { redirect_to '/events/cropper/'+@event.id.to_s}
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
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Destroy', target_type: 'Event', target_id: @event.id)

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
