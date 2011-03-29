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
    @project.contacts.build
    @project.build_address
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
end
