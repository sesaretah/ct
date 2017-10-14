class GrantingsController < ApplicationController
  before_action :set_granting, only: [:show, :edit, :update, :destroy]

  # GET /grantings
  # GET /grantings.json
  def index
    @grantings = Granting.all
  end

  # GET /grantings/1
  # GET /grantings/1.json
  def show
  end

  # GET /grantings/new
  def new
    @granting = Granting.new
  end

  # GET /grantings/1/edit
  def edit
  end

  # POST /grantings
  # POST /grantings.json
  def create
    @granting = Granting.new(granting_params)

    respond_to do |format|
      if @granting.save
        format.html { redirect_to @granting, notice: 'Granting was successfully created.' }
        format.json { render :show, status: :created, location: @granting }
        format.js
      else
        format.html { render :new }
        format.json { render json: @granting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grantings/1
  # PATCH/PUT /grantings/1.json
  def update
    respond_to do |format|
      if @granting.update(granting_params)
        format.html { redirect_to @granting, notice: 'Granting was successfully updated.' }
        format.json { render :show, status: :ok, location: @granting }
      else
        format.html { render :edit }
        format.json { render json: @granting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grantings/1
  # DELETE /grantings/1.json
  def destroy
    @user = @granting.user
    @granting.destroy
    respond_to do |format|
      format.html { redirect_to grantings_url, notice: 'Granting was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_granting
      @granting = Granting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def granting_params
      params.require(:granting).permit(:role_id, :user_id, :granter_id)
    end
end
