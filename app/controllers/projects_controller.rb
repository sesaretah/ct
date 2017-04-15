class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def search
    if !params[:q].blank?
      @projects = Project.where("name LIKE ? OR aims LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    #search params[:q], :star => true
  end

  def cropper
    @project = Project.find(params[:id])
    @caller = params[:caller]
  end

    def view_content
      @project = Project.find(params[:id])
      @rnd = params[:rnd]
    end
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    @project = Project.find_by_id(params[:project_id])
    #render layout: false
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
    @project.user_id = current_user.id
    respond_to do |format|
      if @project.save
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
    respond_to do |format|
      if @project.update(project_params)
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
