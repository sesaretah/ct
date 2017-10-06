class CouplingsController < ApplicationController
  before_action :set_coupling, only: [:show, :edit, :update, :destroy]

  # GET /couplings
  # GET /couplings.json
  def index
    @couplings = Coupling.all
  end

  # GET /couplings/1
  # GET /couplings/1.json
  def show
  end

  # GET /couplings/new
  def new
    @coupling = Coupling.new
  end

  # GET /couplings/1/edit
  def edit
  end

  # POST /couplings
  # POST /couplings.json
  def create
    @coupling = Coupling.new(coupling_params)

    respond_to do |format|
      if @coupling.save
        format.html { redirect_to @coupling, notice: 'Coupling was successfully created.' }
        format.json { render :show, status: :created, location: @coupling }
      else
        format.html { render :new }
        format.json { render json: @coupling.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /couplings/1
  # PATCH/PUT /couplings/1.json
  def update
    respond_to do |format|
      if @coupling.update(coupling_params)
        format.html { redirect_to @coupling, notice: 'Coupling was successfully updated.' }
        format.json { render :show, status: :ok, location: @coupling }
      else
        format.html { render :edit }
        format.json { render json: @coupling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /couplings/1
  # DELETE /couplings/1.json
  def destroy
    @coupling.destroy
    respond_to do |format|
      format.html { redirect_to couplings_url, notice: 'Coupling was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupling
      @coupling = Coupling.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupling_params
      params.require(:coupling).permit(:coupler_id, :coupler_type, :couplee_id, :couplee_type)
    end
end
