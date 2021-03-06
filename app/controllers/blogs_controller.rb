class BlogsController < ApplicationController
    before_action :authenticate_user!, :except => [:index,:show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def search
    if !params[:q].blank?
      @blogs = Blog.where("title LIKE ? OR description LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")

    end
  end

  def join
    @blog = Blog.find(params[:id])
    @seeking = Seeking.create(user_id: current_user.id, blog_id: @blog.id, role: 3)
    if params[:page].blank?
      @page = 1
    end
  end

  def view_content
    @blog = Blog.find(params[:id])
    if params[:page].blank?
      @page = 1
    else
      @page = params[:page].to_i
    end
    @rnd = params[:rnd]
    @visit = Visit.where(user_id: current_user.id, visitable_id: @blog.id, visitable_type: 'Blog').first
    if !@visit.blank?
      @visit.destroy
    end
    Visit.create(user_id: current_user.id, visitable_id: @blog.id, visitable_type: 'Blog')
  end

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all
    @blog = Blog.find_by_id(params[:blog_id])
    if !@blog.blank?
      @visit = Visit.where(user_id: current_user.id, visitable_id: @blog.id, visitable_type: 'Blog').first
      if !@visit.blank?
        @visit.destroy
      end
      Visit.create(user_id: current_user.id, visitable_id: @blog.id, visitable_type: 'Blog')
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)
    if !current_user.id.blank?
      @blog.user_id =current_user.id
    end
    respond_to do |format|
      if @blog.save
        format.html { redirect_to '/blogs?blog_id='+@blog.id.to_s, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html {  redirect_to '/blogs?blog_id='+@blog.id.to_s, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @blog = Blog.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_params
    params.require(:blog).permit(:title, :user_id, :p_type, :g_type, :i_type)
  end
end
