class OfferingsController < ApplicationController
  before_action :set_offering, only: [:show, :edit, :update, :destroy]

  # GET /offerings
  # GET /offerings.json
  def index
    @offerings = Offering.all
  end

  # GET /offerings/1
  # GET /offerings/1.json
  def show
  end

  # GET /offerings/new
  def new
    @offering = Offering.new
  end

  # GET /offerings/1/edit
  def edit
  end

  # POST /offerings
  # POST /offerings.json
  def create
    @offering = Offering.new(offering_params)
    @offering.year = params[:year]
    respond_to do |format|
      if @offering.save
        @course = @offering.course
        if @course.chkbxch == 1
          @coupling =  Coupling.where(coupler_id: @offering.id, coupler_type: 'Offering', couplee_type: 'Channel' ).first
          if @coupling.blank?
            @name = t(:channel_coupled_to_course) + ' ' + @course.name +  ' ' + @offering.period + ' ' + @offering.year.to_s
            @channel = Channel.create(name: @name, g_type: 2, i_type: 1, p_type: 1, user_id: current_user.id)
            @copuling = Coupling.create(coupler_id: @offering.id, coupler_type: 'Offering', couplee_id:@channel.id , couplee_type: 'Channel')
          end
        end
        if @course.chkbxgr == 1
          @coupling =  Coupling.where(coupler_id: @offering.id, coupler_type: 'Offering', couplee_type: 'Group' ).first
          if @coupling.blank?
            @name = t(:group_coupled_to_course) + ' ' + @course.name +  ' ' + @offering.period + ' ' + @offering.year.to_s
            @group = Group.create(name: @name, g_type: 2, i_type: 1, p_type: 1, user_id: current_user.id)
            @copuling = Coupling.create(coupler_id: @offering.id, coupler_type: 'Offering', couplee_id:@group.id , couplee_type: 'Group')
          end
        end
        if @course.chkbxbl == 1
          @coupling =  Coupling.where(coupler_id: @offering.id, coupler_type: 'Offering', couplee_type: 'Blog' ).first
          if @coupling.blank?
            @name = t(:blog_coupled_to_course) + ' ' + @course.name +  ' ' + @offering.period + ' ' + @offering.year.to_s
            @blog = Blog.create(title: @name, g_type: 2, i_type: 1, p_type: 1, user_id: current_user.id)
            @copuling = Coupling.create(coupler_id: @offering.id, coupler_type: 'Offering', couplee_id:@blog.id , couplee_type: 'Blog')
          end
        end
        format.html { redirect_to @offering, notice: 'Offering was successfully created.' }
        format.json { render :show, status: :created, location: @offering }
        format.js
      else
        format.html { render :new }
        format.json { render json: @offering.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offerings/1
  # PATCH/PUT /offerings/1.json
  def update
    respond_to do |format|
      if @offering.update(offering_params)
        format.html { redirect_to @offering, notice: 'Offering was successfully updated.' }
        format.json { render :show, status: :ok, location: @offering }
      else
        format.html { render :edit }
        format.json { render json: @offering.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offerings/1
  # DELETE /offerings/1.json
  def destroy
    @course = @offering.course
    @offering.destroy
    respond_to do |format|
      format.html { redirect_to offerings_url, notice: 'Offering was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offering
      @offering = Offering.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offering_params
      params.require(:offering).permit(:course_id, :user_id, :period, :year, :location)
    end
end
