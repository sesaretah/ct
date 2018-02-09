class CoursesController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :view_remote, :search]
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def cropper
    @course = Course.find(params[:id])
    @caller = params[:caller]
  end
  def search
    if !params[:q].blank?
      @courses = Course.where("name LIKE ? OR course_targets LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
      if params[:uuid].blank?
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Search', target_type: 'Course')
  end
  respond_to do |format|
    format.html
    format.js
    format.json
  end
  end

  def view_content
    @course = Course.find(params[:id])
    @rnd = params[:rnd]
    @visit = Visit.where(user_id: current_user.id, visitable_id: @course.id, visitable_type: 'Course').first
    if !@visit.blank?
      @visit.destroy
    end
    Visit.create(user_id: current_user.id, visitable_id: @course.id, visitable_type: 'Course')
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'View', target_type: 'Course', target_id: @course.id)

  end


  def view_remote
    @courses = []
    @uuid = decrypt(params[:uuid], 'JMMPi51A', params[:iv])
    @user_id = Mobilesetting.where(uuid: @uuid).first.user_id
    case params['section']
    when 'trophy'
      @j = 0
      for i in Followship.where('followable_type = ?', 'Course').group('followable_id').order('count_id desc').count('id')
        if @j < 10
          @courses << Course.find(i[0])
        end
        @j = @j+1
      end
    when 'mine'
      for q in Course.where(user_id: @user_id )
        @courses << q
      end
    when 'related'
      for sug in Suggestion.where(user_id: @user_id , suggested_type: 'Course')
        @ev =  sug.suggested_type.classify.constantize.find_by_id(sug.suggested_id)
        if !@ev.blank?
          @courses << @ev
        end
      end
    end
  end
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
    @course = Course.find_by_id(params[:course_id])
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    @course.user_id = current_user.id
    @tags = params[:tags].split(',')
    @tagged = []

    respond_to do |format|
      if @course.save
        @activity =  Activity.create(user_id: current_user.id, activity_type: 'Create', target_type: 'Course', target_id: @course.id)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.create(taggable_id: @course.id, taggable_type: 'Course', tag_id: @tag.id)
          end
        end
        if params[:course][:avatar].blank?
          format.html { redirect_to '/courses?course_id='+@course.id.to_s, notice: :course_was_successfully_created }
        else
          format.html { redirect_to '/courses/cropper/'+@course.id.to_s}
        end
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    @tags = params[:tags].split(',')
    @tagged = []
    for prev in Tagging.where(taggable_id: @course.id, taggable_type: 'Course')
      prev.destroy
    end
    respond_to do |format|
      if @course.update(course_params)
        @activity =  Activity.create(user_id: current_user.id, activity_type: 'Update', target_type: 'Course', target_id: @course.id)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.where(taggable_id: @course.id, taggable_type: 'Course', tag_id: @tag.id).first
            if @tagging.blank?
              @tagging = Tagging.create(taggable_id: @course.id, taggable_type: 'Course', tag_id: @tag.id)
            end
          end
        end
        if params[:course][:avatar].blank?
          format.html { redirect_to '/courses?course_id='+@course.id.to_s, notice: :course_was_successfully_created }
        else
          format.html { redirect_to '/courses/cropper/'+@course.id.to_s}
        end
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Destroy', target_type: 'Course', target_id: @course.id)

    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :course_type, :course_field, :course_grade, :course_points, :lecturer_id, :course_targets, :course_results, :course_covered, :course_softwares, :problems_period, :garding_mechanism, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :caller, :chkbxch, :chkbxgr, :chkbxbl)
    end
end
