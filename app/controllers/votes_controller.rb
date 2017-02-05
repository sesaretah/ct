class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  def vote_up
    @already_voted = Vote.where(voteable_type: params[:voteable_type], voteable_id: params[:voteable_id], user_id: current_user.id).first

    if @already_voted.blank?
      @vote = Vote.create(voteable_type: params[:voteable_type], voteable_id: params[:voteable_id], user_id: current_user.id, amount: 1)
      @item = @vote.voteable_type.classify.constantize.find(@vote.voteable_id)
      @item.rank_value = @item.rank_value.to_i + 1
      @item.save
    else
      if @already_voted.amount == -1
        @already_voted.amount = 1
        @already_voted.save
        @item = @already_voted.voteable_type.classify.constantize.find(@already_voted.voteable_id)
        @item.rank_value = @item.rank_value.to_i + 1
        @item.save
      end
    end

     @count = 0
    for v in  Vote.where(voteable_type: params[:voteable_type], voteable_id: params[:voteable_id])
       @count = @count + v.amount
    end
  end

  def vote_down
    @already_voted = Vote.where(voteable_type: params[:voteable_type], voteable_id: params[:voteable_id], user_id: current_user.id).first

    if @already_voted.blank?
      @vote = Vote.create(voteable_type: params[:voteable_type], voteable_id: params[:voteable_id], user_id: current_user.id, amount: -1)
      @item = @vote.voteable_type.classify.constantize.find(@vote.voteable_id)
      @item.rank_value = @item.rank_value.to_i - 1
      @item.save
    else
      if @already_voted.amount == 1
        @already_voted.amount = -1
        @already_voted.save
        @item = @already_voted.voteable_type.classify.constantize.find(@already_voted.voteable_id)
        @item.rank_value = @item.rank_value.to_i - 1
        @item.save
      end
    end
    @count = 0
   for v in  Vote.where(voteable_type: params[:voteable_type], voteable_id: params[:voteable_id])
      @count = @count + v.amount
   end
  end
  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit
  end

  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(vote_params)

    respond_to do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: 'Vote was successfully created.' }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votes/1
  # PATCH/PUT /votes/1.json
  def update
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url, notice: 'Vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:user_id, :voteable_type, :voteable_id, :amount)
    end
end
