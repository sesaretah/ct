class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def search
    @profiles = Profile.search params[:q], :star => true
    @excerpter = ThinkingSphinx::Excerpter.new 'profile_core', params[:q]   , {
    :before_match    => '<span class="bg-warning">',
    :after_match     => '</span>',
    :chunk_separator => ' &#8230; ' # ellipsis
  }
  end

  def view_content
    @profile = Profile.find(params[:id])
  end

  def advanced_search
    @profiles = Profile.search params[:q], :star => true
    @caller = params[:caller]
    @item = params[:class].classify.constantize.find(params[:class_id])
    @excerpter = ThinkingSphinx::Excerpter.new 'profile_core', params[:q]   , {
    :before_match    => '<span class="bg-warning">',
    :after_match     => '</span>',
    :chunk_separator => ' &#8230; ' # ellipsis
  }
  end

  def upload_avatar
    @profile = Profile.find(params[:id])
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


    respond_to do |format|
      if @profile.save
        if params[:caller] == 'reg'
          format.html { redirect_to '/registeration_steps?step=2'}
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
    @caller = params[:profile][:caller]
    @profile = current_user.profile
    if !params[:ja_birth_yyyy].blank?
      @profile.birthdate = JalaliDate.to_gregorian(params[:ja_birth_yyyy],params[:ja_birth_mm],params[:ja_birth_dd])
    end
    respond_to do |format|
      if @profile.update(profile_params)
        if params[:caller] == 'reg'
          format.html { redirect_to '/registeration_steps?step=2'}
        else
          format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
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
      params.require(:profile).permit(:name, :surename, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :caller,:sex, :fathername, :ssn, :birthdate, :phonenumber, :mobilenumber)
    end
end
