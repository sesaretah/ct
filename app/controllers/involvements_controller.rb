class InvolvementsController < ApplicationController
  before_action :set_involvement, only: [:show, :edit, :update, :destroy]

  def change_stat
    @involvement = Involvement.find(params[:id])
    @channel_admin = Involvement.where(user_id: current_user.id, channel_id: @involvement.channel_id).first
    @channel = @involvement.channel
    if @channel_admin.role == 1
      @involvement.role = 2
      @involvement.save
    end
  end
  def add_to_channel
    @channel = Channel.find(params[:channel_id])
    if params[:page].blank?
      @page = 1
    end
    if params[:user_id].blank?
      params[:user_id] = current_user.id
    end
    if @channel.p_type != 1
      params[:role] = 3
    end
    @involvement = Involvement.create(user_id: params[:user_id], channel_id: params[:channel_id], adder_id: params[:adder_id], role: params[:role])
  end
  # GET /involvements
  # GET /involvements.json
  def index
    @involvements = Involvement.all
  end

  # GET /involvements/1
  # GET /involvements/1.json
  def show
  end

  # GET /involvements/new
  def new
    @involvement = Involvement.new
  end

  # GET /involvements/1/edit
  def edit
  end

  # POST /involvements
  # POST /involvements.json
  def create
    @involvement = Involvement.new(involvement_params)

    respond_to do |format|
      if @involvement.save
        format.html { redirect_to @involvement, notice: 'Involvement was successfully created.' }
        format.json { render :show, status: :created, location: @involvement }
      else
        format.html { render :new }
        format.json { render json: @involvement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /involvements/1
  # PATCH/PUT /involvements/1.json
  def update
    respond_to do |format|
      if @involvement.update(involvement_params)
        format.html { redirect_to @involvement, notice: 'Involvement was successfully updated.' }
        format.json { render :show, status: :ok, location: @involvement }
      else
        format.html { render :edit }
        format.json { render json: @involvement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /involvements/1
  # DELETE /involvements/1.json
  def destroy
    @channel = @involvement.channel
    if params[:page].blank?
      @page = 1
    end
    @involvement.destroy
    respond_to do |format|
      format.html { redirect_to involvements_url, notice: 'Involvement was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_involvement
      @involvement = Involvement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def involvement_params
      params.require(:involvement).permit(:user_id, :channel_id, :adder_id, :role)
    end
end
