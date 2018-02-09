class ProjectsController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show, :view_remote, :search]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def search
    if !params[:q].blank?
      @projects = Project.where("name LIKE ? OR aims LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    if params[:uuid].blank?
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Search', target_type: 'Project')
  end
  respond_to do |format|
    format.html
    format.js
    format.json
  end
  end

  def cropper
    @project = Project.find(params[:id])
    @caller = params[:caller]
  end

    def view_content
      @project = Project.find(params[:id])
      @rnd = params[:rnd]
      @visit = Visit.where(user_id: current_user.id, visitable_id: @project.id, visitable_type: 'Project').first
      if !@visit.blank?
        @visit.destroy
      end
      Visit.create(user_id: current_user.id, visitable_id: @project.id, visitable_type: 'Project')
      @activity =  Activity.create(user_id: current_user.id, activity_type: 'View', target_type: 'Project', target_id: @project.id)

    end


    def view_remote
      @projects = []
      @uuid = decrypt(params[:uuid], 'JMMPi51A', params[:iv])
      @user_id = Mobilesetting.where(uuid: @uuid).first.user_id
      case params['section']
      when 'trophy'
        @j = 0
        for i in Followship.where('followable_type = ?', 'Project').group('followable_id').order('count_id desc').count('id')
          if @j < 10
            @projects << Project.find(i[0])
          end
          @j = @j+1
        end
      when 'mine'
        for q in Project.where(user_id: @user_id)
          @projects << q
        end
      when 'related'
        for sug in Suggestion.where(user_id: @user_id, suggested_type: 'Project')
          @ev =  sug.suggested_type.classify.constantize.find_by_id(sug.suggested_id)
          if !@ev.blank?
            @projects << @ev
          end
        end
      end
    end
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    @project = Project.find_by_id(params[:project_id])
    if !@project.blank?
    @visit = Visit.where(user_id: current_user.id, visitable_id: @project.id, visitable_type: 'Project').first
    if !@visit.blank?
      @visit.destroy
    end
    Visit.create(user_id: current_user.id, visitable_id: @project.id, visitable_type: 'Project')
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'View', target_type: 'Project', target_id: @project.id)

  end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @tags = params[:tags].split(',')
    @tagged = []
    @project.user_id = current_user.id
    respond_to do |format|
      if @project.save
        @activity =  Activity.create(user_id: current_user.id, activity_type: 'Create', target_type: 'Project', target_id: @project.id)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.create(taggable_id: @project.id, taggable_type: 'Project', tag_id: @tag.id)
          end
        end
        if params[:project][:avatar].blank?
          format.html { redirect_to '/projects?project_id='+@project.id.to_s, notice: :project_was_successfully_created }
        else
          format.html { redirect_to '/projects/cropper/'+@project.id.to_s}
        end
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @tags = params[:tags].split(',')
    @tagged = []
    for prev in Tagging.where(taggable_id: @project.id, taggable_type: 'Project')
      prev.destroy
    end
    respond_to do |format|
      if @project.update(project_params)
        @activity =  Activity.create(user_id: current_user.id, activity_type: 'Update', target_type: 'Project', target_id: @project.id)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.where(taggable_id: @project.id, taggable_type: 'Project', tag_id: @tag.id).first
            if @tagging.blank?
              @tagging = Tagging.create(taggable_id: @project.id, taggable_type: 'Project', tag_id: @tag.id)
            end
          end
        end
        if params[:project][:avatar].blank?
          format.html { redirect_to '/projects?project_id='+@project.id.to_s, notice: :project_was_successfully_updated }
        else
          format.html { redirect_to '/projects/cropper/'+@project.id.to_s}
        end
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Destroy', target_type: 'Project', target_id: @project.id)
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name,:project_type, :location, :definition , :novelties, :methods, :standards, :outputs, :aims, :owner, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :caller)
    end
end
