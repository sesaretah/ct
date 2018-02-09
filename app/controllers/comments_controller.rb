class CommentsController < ApplicationController
  before_action :authenticate_user!, :except => [:create_remote,:load5]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def load5
    @comments = Comment.where(commentable_type: params[:commentable_type].singularize.classify, commentable_id: params[:commentable_id]).where('id < ?', params[:firstid].to_i).last(5)
  #  @item =  @comments.first.commentable_type.classify.constantize.find(@comments.first.commentable_id)
    render 'comments/render_remote.json.jbuilder'
  end

  def create_remote
    @uuid = decrypt(params[:uuid], 'JMMPi51A', params[:iv])
    @user_id = Mobilesetting.where(uuid: @uuid).first.user_id
    @comment = Comment.create(commentable_type: params[:commentable_type], commentable_id: params[:commentable_id], content: params[:content], user_id: @user_id, avatar: params[:avatar])
    @item =  @comment.commentable_type.classify.constantize.find(@comment.commentable_id)
    @comments = @item.comments.last(5)
    render 'comments/render_remote.json.jbuilder'
  end

  def render_partial
  @comment = Comment.find(params[:id])
  @cl = @comment.commentable_type.downcase
  @item =  @comment.commentable_type.classify.constantize.find(@comment.commentable_id)
  render :json => {
    :html => render_to_string({
      :partial => "#{@cl.pluralize}/detail",
      :locals => { :"#{@cl}" => @item, page: params[:page].to_i}
    })
  }
end

  def xedit
    @comment = Comment.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.content = params[:value]
      @comment.save
      @activity =  Activity.create(user_id: @comment.user_id, activity_type: 'Edit', target_type: @comment.commentable_type, target_id: @comment.commentable_id, middle_type: 'Comment', middle_id: @comment.id)
    end
  end
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  skip_before_filter :verify_authenticity_token, :only => :create
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @page = params[:page].to_i
    @item =  @comment.commentable_type.classify.constantize.find(@comment.commentable_id)
    respond_to do |format|
      if @comment.save
        @activity =  Activity.create(user_id: @comment.user_id, activity_type: 'Create', target_type: @comment.commentable_type, target_id: @comment.commentable_id, middle_type: 'Comment', middle_id: @comment.id)
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
        format.js
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @commntable = @comment.commentable_type.classify.constantize.find(@comment.commentable_id)
    @page = params[:page].to_i
    @activity =  Activity.create(user_id: @comment.user_id, activity_type: 'Edit', target_type: @comment.commentable_type, target_id: @comment.commentable_id, middle_type: 'Comment', middle_id: @comment.id)
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :user_id,:document, :avatar, :commentable_type, :commentable_id)
    end
end
