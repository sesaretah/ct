class OffsessionsController < ApplicationController
  before_action :set_offsession, only: [:show, :edit, :update, :destroy]

  # GET /offsessions
  # GET /offsessions.json
  def index
    @offsessions = Offsession.all
  end

  # GET /offsessions/1
  # GET /offsessions/1.json
  def show
  end

  # GET /offsessions/new
  def new
    @offsession = Offsession.new
  end

  # GET /offsessions/1/edit
  def edit
  end

  # POST /offsessions
  # POST /offsessions.json
  def create
    @offsession = Offsession.new(offsession_params)
    @offering = @offsession.offering
    respond_to do |format|
      if @offsession.save
        format.html { redirect_to @offsession, notice: 'Offsession was successfully created.' }
        format.json { render :show, status: :created, location: @offsession }
        format.js
      else
        format.html { render :new }
        format.json { render json: @offsession.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offsessions/1
  # PATCH/PUT /offsessions/1.json
  def update
    respond_to do |format|
      if @offsession.update(offsession_params)
        format.html { redirect_to @offsession, notice: 'Offsession was successfully updated.' }
        format.json { render :show, status: :ok, location: @offsession }
      else
        format.html { render :edit }
        format.json { render json: @offsession.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offsessions/1
  # DELETE /offsessions/1.json
  def destroy
    @offsession.destroy
    respond_to do |format|
      format.html { redirect_to offsessions_url, notice: 'Offsession was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offsession
      @offsession = Offsession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offsession_params
      params.require(:offsession).permit(:offering_id, :name)
    end
end
