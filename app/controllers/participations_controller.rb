class ParticipationsController < ApplicationController
  before_action :set_participation, only: [:show, :edit, :update, :destroy]

  def change_stat
    @participation = Participation.find(params[:id])
    @event_admin = Participation.where(user_id: current_user.id, event_id: @participation.event_id).first
    @event = @participation.event
    if @event_admin.role == 1
      @participation.role = 2
      @participation.save
    end
  end

  def add_to_event
    @event = Event.find(params[:event_id])
    if params[:page].blank?
      @page = 1
    end
    if params[:user_id].blank?
      params[:user_id] = current_user.id
    end
    if @event.p_type != 1
      params[:role] = 3
    end
    @participation = Participation.create(user_id: params[:user_id], event_id: params[:event_id], adder_id: params[:adder_id], role: params[:role])
  end

  # GET /participations
  # GET /participations.json
  def index
    @participations = Participation.all
  end

  # GET /participations/1
  # GET /participations/1.json
  def show
  end

  # GET /participations/new
  def new
    @participation = Participation.new
  end

  # GET /participations/1/edit
  def edit
  end

  # POST /participations
  # POST /participations.json
  def create
    @participation = Participation.new(participation_params)

    respond_to do |format|
      if @participation.save
        format.html { redirect_to @participation, notice: 'Participation was successfully created.' }
        format.json { render :show, status: :created, location: @participation }
      else
        format.html { render :new }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participations/1
  # PATCH/PUT /participations/1.json
  def update
    respond_to do |format|
      if @participation.update(participation_params)
        format.html { redirect_to @participation, notice: 'Participation was successfully updated.' }
        format.json { render :show, status: :ok, location: @participation }
      else
        format.html { render :edit }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participations/1
  # DELETE /participations/1.json
  def destroy
    @event = @participation.event
    if params[:page].blank?
      @page = 1
    end
    @participation.destroy
    respond_to do |format|
      format.html { redirect_to participations_url, notice: 'Participation was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participation
      @participation = Participation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participation_params
      params.require(:participation).permit(:user_id, :event_id, :adder_id, :role)
    end
end
