class LabsController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update, :destroy]

  def search
    if !params[:q].blank?
      @labs = Lab.where("name LIKE ? OR about LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
  end

  def view_content
    @lab = Lab.find(params[:id])
    @rnd = params[:rnd]
  end

  def cropper
    @lab = Lab.find(params[:id])
    @caller = params[:caller]
  end
  # GET /labs
  # GET /labs.json
  def index
    @labs = Lab.all
    @lab = Lab.find_by_id(params[:lab_id])
  end

  # GET /labs/1
  # GET /labs/1.json
  def show
  end

  # GET /labs/new
  def new
    @lab = Lab.new
  end

  # GET /labs/1/edit
  def edit
  end

  # POST /labs
  # POST /labs.json
  def create
    @lab = Lab.new(lab_params)
    @lab.user_id = current_user.id
    respond_to do |format|
      if @lab.save
        if params[:lab][:avatar].blank?
          format.html { redirect_to '/labs?lab_id='+@lab.id.to_s, notice: :lab_was_successfully_created }
        else
          format.html { redirect_to '/labs/cropper/'+@lab.id.to_s}
        end
        format.json { render :show, status: :created, location: @lab }
      else
        format.html { render :new }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /labs/1
  # PATCH/PUT /labs/1.json
  def update
    respond_to do |format|
      if @lab.update(lab_params)
        if params[:lab][:avatar].blank?
          format.html { redirect_to '/labs?lab_id='+@lab.id.to_s, notice: :lab_was_successfully_updated }
        else
          format.html { redirect_to '/labs/cropper/'+@lab.id.to_s}
        end
      else
        format.html { render :edit }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labs/1
  # DELETE /labs/1.json
  def destroy
    @lab.destroy
    respond_to do |format|
      format.html { redirect_to labs_url, notice: 'Lab was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lab
      @lab = Lab.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lab_params
      params.require(:lab).permit(:name, :about, :missions, :tel, :address, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :caller)
    end
end
