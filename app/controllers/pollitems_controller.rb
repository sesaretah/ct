class PollitemsController < ApplicationController
  before_action :set_pollitem, only: [:show, :edit, :update, :destroy]

  # GET /pollitems
  # GET /pollitems.json
  def index
    @pollitems = Pollitem.all
  end

  # GET /pollitems/1
  # GET /pollitems/1.json
  def show
  end

  # GET /pollitems/new
  def new
    @pollitem = Pollitem.new
  end

  # GET /pollitems/1/edit
  def edit
  end

  # POST /pollitems
  # POST /pollitems.json
  def create
    @pollitem = Pollitem.new(pollitem_params)
    @poll = Poll.find(@pollitem.poll_id)
    respond_to do |format|
      if @pollitem.save
        format.html { redirect_to @pollitem, notice: 'Pollitem was successfully created.' }
        format.json { render :show, status: :created, location: @pollitem }
        format.js
      else
        format.html { render :new }
        format.json { render json: @pollitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pollitems/1
  # PATCH/PUT /pollitems/1.json
  def update
    @poll = Poll.find(@pollitem.poll_id)
    respond_to do |format|
      if @pollitem.update(pollitem_params)
        format.html { redirect_to @pollitem, notice: 'Pollitem was successfully updated.' }
        format.json { render :show, status: :ok, location: @pollitem }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @pollitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pollitems/1
  # DELETE /pollitems/1.json
  def destroy
    @poll = Poll.find(@pollitem.poll_id)
    @pollitem.destroy
    respond_to do |format|
      format.html { redirect_to pollitems_url, notice: 'Pollitem was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pollitem
      @pollitem = Pollitem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pollitem_params
      params.require(:pollitem).permit(:content, :poll_id)
    end
end
