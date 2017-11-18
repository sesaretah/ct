class AbusesController < ApplicationController
  before_action :set_abus, only: [:show, :edit, :update, :destroy]

  # GET /abuses
  # GET /abuses.json
  def index
    @abuses = Abuse.all
  end

  # GET /abuses/1
  # GET /abuses/1.json
  def show
  end

  # GET /abuses/new
  def new
    @abus = Abuse.new
  end

  # GET /abuses/1/edit
  def edit
  end

  # POST /abuses
  # POST /abuses.json
  def create
    @abus = Abuse.new(abus_params)

    respond_to do |format|
      if @abus.save
        format.html { redirect_to '/abuses', notice: 'Abuse was successfully created.' }
        format.json { render :show, status: :created, location: @abus }
      else
        format.html { render :new }
        format.json { render json: @abus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /abuses/1
  # PATCH/PUT /abuses/1.json
  def update
    respond_to do |format|
      if @abus.update(abus_params)
        format.html { redirect_to '/abuses', notice: 'Abuse was successfully updated.' }
        format.json { render :show, status: :ok, location: @abus }
      else
        format.html { render :edit }
        format.json { render json: @abus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /abuses/1
  # DELETE /abuses/1.json
  def destroy
    @abus.destroy
    respond_to do |format|
      format.html { redirect_to abuses_url, notice: 'Abuse was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_abus
      @abus = Abuse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def abus_params
      params.require(:abuse).permit(:title, :user_id)
    end
end
