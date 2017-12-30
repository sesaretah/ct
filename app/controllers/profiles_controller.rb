class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def remoteq
    if !params[:q].blank?
      @profiles = Profile.where("name LIKE ? OR surename LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
  resp = []
  for profile in @profiles
    resp <<  "#{profile.name}-#{profile.surename}"
  end
  render :json => resp.to_json, :callback => params['callback']
  end

  def grant_search
    if !params[:q].blank?
      @profiles = Profile.where("name LIKE ? OR surename LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
  end

  def search
    if !params[:q].blank?
      @profiles = Profile.where("name LIKE ? OR surename LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
  end

  def view_grants
    @profile = Profile.find(params[:id])
    @rnd = params[:rnd]
  end

  def view_content
    @profile = Profile.find(params[:id])
    @rnd = params[:rnd]
  end

  def advanced_search
    if !params[:q].blank?
      @profiles = Profile.where("name LIKE ? OR surename LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    @caller = params[:caller]
    @item = params[:class].classify.constantize.find(params[:class_id])

  end

  def upload_avatar
    @profile = Profile.find(params[:id])
  end

  def cropper
    @profile = Profile.find(params[:id])
    @caller = params[:caller]
  end


  def crop
    @profile = Profile.find(params[:id])
    @caller = params[:caller]
    respond_to do |format|
      format.js
    end
  end
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
    @profile = Profile.find_by_id(params[:profile_id])
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    @profile.birthdate = JalaliDate.to_gregorian(params[:ja_birth_yyyy],params[:ja_birth_mm],params[:ja_birth_dd])
    @email = @profile.official_email.split("@").first
    @tags = params[:tags].split(',')
    @tagged = []
    respond_to do |format|
      if @profile.save
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.create(taggable_id: @profile.user.id, taggable_type: 'User', tag_id: @tag.id)
          end
        end
        if params[:caller] == 'reg'
          format.html { redirect_to '/registeration_steps?step=2&name=' + @email}
        else
          format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        end
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    @tags = params[:tags].split(',')
    @tagged = []
    for prev in Tagging.where(taggable_id: @profile.user.id, taggable_type: 'User')
      prev.destroy
    end
    @caller = params[:profile][:caller]
    @profile = current_user.profile
    if !params[:ja_birth_yyyy].blank?
      @profile.birthdate = JalaliDate.to_gregorian(params[:ja_birth_yyyy],params[:ja_birth_mm],params[:ja_birth_dd])
    end
    respond_to do |format|
      if @profile.update(profile_params)
        for tag in @tags
          if !tag.blank?
            @tag = Tag.where(title: tag).first
            if @tag.blank?
              @tag = Tag.create(title: tag, user_id: current_user.id)
            end
            @tagging = Tagging.where(taggable_id: @profile.user.id, taggable_type: 'User', tag_id: @tag.id).first
            if @tagging.blank?
              @tagging = Tagging.create(taggable_id: @profile.user.id, taggable_type: 'User', tag_id: @tag.id)
            end
          end
        end
        if params[:caller] == 'reg'
          format.html { redirect_to '/registeration_steps?step=2&name='}
        else
          if params[:profile][:avatar].blank?
            format.html { redirect_to '/profiles?profile_id='+@profile.id.to_s, notice: :Profile_was_successfully_updated }
          else
            format.html { redirect_to '/profiles/cropper/'+@profile.id.to_s}
          end
        end
        format.json { render action: 'crop' }
        if @profile.cropping?
          format.js { render action: 'crop', :locals => {:caller => @caller, :id => @profile.id} }
        else
          format.js { render action: 'update' }
        end
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:name, :surename, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :caller,:sex, :fathername, :ssn, :birthdate, :phonenumber, :mobilenumber, :official_email, :faculty, :rank, :digest_email)
    end
end
