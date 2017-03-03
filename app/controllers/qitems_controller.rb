class QitemsController < ApplicationController
  before_action :set_qitem, only: [:show, :edit, :update, :destroy]

  # GET /qitems
  # GET /qitems.json
  def index
    @qitems = Qitem.all
  end

  # GET /qitems/1
  # GET /qitems/1.json
  def show
  end

  # GET /qitems/new
  def new
    @qitem = Qitem.new
  end

  # GET /qitems/1/edit
  def edit
  end

  # POST /qitems
  # POST /qitems.json
  def create
    @qitem = Qitem.new(qitem_params)

    respond_to do |format|
      if @qitem.save
        format.html { redirect_to @qitem, notice: 'Qitem was successfully created.' }
        format.json { render :show, status: :created, location: @qitem }
      else
        format.html { render :new }
        format.json { render json: @qitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qitems/1
  # PATCH/PUT /qitems/1.json
  def update
    respond_to do |format|
      if @qitem.update(qitem_params)
        format.html { redirect_to @qitem, notice: 'Qitem was successfully updated.' }
        format.json { render :show, status: :ok, location: @qitem }
      else
        format.html { render :edit }
        format.json { render json: @qitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qitems/1
  # DELETE /qitems/1.json
  def destroy
    @qitem.destroy
    respond_to do |format|
      format.html { redirect_to qitems_url, notice: 'Qitem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qitem
      @qitem = Qitem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qitem_params
      params.require(:qitem).permit(:content, :questionaire_id)
    end
end
