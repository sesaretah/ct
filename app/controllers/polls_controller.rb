class PollsController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show]
  before_action :set_poll, only: [:show, :edit, :update, :destroy]

  def view_content
    @poll = Poll.find(params[:id])
    if params[:page].blank?
      @page = 1
    else
      @page = params[:page].to_i
    end
    @rnd = params[:rnd]
  end

  def completion
    @poll = Poll.find(params[:id])
  end
  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all
    if !params[:poll_id].blank?
      @poll = Poll.find(params[:poll_id])
    end
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
  end

  # GET /polls/new
  def new
    @poll = Poll.new
  end

  # GET /polls/1/edit
  def edit
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)
    @poll.user_id = current_user.id
    @tags = params[:tags].split(',')
    @tagged = []

    respond_to do |format|
      if @poll.save
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.create(taggable_id: @poll.id, taggable_type: 'Poll', tag_id: @tag.id)
          end
        end
        format.html { redirect_to '/polls/completion/'+ @poll.id.to_s, notice: 'Poll was successfully created.' }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    @tags = params[:tags].split(',')
    @tagged = []
    for prev in Tagging.where(taggable_id: @poll.id, taggable_type: 'Poll')
      prev.destroy
    end
    respond_to do |format|
      if @poll.update(poll_params)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.where(taggable_id: @poll.id, taggable_type: 'Poll', tag_id: @tag.id).first
            if @tagging.blank?
              @tagging = Tagging.create(taggable_id: @poll.id, taggable_type: 'Poll', tag_id: @tag.id)
            end
          end
        end
        format.html {redirect_to '/polls/completion/'+ @poll.id.to_s, notice: 'Poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:title)
    end
end
