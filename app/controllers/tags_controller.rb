class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.all
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.json
  def create
    if  !params["tags"].blank?
    params["tags"].each do |tag|
      if tag["title"] != ""
        @tag = Tag.create(tag_params(tag))
        @tag.user_id = current_user.id
        @tag.save
      end
    end
  else
    @tag = Tag.new(tag_params(params["tag"]))
    @tag.user_id = current_user.id
    @tag.save
  end
    respond_to do |format|
      if params[:caller] == 'reg'
        format.html { redirect_to '/'}
      else
        format.html { redirect_to tags_url, notice: 'Education ....' }
        format.js
      end
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params(params["tag"]))
        if params[:caller] == 'reg'
          format.html { redirect_to '/'}
        else
          format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @tag }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'Tag was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params(my_params)
      my_params.permit(:title)
    end
end
