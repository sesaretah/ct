class LabsController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update, :destroy]

  def search
    if !params[:q].blank?
      @labs = Lab.where("name LIKE ? OR about LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Search', target_type: 'Lab')

  end

  def view_content
    @lab = Lab.find(params[:id])
    @rnd = params[:rnd]
    @visit = Visit.where(user_id: current_user.id, visitable_id: @lab.id, visitable_type: 'Lab').first
    if !@visit.blank?
      @visit.destroy
    end
    Visit.create(user_id: current_user.id, visitable_id: @lab.id, visitable_type: 'Lab')
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'View', target_type: 'Lab', target_id: @lab.id)

  end

  def cropper
    @lab = Lab.find(params[:id])
    @caller = params[:caller]
  end
  # GET /labs
  # GET /labs.json
  def index
    @labs = Lab.all
    @lab = Lab.find_by_id(params[:lab_id])
  end

  # GET /labs/1
  # GET /labs/1.json
  def show
  end

  # GET /labs/new
  def new
    @lab = Lab.new
  end

  # GET /labs/1/edit
  def edit
  end

  # POST /labs
  # POST /labs.json
  def create
    @lab = Lab.new(lab_params)
    @lab.user_id = current_user.id
    @tags = params[:tags].split(',')
    @tagged = []

    respond_to do |format|
      if @lab.save
        @activity =  Activity.create(user_id: current_user.id, activity_type: 'Create', target_type: 'Lab', target_id: @lab.id)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.create(taggable_id: @lab.id, taggable_type: 'Lab', tag_id: @tag.id)
          end
        end
        if @lab.chkbxch == 1
          @coupling =  Coupling.where(coupler_id: @lab.id, coupler_type: 'Lab', couplee_type: 'Channel' ).first
          if @coupling.blank?
            @name = t(:channel_coupled_to_lab) + ' ' + @lab.name
            @channel = Channel.create(name: @name, g_type: 2, i_type: 1, p_type: 1, user_id: current_user.id)
            @copuling = Coupling.create(coupler_id: @lab.id, coupler_type: 'Lab', couplee_id:@channel.id , couplee_type: 'Channel')
          end
        end
        if @lab.chkbxgr == 1
          @coupling =  Coupling.where(coupler_id: @lab.id, coupler_type: 'Lab', couplee_type: 'Group' ).first
          if @coupling.blank?
            @name = t(:group_coupled_to_lab) + ' ' + @lab.name
            @group = Group.create(name: @name, g_type: 2, i_type: 1, p_type: 1, user_id: current_user.id)
            @copuling = Coupling.create(coupler_id: @lab.id, coupler_type: 'Lab', couplee_id:@group.id , couplee_type: 'Group')
          end
        end
        if @lab.chkbxbl == 1
          @coupling =  Coupling.where(coupler_id: @lab.id, coupler_type: 'Lab', couplee_type: 'Blog' ).first
          if @coupling.blank?
            @name = t(:blog_coupled_to_lab) + ' ' + @lab.name
            @blog = Blog.create(title: @name, g_type: 2, i_type: 1, p_type: 1, user_id: current_user.id)
            @copuling = Coupling.create(coupler_id: @lab.id, coupler_type: 'Lab', couplee_id:@blog.id , couplee_type: 'Blog')
          end
        end

        if params[:lab][:avatar].blank?
          format.html { redirect_to '/labs?lab_id='+@lab.id.to_s, notice: :lab_was_successfully_created }
        else
          format.html { redirect_to '/labs/cropper/'+@lab.id.to_s}
        end
        format.json { render :show, status: :created, location: @lab }
      else
        format.html { render :new }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /labs/1
  # PATCH/PUT /labs/1.json
  def update
    @tags = params[:tags].split(',')
    @tagged = []
    for prev in Tagging.where(taggable_id: @lab.id, taggable_type: 'Lab')
      prev.destroy
    end
    respond_to do |format|
      if @lab.update(lab_params)

        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.where(taggable_id: @lab.id, taggable_type: 'Lab', tag_id: @tag.id).first
            if @tagging.blank?
              @tagging = Tagging.create(taggable_id: @lab.id, taggable_type: 'Lab', tag_id: @tag.id)
            end
          end
        end

        if @lab.chkbxch == 1
          @activity =  Activity.create(user_id: current_user.id, activity_type: 'Update', target_type: 'Lab', target_id: @lab.id)

          @coupling =  Coupling.where(coupler_id: @lab.id, coupler_type: 'Lab', couplee_type: 'Channel' ).first
          if @coupling.blank?
            @name = t(:channel_coupled_to_lab) + ' ' + @lab.name
            @channel = Channel.create(name: @name, g_type: 2, i_type: 1, p_type: 1, user_id: current_user.id)
            @copuling = Coupling.create(coupler_id: @lab.id, coupler_type: 'Lab', couplee_id:@channel.id , couplee_type: 'Channel')
          end
        end
        if @lab.chkbxgr == 1
          @coupling =  Coupling.where(coupler_id: @lab.id, coupler_type: 'Lab', couplee_type: 'Group' ).first
          if @coupling.blank?
            @name = t(:group_coupled_to_lab) + ' ' + @lab.name
            @group = Group.create(name: @name, g_type: 2, i_type: 1, p_type: 1, user_id: current_user.id)
            @copuling = Coupling.create(coupler_id: @lab.id, coupler_type: 'Lab', couplee_id:@group.id , couplee_type: 'Group')
          end
        end
        if @lab.chkbxbl == 1
          @coupling =  Coupling.where(coupler_id: @lab.id, coupler_type: 'Lab', couplee_type: 'Blog' ).first
          if @coupling.blank?
            @name = t(:blog_coupled_to_lab) + ' ' + @lab.name
            @blog = Blog.create(title: @name, g_type: 2, i_type: 1, p_type: 1, user_id: current_user.id)
            @copuling = Coupling.create(coupler_id: @lab.id, coupler_type: 'Lab', couplee_id:@blog.id , couplee_type: 'Blog')
          end
        end

        if params[:lab][:avatar].blank?
          format.html { redirect_to '/labs?lab_id='+@lab.id.to_s, notice: :lab_was_successfully_updated }
        else
          format.html { redirect_to '/labs/cropper/'+@lab.id.to_s}
        end
      else
        format.html { render :edit }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labs/1
  # DELETE /labs/1.json
  def destroy
    @activity =  Activity.create(user_id: current_user.id, activity_type: 'Destory', target_type: 'Lab', target_id: @lab.id)

    @lab.destroy
    respond_to do |format|
      format.html { redirect_to labs_url, notice: 'Lab was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lab
      @lab = Lab.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lab_params
      params.require(:lab).permit(:name, :about, :missions, :tel, :address, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :caller, :chkbxch, :chkbxgr, :chkbxbl)
    end
end
