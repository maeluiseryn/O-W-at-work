class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.xml
  def current_user_projects
    session[:model_id]=nil
    session[:model]=nil
    @projects=current_user.projects
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  def index
    session[:model_id]=nil
    session[:model]=nil
    if params[:client_id]

    @client=Client.find(params[:client_id])
    @projects =@client.projects
    else
     @projects=Project.all
     end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    session[:model_id]=@project.id
    session[:model]=@project.class
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @client=Client.find(params[:client_id])
    @project=@client.projects.new(:client_id =>params[:client_id])
    if !@client.contacts.empty?
    @project.contacts.build :contact_data =>@client.contacts.first.contact_data, :genre=>@client.contacts.first.genre,
                            :description=>@client.contacts.first.description
    else
    @project.contacts.build
    end
    if !@client.addresses.empty?
    @project.build_address :street=>@client.addresses.first.street ,:street_number=>@client.addresses.first.street_number,
                            :floor=>@client.addresses.first.floor , :zip=>@client.addresses.first.zip ,
                            :city=>@client.addresses.first.city , :country =>@client.addresses.first.country ,:description =>@client.addresses.first.description
    else
    @project.build_address
    end
    @project.project_components.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit

    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    #@client=Client.find(params[:project][:client_id])
    @project=Project.new(params[:project])


    respond_to do |format|
      if @project.valid?
         define_path
         current_user.projects<<@project
         @project.create_home_directory(@public_path)
         @project.save

        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(client_projects_url(@project.client_id)) }
      format.xml  { head :ok }
    end
  end
   def upload_a_file
      redirect_to :controller =>'files', :action=>'upload'
   end
   def create_rendez_vous_fiche
     @project=Project.find(params[:id])


     respond_to do |format|
        format.html do

          options={:pdf => "my_pdf", # pdf will download as my_pdf.pdf
        :layout => 'pdf', # uses views/layouts/pdf.haml
        :save_only=>true,
         :save_to_file =>File.join(Rails.root.to_s, "/public#{@project.home_directory}/P#{@project.client_id}C#{@project.project_ref}-#{@project.client.surname}.pdf"),
        :show_as_html => params[:debug].present?}

          render_with_wicked_pdf(options)
          render :layout => 'pdf', :pdf_file=>true
        end
        format.xml
        format.pdf do
        render :pdf => "my_pdf", # pdf will download as my_pdf.pdf
        :layout => 'pdf', # uses views/layouts/pdf.haml
        :show_as_html => params[:debug].present? # renders html version if you set debug=true in URL
      end
    end
   end
   def send_fiche_de_rendez_vous_mail
     project=Project.find params[:id]
     project.send_fiche_de_rendez_vous
     redirect_to(request.referer,:notice =>"Fiche de rendez-vous envoy&eacute;e")
   end
   def send_sav_form_mail
     project=Project.find params[:id]
     project.send_sav_form
    redirect_to(request.referer,:notice =>"Formulaire de service apres-vente envoy&eacute;e")
   end
  def activate_project
    @project =Project.find(params[:id])
    @project.activated
    @project.save
    redirect_to request.referer
  end
  def follow_project
    @project=Project.find(params[:id])
    current_user.projects<<@project
    redirect_to(request.referer ,:notice => "Association faite")
  end
  def assign_project
    @user=User.find(params[:user_id])
    @project=Project.find(params[:id])
    @user.projects<<@project
    redirect_to request.referer ,:notice=>"u #{@user } ,p#{@project}"
  end
end
