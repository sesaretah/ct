class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def compose

  end
  def search
    @messages = Message.search params[:q], :star => true
    @excerpter = ThinkingSphinx::Excerpter.new 'message_core', params[:q]   , {
    :before_match    => '<span class="bg-warning">',
    :after_match     => '</span>',
    :chunk_separator => ' &#8230; ' # ellipsis
  }
  end

  def view_content
    @message = Message.find(params[:id])
    if params[:page].blank?
      @page = 1
    else
      @page = params[:page].to_i
    end
  end
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.where('recipient_id OR sender_id', current_user.id , current_user.id ).order('created_at DESC')
    if !params[:message_id].blank?
      @ms = Message.find_by_id(params[:message_id])
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.id
    @recipients =  params[:recipients].split(',')
    respond_to do |format|
      if @message.save
        for recipient in @recipients
          if !recipient.blank?
            @tokenize = recipient.split('-')
            @profile = Profile.where(name: @tokenize[0], surename: @tokenize[1] ).first
            Recipient.create(user_id: @profile.user_id, message_id: @message.id)
        end
        end
        format.html { redirect_to '/messages', notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:sender_id, :recipient_id, :content, :status)
    end
end
