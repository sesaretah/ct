class GroupsController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show, :view_remote]
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  def search
    if !params[:q].blank?
      @groups = Group.where("name LIKE ? OR description LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Search', target_type: 'Group')

  end

  def view_remote
    @groups = []
    case params['section']
    when 'trophy'
      @j = 0
      for i in Grouping.group('group_id').order('count_id desc').count('id')
        if @j < 10
          @groups << Group.find(i[0])
        end
        @j = @j+1
      end
    when 'mine'
      for pr in Grouping.where(user_id: params[:user_id])
        @groups << pr.group
      end
    when 'related'
      for sug in Suggestion.where(user_id: params[:user_id], suggested_type: 'Group')
        @ev =  sug.suggested_type.classify.constantize.find_by_id(sug.suggested_id)
        if !@ev.blank?
          @groups << @ev
        end
      end
    end
  end

  def view_content
    @group = Group.find(params[:id])
    if params[:page].blank?
      @page = 1
    else
      @page = params[:page].to_i
    end
    @rnd = params[:rnd]
    @visit = Visit.where(user_id: current_user.id, visitable_id: @group.id, visitable_type: 'Group').first
    if !@visit.blank?
      @visit.destroy
    end
    Visit.create(user_id: current_user.id, visitable_id: @group.id, visitable_type: 'Group')
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'View', target_type: 'Group', target_id: @group.id)

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
    if !@group.blank?
      @visit = Visit.where(user_id: current_user.id, visitable_id: @group.id, visitable_type: 'Group').first
      if !@visit.blank?
        @visit.destroy
      end
      Visit.create(user_id: current_user.id, visitable_id: @group.id, visitable_type: 'Group')
      @activity =  Activity.create(user_id: current_user.id, activity_type: 'View', target_type: 'Group', target_id: @group.id)
    end
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
    @tags = params[:tags].split(',')
    @tagged = []
    if !current_user.id.blank?
      @group.user_id = current_user.id
    end
    respond_to do |format|
      if @group.save
        @activity =  Activity.create(user_id: current_user.id, activity_type: 'Create', target_type: 'Group', target_id: @group.id)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.create(taggable_id: @group.id, taggable_type: 'Group', tag_id: @tag.id)
          end
        end
        if params[:group][:avatar].blank?
          format.html { redirect_to '/groups?group_id='+@group.id.to_s, notice: :group_was_successfully_created }
        else
          format.html { redirect_to '/groups/cropper/'+@group.id.to_s}
        end
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
    @tags = params[:tags].split(',')
    @tagged = []
    for prev in Tagging.where(taggable_id: @group.id, taggable_type: 'Group')
      prev.destroy
    end
    respond_to do |format|
      if @group.update(group_params)
        @activity =  Activity.create(user_id: current_user.id, activity_type: 'Update', target_type: 'Group', target_id: @group.id)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.where(taggable_id: @group.id, taggable_type: 'Group', tag_id: @tag.id).first
            if @tagging.blank?
              @tagging = Tagging.create(taggable_id: @group.id, taggable_type: 'Group', tag_id: @tag.id)
            end
          end
        end
        if params[:group][:avatar].blank?
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
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Destroy', target_type: 'Group', target_id: @group.id)
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
      params.require(:group).permit(:name, :description, :i_type ,:p_type, :g_type, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :caller)
    end
end
