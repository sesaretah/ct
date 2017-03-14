class GroupingsController < ApplicationController
  before_action :set_grouping, only: [:show, :edit, :update, :destroy]
  def change_stat
    @grouping = Grouping.find(params[:id])
    @group_admin = Grouping.where(user_id: current_user.id, group_id: @grouping.group_id).first
    @group = @grouping.group
    if @group_admin.role == 1
      @grouping.role = 2
      @grouping.save
    end
  end
  def add_to_group
    @group = Group.find(params[:group_id])
    if params[:page].blank?
      @page = 1
    end
    if params[:user_id].blank?
      params[:user_id] = current_user.id
    end
    if @group.p_type != 1
      params[:role] = 3
    end
    @grouping = Grouping.where(user_id: params[:user_id], group_id: params[:group_id], adder_id: params[:adder_id]).first
    if @grouping.blank?
       @grouping = Grouping.create(user_id: params[:user_id], group_id: params[:group_id], adder_id: params[:adder_id], role: params[:role])
     end
  end
  # GET /groupings
  # GET /groupings.json
  def index
    @groupings = Grouping.all
  end

  # GET /groupings/1
  # GET /groupings/1.json
  def show
  end

  # GET /groupings/new
  def new
    @grouping = Grouping.new
  end

  # GET /groupings/1/edit
  def edit
  end

  # POST /groupings
  # POST /groupings.json
  def create
    @grouping = Grouping.new(grouping_params)

    respond_to do |format|
      if @grouping.save
        format.html { redirect_to @grouping, notice: 'Grouping was successfully created.' }
        format.json { render :show, status: :created, location: @grouping }
      else
        format.html { render :new }
        format.json { render json: @grouping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groupings/1
  # PATCH/PUT /groupings/1.json
  def update
    respond_to do |format|
      if @grouping.update(grouping_params)
        format.html { redirect_to @grouping, notice: 'Grouping was successfully updated.' }
        format.json { render :show, status: :ok, location: @grouping }
      else
        format.html { render :edit }
        format.json { render json: @grouping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groupings/1
  # DELETE /groupings/1.json
  def destroy
    @group = @grouping.group
    if params[:page].blank?
      @page = 1
    end
    @grouping.destroy
    respond_to do |format|
      format.html { redirect_to groupings_url, notice: 'Grouping was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grouping
      @grouping = Grouping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grouping_params
      params.require(:grouping).permit(:user_id, :group_id, :adder_id, :role)
    end
end
