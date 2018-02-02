class QuestionsController < ApplicationController
    before_action :authenticate_user!, :except => [:index,:show, :view_remote, :search]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def search
    if !params[:q].blank?
      @questions = Question.where("title LIKE ? OR content LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    if params[:user_id].blank?
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Search', target_type: 'Question')
  end
  respond_to do |format|
    format.html
    format.js
    format.json
  end
  end

  def view_content
    @question = Question.find(params[:id])
    if params[:page].blank?
      @page = 1
    else
      @page = params[:page].to_i
    end
    @rnd = params[:rnd]
    @visit = Visit.where(user_id: current_user.id, visitable_id: @question.id, visitable_type: 'Question').first
    if !@visit.blank?
      @visit.destroy
    end
    Visit.create(user_id: current_user.id, visitable_id: @question.id, visitable_type: 'Question')
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'View', target_type: 'Question', target_id: @question.id)

  end

  def view_remote
    @questions = []
    @user_id = decrypt(params[:user_id], 'JMMPi51A', params[:iv]).to_i
    case params['section']
    when 'trophy'
      @j = 0
      for i in Followship.where('followable_type = ?', 'Question').group('followable_id').order('count_id desc').count('id')
        if @j < 10
          @questions << Question.find(i[0])
        end
        @j = @j+1
      end
    when 'mine'
      for q in Question.where(user_id: @user_id)
        @questions << q
      end
    when 'related'
      for sug in Suggestion.where(user_id: @user_id, suggested_type: 'Question')
        @ev =  sug.suggested_type.classify.constantize.find_by_id(sug.suggested_id)
        if !@ev.blank?
          @questions << @ev
        end
      end
    end
  end
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
    @question = Question.find_by_id(params[:question_id])
    if !@question.blank?
      @visit = Visit.where(user_id: current_user.id, visitable_id: @question.id, visitable_type: 'Question').first
      if !@visit.blank?
        @visit.destroy
      end
      Visit.create(user_id: current_user.id, visitable_id: @question.id, visitable_type: 'Question')
      @activity =  Activity.create(user_id: current_user.id, activity_type: 'View', target_type: 'Question', target_id: @question.id)

    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    @tags = params[:tags].split(',')
    @tagged = []


    respond_to do |format|
      if @question.save
        @activity =  Activity.create(user_id: current_user.id, activity_type: 'Create', target_type: 'Question', target_id: @question.id)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.create(taggable_id: @question.id, taggable_type: 'Question', tag_id: @tag.id)
          end
        end
        format.html { redirect_to "/questions?question_id=#{@question.id}", notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    @tags = params[:tags].split(',')
    @tagged = []
    for prev in Tagging.where(taggable_id: @question.id, taggable_type: 'Question')
      prev.destroy
    end
    respond_to do |format|
      if @question.update(question_params)
        @activity =  Activity.create(user_id: current_user.id, activity_type: 'Update', target_type: 'Question', target_id: @question.id)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.where(taggable_id: @question.id, taggable_type: 'Question', tag_id: @tag.id).first
            if @tagging.blank?
              @tagging = Tagging.create(taggable_id: @question.id, taggable_type: 'Question', tag_id: @tag.id)
            end
          end
        end
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Destroy', target_type: 'Question', target_id: @question.id)
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:title, :content, :user_id)
  end
end
