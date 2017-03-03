class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  def search
    if !params[:q].blank?
      @groups = Group.where("name LIKE ? OR description LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    #search params[:q], :star => true
  end

  def view_content
    @group = Group.find(params[:id])
    if params[:page].blank?
      @page = 1
    else
      @page = params[:page].to_i
    end
    @rnd = params[:rnd]
  end

  def upload_avatar
    @group = Group.find(params[:id])
  end

  def cropper
    @group = Group.find(params[:id])
    @caller = params[:caller]
  end


  def crop
    @group = Group.find(params[:id])
    @caller = params[:caller]
    respond_to do |format|
      format.js
    end
  end

  def change_avatar
    @group = Group.find(params[:id])
  end
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
    @group = Group.find_by_id(params[:group_id])
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id
    respond_to do |format|
      if @group.save
        @grouping = Grouping.create(group_id: @group.id, user_id: current_user.id, role: 1)
        format.html { redirect_to '/groups/cropper/'+@group.id.to_s}
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        if @group.cropping?
          format.html { redirect_to '/groups?group_id='+@group.id.to_s, notice: :Group_was_successfully_updated }
        else
          format.html { redirect_to '/groups/cropper/'+@group.id.to_s}
        end
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description, :i_type ,:p_type, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :caller)
    end
end
