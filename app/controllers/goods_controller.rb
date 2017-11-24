class GoodsController < ApplicationController
  before_action :set_good, only: [:show, :edit, :update, :destroy]

  def search
    @sub_category_ids = []
    params.each do |name, value|
      if name =~ /chk-(.+)$/
        @sub_category_ids << $1.to_i
      end
    end

    if !@sub_category_ids.blank?
      @goods = Good.where("(name LIKE ? OR description LIKE ?) AND sub_category_id IN(?)", "%#{params[:q]}%", "%#{params[:q]}%", @sub_category_ids)
    else
      @goods = Good.where("name LIKE ? OR description LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    #Good.search params[:q], :with => {sub_category_id: @sub_category_ids },:star => true
  end

  def view_content
    @goods = Good.where(sub_category_id: params[:sub_category])
    if params[:page].blank?
      @page = 1
    else
      @page = params[:page].to_i
    end
  end

  

  # GET /goods
  # GET /goods.json
  def index
    @goods = Good.all
  end

  # GET /goods/1
  # GET /goods/1.json
  def show
  end

  # GET /goods/new
  def new
    @good = Good.new
  end

  # GET /goods/1/edit
  def edit
  end

  # POST /goods
  # POST /goods.json
  def create
    @good = Good.new(good_params)
    @good.deadline = JalaliDate.to_gregorian(params[:good_deadline_yyyy],params[:good_deadline_mm],params[:good_deadline_dd])
    @good.user_id = current_user.id


    respond_to do |format|
      if @good.save
        format.html { redirect_to @good, notice: 'Good was successfully created.' }
        format.json { render :show, status: :created, location: @good }
      else
        format.html { render :new }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goods/1
  # PATCH/PUT /goods/1.json
  def update
    @good.user_id = current_user.id
    respond_to do |format|
      if @good.update(good_params)
        format.html { redirect_to @good, notice: 'Good was successfully updated.' }
        format.json { render :show, status: :ok, location: @good }
      else
        format.html { render :edit }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goods/1
  # DELETE /goods/1.json
  def destroy
    @good.destroy
    respond_to do |format|
      format.html { redirect_to goods_url, notice: 'Good was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_good
      @good = Good.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def good_params
      params.require(:good).permit(:name, :description,:avatar, :price, :user_id, :category_id, :sub_category_id, :deadline)
    end
end
