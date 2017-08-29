class NotesController < ApplicationController
      before_action :authenticate_user!, :except => [:index,:show]
  before_action :set_note, only: [:show, :edit, :update, :destroy]


  def view_content
    @note = Note.find(params[:id])
    if params[:page].blank?
      @page = 1
    else
      @page = params[:page].to_i
    end
  end
  # GET /notes
  # GET /notes.json
  def index
    #@notes = Note.all
    @latest_notes = Note.all
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @blog = @note.blog
  end

  # GET /notes/new
  def new
    @note = Note.new
    @blog = Seeking.where(user_id: current_user.id, role: 1).first.blog
    render layout: false
  end

  # GET /notes/1/edit
  def edit
    @blog = Seeking.where(user_id: current_user.id, role: 1).first.blog
    render layout: false
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @blog = Seeking.where(user_id: current_user.id, role: 1).first.blog
    @note.blog_id = @blog.id
    #@latest_notes = Note.all

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
        format.js
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to '/blogs?blog_id='+@note.blog_id.to_s, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:content, :user_id, :title)
    end
end
