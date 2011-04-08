class UsersController < ApplicationController
  before_filter :authenticate , :only=>[:edit, :update ,:show]
  before_filter :correct_user, :only => [:edit, :update]
  def index
    @title='Users List'
    @users = User.order('id')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users}
    end
  end
  def show
    @user = User.find(params[:id])
    @title=@user.name
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
 def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
end
  def new
     @user = User.new
     @title='New User'

     respond_to do |format|
       format.html # new.html.erb
       format.xml  { render :xml => @user }
       format.js
     end
  end

   # GET /users/1/edit
   def edit
     @user = User.find(params[:id])
   end

   # POST /users
   # POST /users.xml
   def create
     @user = User.new(params[:user])

     respond_to do |format|
       if @user.valid?
         define_path
         @user.create_home_directory(@public_path)
         @user.save
         format.html { redirect_to(@user, :notice => 'User was successfully created.') }
         format.xml  { render :xml => @user, :status => :created, :location => @user }
       else
         format.html { render :action => "new" }
         format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
       end
     end
   end
   def upload_a_file
      session[:model_id]=current_user.id
      session[:model]=current_user.class
      redirect_to :controller =>'files', :action=>'upload'
      end
  def activate_user
    @user=User.find(params[:id])
    @user.activated
    @user.save_switch=true
    @user.save(:validate =>false)
    redirect_to request.referer
  end
   private
  # def authenticate
   #  deny_access unless signed_in?
   #end
  def correct_user
     @user = User.find(params[:id])
     redirect_to(users_path,:notice =>'not authorized to access this user') unless current_user?(@user)
  end

end