class QuestionairesController < ApplicationController
  before_action :set_questionaire, only: [:show, :edit, :update, :destroy]

  # GET /questionaires
  # GET /questionaires.json
  def index
    @questionaires = Questionaire.all
  end

  # GET /questionaires/1
  # GET /questionaires/1.json
  def show
  end

  # GET /questionaires/new
  def new
    @questionaire = Questionaire.new
  end

  # GET /questionaires/1/edit
  def edit
  end

  # POST /questionaires
  # POST /questionaires.json
  def create
    @questionaire = Questionaire.new(questionaire_params)

    respond_to do |format|
      if @questionaire.save
        format.html { redirect_to @questionaire, notice: 'Questionaire was successfully created.' }
        format.json { render :show, status: :created, location: @questionaire }
      else
        format.html { render :new }
        format.json { render json: @questionaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questionaires/1
  # PATCH/PUT /questionaires/1.json
  def update
    respond_to do |format|
      if @questionaire.update(questionaire_params)
        format.html { redirect_to @questionaire, notice: 'Questionaire was successfully updated.' }
        format.json { render :show, status: :ok, location: @questionaire }
      else
        format.html { render :edit }
        format.json { render json: @questionaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questionaires/1
  # DELETE /questionaires/1.json
  def destroy
    @questionaire.destroy
    respond_to do |format|
      format.html { redirect_to questionaires_url, notice: 'Questionaire was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_questionaire
      @questionaire = Questionaire.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def questionaire_params
      params.require(:questionaire).permit(:question, :user_id)
    end
end
