class InvoicesController < ApplicationController
  # GET /invoices
  # GET /invoices.xml
  def index
    @invoices = Invoice.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.xml
  def show
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invoice }
    end
  end

  # GET /invoices/new
  # GET /invoices/new.xml
  def new
    @project = Project.find(params[:project_id])
    @invoice = @project.invoices.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find(params[:id])
  end

  # POST /invoices
  # POST /invoices.xml
  def create
    @project = Project.find(params[:invoice][:project_id])
    @invoice = Invoice.new(params[:invoice])
    @invoice.remaining_sum=@invoice.total_sum
    respond_to do |format|
      if @invoice.save
        format.html { redirect_to(@invoice, :notice => 'Invoice was successfully created.') }
        format.xml  { render :xml => @invoice, :status => :created, :location => @invoice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.xml
  def update
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        format.html { redirect_to(@invoice, :notice => 'Invoice was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.xml
  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to(invoices_url) }
      format.xml  { head :ok }
    end
  end
 def new_payment
    @invoice=Invoice.find(params[:invoice_id])
    if @invoice.remaining_sum==0
      redirect_to request.referer , :notice=>'Facture deja payee entierement'
    else
           @payment=@invoice.payments.build
           respond_to do |format|
           format.html # new.html.erb
           format.xml  { render :xml => @invoice }
           format.js
         end
    end

 end
  def create_payment
    @invoice=Invoice.find(params[:invoice_id])
    @payment= Payment.new(params[:payment])

    respond_to do |format|
      if @payment.save
         @invoice.payments<<@payment
         @invoice.remaining_sum=(@invoice.remaining_sum-@payment.sum_paid)
         @invoice.save
        format.html { redirect_to(invoice_path(@invoice), :notice => 'Paiement creer.') }

      else
        format.html { redirect_to root_path }

      end
    end

  end
  def destroy_payment
     @payment=Payment.find(params[:payment_id])
     invoice=@payment.invoice
     invoice.remaining_sum=invoice.remaining_sum+@payment.sum_paid
     invoice.save
     @payment.destroy
     redirect_to request.referer
  end
end
