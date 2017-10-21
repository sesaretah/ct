class PrivacypoliciesController < ApplicationController
  before_action :set_privacypolicy, only: [:show, :edit, :update, :destroy]

  # GET /privacypolicies
  # GET /privacypolicies.json
  def index
    @privacypolicies = Privacypolicy.all
  end

  # GET /privacypolicies/1
  # GET /privacypolicies/1.json
  def show
  end

  # GET /privacypolicies/new
  def new
    @privacypolicy = Privacypolicy.new
  end

  # GET /privacypolicies/1/edit
  def edit
  end

  # POST /privacypolicies
  # POST /privacypolicies.json
  def create
    @privacypolicy = Privacypolicy.new(privacypolicy_params)
    @privacypolicy.user_id = current_user.id
    respond_to do |format|
      if @privacypolicy.save
        format.html { redirect_to '/profiles?profile_id=' + @privacypolicy.user.profile.id.to_s, notice: 'Privacypolicy was successfully created.' }
        format.json { render :show, status: :created, location: @privacypolicy }
      else
        format.html { render :new }
        format.json { render json: @privacypolicy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /privacypolicies/1
  # PATCH/PUT /privacypolicies/1.json
  def update
    @privacypolicy.user_id = current_user.id
    respond_to do |format|
      if @privacypolicy.update(privacypolicy_params)
        format.html { redirect_to '/profiles?profile_id=' + @privacypolicy.user.profile.id.to_s, notice: 'Privacypolicy was successfully updated.' }
        format.json { render :show, status: :ok, location: @privacypolicy }
      else
        format.html { render :edit }
        format.json { render json: @privacypolicy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /privacypolicies/1
  # DELETE /privacypolicies/1.json
  def destroy
    @privacypolicy.destroy
    respond_to do |format|
      format.html { redirect_to privacypolicies_url, notice: 'Privacypolicy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_privacypolicy
      @privacypolicy = Privacypolicy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def privacypolicy_params
      params.require(:privacypolicy).permit(:profile_fathername, :profile_sex, :profile_birthdate, :profile_ssn, :profile_phonenumber, :profile_mobilenumber, :education_all, :research_all, :honor_all, :tag_all, :followers_all, :followess_all)
    end
end
