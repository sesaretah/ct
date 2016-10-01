class HonorsController < ApplicationController
  before_action :set_honor, only: [:show, :edit, :update, :destroy]

  # GET /honors
  # GET /honors.json
  def index
    @honors = Honor.all
  end

  # GET /honors/1
  # GET /honors/1.json
  def show
  end

  # GET /honors/new
  def new
    @honor = Honor.new
  end

  # GET /honors/1/edit
  def edit
  end

  # POST /honors
  # POST /honors.json
  def create
    if !params["honors"].blank?
    params["honors"].each do |honor|
      if honor["title"] != ""
        @honor = Honor.create(honor_params(honor))
        @honor.user_id = current_user.id
        @honor.save
      end
    end
  else
    @honor = Honor.new(honor_params(params["honor"]))
    @honor.user_id = current_user.id
    @honor.save
  end
    respond_to do |format|
      if params[:caller] == 'reg'
        format.html { redirect_to '/registeration_steps?step=5'}
      else
        format.html { redirect_to honors_url, notice: 'Education ....' }
        format.js
      end
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /honors/1
  # PATCH/PUT /honors/1.json
  def update
    respond_to do |format|
      if @honor.update(honor_params(params["honor"]))
        if params[:caller] == 'reg'
          format.html { redirect_to '/registeration_steps?step=5'}
        else
          format.html { redirect_to @honor, notice: 'Honor was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @honor }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @honor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /honors/1
  # DELETE /honors/1.json
  def destroy
    @honor.destroy
    respond_to do |format|
      format.html { redirect_to honors_url, notice: 'Honor was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_honor
      @honor = Honor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def honor_params(my_params)
      my_params.permit(:title, :year)
    end
end
