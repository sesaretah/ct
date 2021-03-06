class MobilesettingsController < ApplicationController
  before_action :set_mobilesetting, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:remote_token]

  def remote_token
    @token = params[:token]
    @uuid = decrypt(params[:uuid], 'JMMPi51A', params[:iv])
    @user_id = Mobilesetting.where(uuid: @uuid).first.user_id
    @mobilesetting = Mobilesetting.where(user_id: @user_id).first
    @mobilesetting.token = @token
    @mobilesetting.save
    render layout: false
  end
  # GET /mobilesettings
  # GET /mobilesettings.json
  def index
    @mobilesettings = Mobilesetting.all
  end

  # GET /mobilesettings/1
  # GET /mobilesettings/1.json
  def show
      if @mobilesetting.uuid.blank?
        @mobilesetting.uuid = SecureRandom.hex(16)
        @mobilesetting.save
      end
      @t = {}
      @t['secret'] = @mobilesetting.securephrase
      @t['uuid'] = @mobilesetting.uuid
      @qrcode = RQRCode::QRCode.new(@t.to_json)
  end

  # GET /mobilesettings/new
  def new
    @mobilesetting = Mobilesetting.new
  end

  # GET /mobilesettings/1/edit
  def edit
  end

  # POST /mobilesettings
  # POST /mobilesettings.json
  def create
    @mobilesetting = Mobilesetting.new(mobilesetting_params)
    @mobilesetting.user_id = current_user.id
    @mobilesetting.securephrase = SecureRandom.hex(8)
    respond_to do |format|
      if @mobilesetting.save
        format.html { redirect_to @mobilesetting, notice: 'Mobilesetting was successfully created.' }
        format.json { render :show, status: :created, location: @mobilesetting }
      else
        format.html { render :new }
        format.json { render json: @mobilesetting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mobilesettings/1
  # PATCH/PUT /mobilesettings/1.json
  def update
    respond_to do |format|
      if @mobilesetting.update(mobilesetting_params)
        format.html { redirect_to @mobilesetting, notice: 'Mobilesetting was successfully updated.' }
        format.json { render :show, status: :ok, location: @mobilesetting }
      else
        format.html { render :edit }
        format.json { render json: @mobilesetting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mobilesettings/1
  # DELETE /mobilesettings/1.json
  def destroy
    @mobilesetting.destroy
    respond_to do |format|
      format.html { redirect_to mobilesettings_url, notice: 'Mobilesetting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mobilesetting
      @mobilesetting = Mobilesetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mobilesetting_params
      params.require(:mobilesetting).permit(:user_id, :securephrase, :access_via_mobile)
    end
end
