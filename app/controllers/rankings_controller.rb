class RankingsController < ApplicationController
  before_action :set_ranking, only: [:show, :edit, :update, :destroy]

  def remote
    @rankings = Ranking.where(user_id: current_user.id, rankable_id: params[:rankable_id], rankable_type: params[:rankable_type], rank_type: params[:rank_type]).first
    if @rankings.blank?
      Ranking.create(user_id: current_user.id, rankable_id: params[:rankable_id], rankable_type: params[:rankable_type], rank_type: params[:rank_type], value: params[:value])
    else
      @rankings.value = params[:value]
      @rankings.save
    end
  end
  # GET /rankings
  # GET /rankings.json
  def index
    @rankings = Ranking.all
  end

  # GET /rankings/1
  # GET /rankings/1.json
  def show
  end

  # GET /rankings/new
  def new
    @ranking = Ranking.new
  end

  # GET /rankings/1/edit
  def edit
  end

  # POST /rankings
  # POST /rankings.json
  def create
    @ranking = Ranking.new(ranking_params)

    respond_to do |format|
      if @ranking.save
        format.html { redirect_to @ranking, notice: 'Ranking was successfully created.' }
        format.json { render :show, status: :created, location: @ranking }
      else
        format.html { render :new }
        format.json { render json: @ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rankings/1
  # PATCH/PUT /rankings/1.json
  def update
    respond_to do |format|
      if @ranking.update(ranking_params)
        format.html { redirect_to @ranking, notice: 'Ranking was successfully updated.' }
        format.json { render :show, status: :ok, location: @ranking }
      else
        format.html { render :edit }
        format.json { render json: @ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rankings/1
  # DELETE /rankings/1.json
  def destroy
    @ranking.destroy
    respond_to do |format|
      format.html { redirect_to rankings_url, notice: 'Ranking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ranking
      @ranking = Ranking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ranking_params
      params.require(:ranking).permit(:rankable_type, :rankable_id, :user_id, :rank_type, :value)
    end
end
