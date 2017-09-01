class ResearchesController < ApplicationController
  before_action :set_research, only: [:show, :edit, :update, :destroy]

  def reg_add

  end

  def view_content
    @research = Research.find(params[:id])
    if params[:page].blank?
      @page = 1
    else
      @page = params[:page].to_i
    end
    @rnd = params[:rnd]
  end
  # GET /researches
  # GET /researches.json
  def index
    @researches = Research.all
  end

  # GET /researches/1
  # GET /researches/1.json
  def show
  end

  # GET /researches/new
  def new
    @research = Research.new
  end

  # GET /researches/1/edit
  def edit
  end

  # POST /researches
  # POST /researches.json
  skip_before_filter :verify_authenticity_token, :only => :create
  def create
    if !params["research_history"].blank?
    params["research_history"].each do |research|
      if research["name"] != ""
        @research = Research.create(research_params(research))
        @research.user_id = current_user.id
        @research.save
      end
    end
  else
    @research = Research.new(research_params(params["research"]))
    @research.user_id = current_user.id
    @research.save
  end
    respond_to do |format|
      if params[:caller] == 'reg'
        format.html { redirect_to '/registeration_steps?step=4'}
      else
        format.html { redirect_to researches_url, notice: 'Education ....' }
      end
      format.json { head :no_content }
      format.js
    end
  end

  # PATCH/PUT /researches/1
  # PATCH/PUT /researches/1.json
  def update
    respond_to do |format|
      if @research.update(research_params(params["research"]))
        if params[:caller] == 'reg'
          format.html { redirect_to '/registeration_steps?step=4'}
        else
          format.html { redirect_to @research, notice: 'Research was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @research }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @research.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /researches/1
  # DELETE /researches/1.json
  def destroy
    @research.destroy
    respond_to do |format|
      format.html { redirect_to researches_url, notice: 'Research was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_research
      @research = Research.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def research_params(my_params)
      my_params.permit(:name, :pub_year, :pub_type, :pub_name, :pub_authors, :abstract, :document, :pp)
    end
end
