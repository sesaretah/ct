class CsessionsController < ApplicationController
  before_action :set_csession, only: [:show, :edit, :update, :destroy]

  # GET /csessions
  # GET /csessions.json
  def index
    @csessions = Csession.all
  end

  # GET /csessions/1
  # GET /csessions/1.json
  def show
  end

  # GET /csessions/new
  def new
    @csession = Csession.new
  end

  # GET /csessions/1/edit
  def edit
  end

  # POST /csessions
  # POST /csessions.json
  def create
    @csession = Csession.new(csession_params)

    respond_to do |format|
      if @csession.save
        format.html { redirect_to @csession, notice: 'Csession was successfully created.' }
        format.json { render :show, status: :created, location: @csession }
      else
        format.html { render :new }
        format.json { render json: @csession.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /csessions/1
  # PATCH/PUT /csessions/1.json
  def update
    respond_to do |format|
      if @csession.update(csession_params)
        format.html { redirect_to @csession, notice: 'Csession was successfully updated.' }
        format.json { render :show, status: :ok, location: @csession }
      else
        format.html { render :edit }
        format.json { render json: @csession.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /csessions/1
  # DELETE /csessions/1.json
  def destroy
    @csession.destroy
    respond_to do |format|
      format.html { redirect_to csessions_url, notice: 'Csession was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_csession
      @csession = Csession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def csession_params
      params.require(:csession).permit(:course_id, :title, :description)
    end
end
