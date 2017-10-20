class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def cropper
    @course = Course.find(params[:id])
    @caller = params[:caller]
  end
  def search
    if !params[:q].blank?
      @courses = Course.where("name LIKE ? OR course_targets LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
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

    respond_to do |format|
      if @course.save
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
    respond_to do |format|
      if @course.update(course_params)
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
