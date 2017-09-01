class EducationsController < ApplicationController
  before_action :set_education, only: [:show, :edit, :update, :destroy]

  # GET /educations
  # GET /educations.json
  def index
    @educations = Education.all
  end

  # GET /educations/1
  # GET /educations/1.json
  def show
  end

  # GET /educations/new
  def new
    @edu_history = []
    4.times do
      @edu_history << Education.new
    end
  end

  # GET /educations/1/edit
  def edit
  end

  # POST /educations
  # POST /educations.json
  def create
    if !params["edu_history"].blank?
      params["edu_history"].each do |edu|
        if edu["name"] != ""
          @education = Education.create(education_params(edu))
          @education.user_id = current_user.id
          @education.save
        end
      end
    else
      @education = Education.new(education_params(params["education"]))
      @education.user_id = current_user.id
      @education.save

    end
    @email = current_user.profile.official_email.split("@").first
    respond_to do |format|
      if params[:caller] == 'reg'
        format.html { redirect_to '/registeration_steps?step=3&name='+ @email}
      else
        format.html { redirect_to educations_url, notice: 'Education ....' }
      end
      format.json { head :no_content }
      format.js
    end
  end

  # PATCH/PUT /educations/1
  # PATCH/PUT /educations/1.json
  def update
    respond_to do |format|
      if @education.update(education_params(params["education"]))
        if params[:caller] == 'reg'
          format.html { redirect_to '/registeration_steps?step=3'}
        else
          format.html { redirect_to @education, notice: 'Education was successfully updated.' }
          format.js
        end
        format.json { render :show, status: :ok, location: @education }
      else
        format.html { render :edit }
        format.json { render json: @education.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /educations/1
  # DELETE /educations/1.json
  def destroy
    @education.destroy
    respond_to do |format|
      format.html { redirect_to educations_url, notice: 'Education was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_education
    @education = Education.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def education_params(my_params)
    my_params.permit(:name, :grade, :city, :country, :user_id, :field, :start_year, :end_year, :title, :thesis_gpa)
  end
end
