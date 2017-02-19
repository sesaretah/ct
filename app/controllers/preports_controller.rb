class PreportsController < ApplicationController
  before_action :set_preport, only: [:show, :edit, :update, :destroy]

  def remote_preport
    @preport = Preport.new
    @task = Task.find(params[:task_id])
  end
  # GET /preports
  # GET /preports.json
  def index
    @preports = Preport.all
  end

  # GET /preports/1
  # GET /preports/1.json
  def show
  end

  # GET /preports/new
  def new
    @preport = Preport.new
  end

  # GET /preports/1/edit
  def edit
  end

  # POST /preports
  # POST /preports.json
  def create
    @preport = Preport.new(preport_params)
    @preport.task_id = params[:task_id]
    @preport.user_id = current_user.id
    respond_to do |format|
      if @preport.save
        format.html { redirect_to '/projects?project_id='+ @preport.task.project.id.to_s , notice: 'Preport was successfully created.' }
        format.json
      else
        format.html { render :new }
        format.json { render json: @preport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /preports/1
  # PATCH/PUT /preports/1.json
  def update
    respond_to do |format|
      if @preport.update(preport_params)
        format.html { redirect_to @preport, notice: 'Preport was successfully updated.' }
        format.json { render :show, status: :ok, location: @preport }
      else
        format.html { render :edit }
        format.json { render json: @preport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preports/1
  # DELETE /preports/1.json
  def destroy
    @preport.destroy
    respond_to do |format|
      format.html { redirect_to preports_url, notice: 'Preport was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preport
      @preport = Preport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def preport_params
      params.require(:preport).permit(:user_id, :document ,:task_id, :detail, :status)
    end
end
