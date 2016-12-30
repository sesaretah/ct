class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def search
    @blogs = Blog.search params[:q], :star => true
    @excerpter = ThinkingSphinx::Excerpter.new 'blog_core', params[:q]   , {
    :before_match    => '<span class="bg-warning">',
    :after_match     => '</span>',
    :chunk_separator => ' &#8230; ' # ellipsis
  }
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
  end

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all
    @blog = Blog.find_by_id(params[:blog_id])
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
    @blog.user_id =current_user.id
    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
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
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
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
