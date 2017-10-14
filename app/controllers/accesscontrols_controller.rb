class AccesscontrolsController < ApplicationController
  before_action :set_accesscontrol, only: [:show, :edit, :update, :destroy]

  # GET /accesscontrols
  # GET /accesscontrols.json
  def index
    @accesscontrols = Accesscontrol.all
  end

  # GET /accesscontrols/1
  # GET /accesscontrols/1.json
  def show
  end

  # GET /accesscontrols/new
  def new
    @accesscontrol = Accesscontrol.new
  end

  # GET /accesscontrols/1/edit
  def edit
  end

  # POST /accesscontrols
  # POST /accesscontrols.json
  def create
    @accesscontrol = Accesscontrol.new(accesscontrol_params)

    respond_to do |format|
      if @accesscontrol.save
        format.html { redirect_to '/roles', notice: 'Accesscontrol was successfully created.' }
        format.json { render :show, status: :created, location: @accesscontrol }
      else
        format.html { render :new }
        format.json { render json: @accesscontrol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accesscontrols/1
  # PATCH/PUT /accesscontrols/1.json
  def update
    respond_to do |format|
      if @accesscontrol.update(accesscontrol_params)
        format.html { redirect_to '/roles', notice: 'Accesscontrol was successfully updated.' }
        format.json { render :show, status: :ok, location: @accesscontrol }
      else
        format.html { render :edit }
        format.json { render json: @accesscontrol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accesscontrols/1
  # DELETE /accesscontrols/1.json
  def destroy
    @accesscontrol.destroy
    respond_to do |format|
      format.html { redirect_to accesscontrols_url, notice: 'Accesscontrol was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accesscontrol
      @accesscontrol = Accesscontrol.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accesscontrol_params
      params.require(:accesscontrol).permit(:role_id, :create_blog, :view_blogs, :comment_on_blogs, :search_blogs, :create_channel, :view_channels, :join_channels, :search_channels, :create_group, :view_groups, :join_groups, :comment_on_groups, :search_groups, :create_event, :view_events, :join_events, :comment_on_events, :search_events, :view_questions, :comment_on_questions, :ask_questions, :answer_questions, :comment_on_answers, :create_project, :view_projects, :search_projects, :create_course, :view_courses, :search_courses, :create_lab, :view_labs, :search_labs, :create_good, :view_goods, :search_goods, :create_research, :view_researches, :search_researches, :comment_on_researches, :rate_researches, :create_poll, :take_poll, :view_profiles, :search_profiles)
    end
end
