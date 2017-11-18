class ReportabusesController < ApplicationController
  before_action :set_reportabus, only: [:show, :edit, :update, :destroy]

  # GET /reportabuses
  # GET /reportabuses.json
  def index
    @reportabuses = Reportabuse.all
  end

  # GET /reportabuses/1
  # GET /reportabuses/1.json
  def show
  end

  # GET /reportabuses/new
  def new
    @reportabus = Reportabuse.new
  end

  # GET /reportabuses/1/edit
  def edit
  end

  # POST /reportabuses
  # POST /reportabuses.json
  def create
    @reportabus = Reportabuse.new(reportabus_params)

    respond_to do |format|
      if @reportabus.save
        format.html { redirect_to @reportabus, notice: 'Reportabuse was successfully created.' }
        format.json { render :show, status: :created, location: @reportabus }
      else
        format.html { render :new }
        format.json { render json: @reportabus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reportabuses/1
  # PATCH/PUT /reportabuses/1.json
  def update
    respond_to do |format|
      if @reportabus.update(reportabus_params)
        format.html { redirect_to @reportabus, notice: 'Reportabuse was successfully updated.' }
        format.json { render :show, status: :ok, location: @reportabus }
      else
        format.html { render :edit }
        format.json { render json: @reportabus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reportabuses/1
  # DELETE /reportabuses/1.json
  def destroy
    @reportabus.destroy
    respond_to do |format|
      format.html { redirect_to reportabuses_url, notice: 'Reportabuse was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reportabus
      @reportabus = Reportabuse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reportabus_params
      params.require(:reportabus).permit(:abuse_id, :detail, :abused_type, :abused_id, :abuser_id, :reporter_id)
    end
end
