class ResearchesController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :view_remote]
  before_action :set_research, only: [:show, :edit, :update, :destroy]

  def search
    if !params[:q].blank?
      @researches = Research.where("name LIKE ? OR pub_name LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Search', target_type: 'Research')

  end

  def view_content
    @research = Research.find(params[:id])
    if params[:page].blank?
      @page = 1
    else
      @page = params[:page].to_i
    end
    @rnd = params[:rnd]
    @visit = Visit.where(user_id: current_user.id, visitable_id: @research.id, visitable_type: 'Research').first
    if !@visit.blank?
      @visit.destroy
    end
    Visit.create(user_id: current_user.id, visitable_id: @research.id, visitable_type: 'Research')
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'View', target_type: 'Research', target_id: @research.id)

  end

  def view_remote
    @researches = []
    case params['section']
    when 'trophy'
      @j = 0
      for i in Followship.where('followable_type = ?', 'Research').group('followable_id').order('count_id desc').count('id')
        if @j < 10
          @researches << Research.find(i[0])
        end
        @j = @j+1
      end
    when 'mine'
      for q in Research.where(user_id: params[:user_id])
        @researches << q
      end
    when 'related'
      for sug in Suggestion.where(user_id: params[:user_id], suggested_type: 'Research')
        @ev =  sug.suggested_type.classify.constantize.find_by_id(sug.suggested_id)
        if !@ev.blank?
          @researches << @ev
        end
      end
    end
  end
  # GET /researches
  # GET /researches.json
  def index
    @researches = Research.all
    @research = Research.find_by_id(params[:research_id])
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
    @research = Research.where(name: params["research"]["name"]).first
    if @research.blank?
      @research = Research.new(research_params(params["research"]))
      @research.user_id = current_user.id
      @research.save
      @activity =  Activity.create(user_id: current_user.id, activity_type: 'Create', target_type: 'Research', target_id: @research.id)

    end
    @contribution = Contribution.where(user_id: current_user.id, research_id: @research.id )
    if @contribution.blank?
      @contribution = Contribution.create(research_id: @research.id, user_id: current_user.id)
    end
  end
    respond_to do |format|
      if params[:caller] == 'reg'
        format.html { redirect_to '/registeration_steps?step=4'}
      else
        format.html { render json: @research }
      end
      format.json { head :no_content }
      format.js
    end
  end

  # PATCH/PUT /researches/1
  # PATCH/PUT /researches/1.json
  def update
    @tags = params[:tags].split(',')
    @tagged = []
    for prev in Tagging.where(taggable_id: @research.id, taggable_type: 'Research')
      prev.destroy
    end
    respond_to do |format|
      if @research.update(research_params(params["research"]))
        @activity =  Activity.create(user_id: current_user.id, activity_type: 'Update', target_type: 'Research', target_id: @research.id)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.where(taggable_id: @research.id, taggable_type: 'Research', tag_id: @tag.id).first
            if @tagging.blank?
              @tagging = Tagging.create(taggable_id: @research.id, taggable_type: 'Research', tag_id: @tag.id)
            end
          end
        end
        if params[:caller] == 'reg'
          format.html { redirect_to '/registeration_steps?step=4'}
        else
          format.html { redirect_to '/researches?research_id='+@research.id.to_s , notice: 'Research was successfully updated.' }
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
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Destroy', target_type: 'Research', target_id: @research.id)

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
