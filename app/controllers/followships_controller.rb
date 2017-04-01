class FollowshipsController < ApplicationController
  before_action :set_followship, only: [:show, :edit, :update, :destroy]

  def unfollow
    @followship = Followship.where(followable_id: params[:followable_id], followable_type: params[:followable_type], user_id: current_user.id).first
    @followship.destroy
    @item =  @followship.followable_type.classify.constantize.find(@followship.followable_id)
  end

  def follow
    @followship = Followship.create(followable_id: params[:followable_id], followable_type: params[:followable_type], user_id: current_user.id)
    @item =  @followship.followable_type.classify.constantize.find(@followship.followable_id)
  end
  # GET /followships
  # GET /followships.json
  def index
    @followships = Followship.all
  end

  # GET /followships/1
  # GET /followships/1.json
  def show
  end

  # GET /followships/new
  def new
    @followship = Followship.new
  end

  # GET /followships/1/edit
  def edit
  end

  # POST /followships
  # POST /followships.json
  def create
    @followship = Followship.new(followship_params)

    respond_to do |format|
      if @followship.save
        format.html { redirect_to @followship, notice: 'Followship was successfully created.' }
        format.json { render :show, status: :created, location: @followship }
      else
        format.html { render :new }
        format.json { render json: @followship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /followships/1
  # PATCH/PUT /followships/1.json
  def update
    respond_to do |format|
      if @followship.update(followship_params)
        format.html { redirect_to @followship, notice: 'Followship was successfully updated.' }
        format.json { render :show, status: :ok, location: @followship }
      else
        format.html { render :edit }
        format.json { render json: @followship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /followships/1
  # DELETE /followships/1.json
  def destroy
    @followship.destroy
    respond_to do |format|
      format.html { redirect_to followships_url, notice: 'Followship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_followship
      @followship = Followship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def followship_params
      params.require(:followship).permit(:user_id, :followable_type, :followable_id)
    end
end
