class LabsController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update, :destroy]

  def search
    @labs = Lab.search params[:q], :star => true
    @excerpter = ThinkingSphinx::Excerpter.new 'lab_core', params[:q]   , {
    :before_match    => '<span class="bg-warning">',
    :after_match     => '</span>',
    :chunk_separator => ' &#8230; ' # ellipsis
  }
  end

  def view_content
    @lab = Lab.find(params[:id])
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

    respond_to do |format|
      if @lab.save
        format.html { redirect_to '/labs?lab_id='+@lab.id, notice: 'Lab was successfully created.' }
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
        format.html { redirect_to @lab, notice: 'Lab was successfully updated.' }
        format.json { render :show, status: :ok, location: @lab }
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
      params.require(:lab).permit(:name, :about, :missions, :tel, :address)
    end
end
