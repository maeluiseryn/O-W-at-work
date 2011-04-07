class MessageBoxesController < ApplicationController
  # GET /message_boxes
  # GET /message_boxes.xml
  def index
    @message_boxes = MessageBox.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @message_boxes }
    end
  end

  # GET /message_boxes/1
  # GET /message_boxes/1.xml
  def show
    @message_box = MessageBox.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message_box }
    end
  end

  # GET /message_boxes/new
  # GET /message_boxes/new.xml
  def new
    @message_box = MessageBox.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message_box }
    end
  end

  # GET /message_boxes/1/edit
  def edit
    @message_box = MessageBox.find(params[:id])
  end

  # POST /message_boxes
  # POST /message_boxes.xml
  def create
    @message_box = MessageBox.new(params[:message_box])

    respond_to do |format|
      if @message_box.save
        format.html { redirect_to(@message_box, :notice => 'Message box was successfully created.') }
        format.xml  { render :xml => @message_box, :status => :created, :location => @message_box }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message_box.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /message_boxes/1
  # PUT /message_boxes/1.xml
  def update
    @message_box = MessageBox.find(params[:id])

    respond_to do |format|
      if @message_box.update_attributes(params[:message_box])
        format.html { redirect_to(@message_box, :notice => 'Message box was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message_box.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /message_boxes/1
  # DELETE /message_boxes/1.xml
  def destroy
    @message_box = MessageBox.find(params[:id])
    @message_box.destroy

    respond_to do |format|
      format.html { redirect_to(message_boxes_url) }
      format.xml  { head :ok }
    end
  end
  
end
