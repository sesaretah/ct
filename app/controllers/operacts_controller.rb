class OperactsController < ApplicationController
  before_action :set_operact, only: [:show, :edit, :update, :destroy]

  # GET /operacts
  # GET /operacts.json
  def index
    @operacts = Operact.all
  end

  # GET /operacts/1
  # GET /operacts/1.json
  def show
  end

  # GET /operacts/new
  def new
    @operact = Operact.new
  end

  # GET /operacts/1/edit
  def edit
  end

  # POST /operacts
  # POST /operacts.json
  def create
    @operact = Operact.new(operact_params)

    respond_to do |format|
      if @operact.save
        format.html { redirect_to @operact, notice: 'Operact was successfully created.' }
        format.json { render :show, status: :created, location: @operact }
      else
        format.html { render :new }
        format.json { render json: @operact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operacts/1
  # PATCH/PUT /operacts/1.json
  def update
    respond_to do |format|
      if @operact.update(operact_params)
        format.html { redirect_to @operact, notice: 'Operact was successfully updated.' }
        format.json { render :show, status: :ok, location: @operact }
      else
        format.html { render :edit }
        format.json { render json: @operact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operacts/1
  # DELETE /operacts/1.json
  def destroy
    @operact.destroy
    respond_to do |format|
      format.html { redirect_to operacts_url, notice: 'Operact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operact
      @operact = Operact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operact_params
      params.require(:operact).permit(:title, :user_id, :start_date_j, :end_date_j, :country, :city, :utid)
    end
end
