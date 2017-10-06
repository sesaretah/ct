class OffsessionmaterialsController < ApplicationController
  before_action :set_offsessionmaterial, only: [:show, :edit, :update, :destroy]

  def render_partial
  @offsessionmaterial = Offsessionmaterial.find(params[:id])
  @offsession = @offsessionmaterial.offsession
  render :json => {
    :html => render_to_string({
      :partial => "offsessionmaterials/list",
      :locals => { offsession: @offsession}
    })
  }
end
  # GET /offsessionmaterials
  # GET /offsessionmaterials.json
  def index
    @offsessionmaterials = Offsessionmaterial.all
  end

  # GET /offsessionmaterials/1
  # GET /offsessionmaterials/1.json
  def show
  end

  # GET /offsessionmaterials/new
  def new
    @offsessionmaterial = Offsessionmaterial.new
  end

  # GET /offsessionmaterials/1/edit
  def edit
  end

  # POST /offsessionmaterials
  # POST /offsessionmaterials.json
  def create
    @offsessionmaterial = Offsessionmaterial.new(offsessionmaterial_params)

    respond_to do |format|
      if @offsessionmaterial.save
        format.html { redirect_to @offsessionmaterial, notice: 'Offsessionmaterial was successfully created.' }
        format.json { render :show, status: :created, location: @offsessionmaterial }
      else
        format.html { render :new }
        format.json { render json: @offsessionmaterial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offsessionmaterials/1
  # PATCH/PUT /offsessionmaterials/1.json
  def update
    respond_to do |format|
      if @offsessionmaterial.update(offsessionmaterial_params)
        format.html { redirect_to @offsessionmaterial, notice: 'Offsessionmaterial was successfully updated.' }
        format.json { render :show, status: :ok, location: @offsessionmaterial }
      else
        format.html { render :edit }
        format.json { render json: @offsessionmaterial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offsessionmaterials/1
  # DELETE /offsessionmaterials/1.json
  def destroy
    @offsession = @offsessionmaterial.offsession
    @offsessionmaterial.destroy
    respond_to do |format|
      format.html { redirect_to offsessionmaterials_url, notice: 'Offsessionmaterial was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offsessionmaterial
      @offsessionmaterial = Offsessionmaterial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offsessionmaterial_params
      params.require(:offsessionmaterial).permit(:title, :offsession_id, :document, :sfiletype)
    end
end
