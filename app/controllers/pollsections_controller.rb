class PollsectionsController < ApplicationController
  before_action :set_pollsection, only: [:show, :edit, :update, :destroy]

  # GET /pollsections
  # GET /pollsections.json
  def index
    @pollsections = Pollsection.all
  end

  # GET /pollsections/1
  # GET /pollsections/1.json
  def show
  end

  # GET /pollsections/new
  def new
    @pollsection = Pollsection.new
  end

  # GET /pollsections/1/edit
  def edit
    @poll = @pollsection.poll
  end

  # POST /pollsections
  # POST /pollsections.json
  def create

    @pollsection = Pollsection.new
    @pollsection.question = params[:question]
    @pollsection.poll_id = params[:poll_id]
    @poll = Poll.find(@pollsection.poll_id)
    respond_to do |format|
      if @pollsection.save
        for @i in 1..5
          if !params["option_#{@i}"].blank?
            Pollitem.create(poll_id: @pollsection.poll_id, pollsection_id: @pollsection.id, content: params["option_#{@i}"])
          end
        end
        format.html { redirect_to @pollsection, notice: 'Pollsection was successfully created.' }
        format.json { render :show, status: :created, location: @pollsection }
        format.js
      else
        format.html { render :new }
        format.json { render json: @pollsection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pollsections/1
  # PATCH/PUT /pollsections/1.json
  def update
    @pollsection.question = params[:question]
    @pollsection.poll_id = params[:poll_id]
    @poll = Poll.find(@pollsection.poll_id)
    respond_to do |format|
      if @pollsection.save
        for pollitem in @pollsection.pollitems
          pollitem.destroy
        end
        for @i in 1..5
          if !params["option_#{@i}"].blank?
            Pollitem.create(poll_id: @pollsection.poll_id, pollsection_id: @pollsection.id, content: params["option_#{@i}"])
          end
        end
        format.html { redirect_to @pollsection, notice: 'Pollsection was successfully updated.' }
        format.json { render :show, status: :ok, location: @pollsection }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @pollsection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pollsections/1
  # DELETE /pollsections/1.json
  def destroy
    @pollsection.destroy
    respond_to do |format|
      format.html { redirect_to pollsections_url, notice: 'Pollsection was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pollsection
      @pollsection = Pollsection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pollsection_params
      params.require(:pollsection).permit(:poll_id, :question)
    end
end
