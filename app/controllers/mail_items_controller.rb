class MailItemsController < ApplicationController
  before_action :set_mail_item, only: [:show, :edit, :update, :destroy]


  # GET /mail_items
  # GET /mail_items.json
  def index
    cli = WorkflowConcept::Application::CLI
    @inbox =  WorkflowConcept::Application::INBOX
    @mail_items = MailItem.all
    @mail = @inbox.items
   


    # @events.select do |event| 
    #  if event.is_a? Viewpoint::EWS::Types::NewMailEvent
    #   @mail << @inbox.items.find {|i| i.id == JsonPath.on(@events.first.item_id.to_json, '$..id').first} 
    # end

end

  # GET /mail_items/1
  # GET /mail_items/1.json
  def show
  end

  # GET /mail_items/new
  def new
    @mail_item = MailItem.new
  end

  # GET /mail_items/1/edit
  def edit
  end

  # POST /mail_items
  # POST /mail_items.json
  def create
    @mail_item = MailItem.new(mail_item_params)

    respond_to do |format|
      if @mail_item.save
        format.html { redirect_to @mail_item, notice: 'Mail item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @mail_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @mail_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mail_items/1
  # PATCH/PUT /mail_items/1.json
  def update
    respond_to do |format|
      if @mail_item.update(mail_item_params)
        format.html { redirect_to @mail_item, notice: 'Mail item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mail_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_items/1
  # DELETE /mail_items/1.json
  def destroy
    @mail_item.destroy
    respond_to do |format|
      format.html { redirect_to mail_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_item
      @mail_item = MailItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_item_params
      params.require(:mail_item).permit(:name, :watermark, :date, :item_id, :subject, :body, :sender, :from, :is_read)
    end
  end
