class UserProfilesController < ApplicationController
   def edit
     user=User.find(params[:user_id])
     @user_profile=user.user_profile

     #@user_profile=UserProfile.find(params[:id])

   end

  def show
     user=User.find(params[:user_id])
     @user_profile=user.user_profile
     #@user_profile=UserProfile.find(params[:id])
  end

  def new
    #@user=User.find params[:user_id]
    @user_profile=UserProfile.new
    @user_profile.user_id=params[:user_id]

    respond_to do |format|
       format.html  # new.html.erb
       format.xml  { render :xml => @user_profile }
    end

  end
 def create
    @user_profile = UserProfile.new(params[:user_profile])
    respond_to do |format|
      if @user_profile.save
         format.html { redirect_to(user_user_profiles_path(@user_profile.user_id), :notice => 'User profile was successfully created.') }
         format.xml  { render :xml => @user_profile, :status => :created, :location => @user_profile }
       else
         format.html { render :action => "new" }
         format.xml  { render :xml => @user_profile.errors, :status => :unprocessable_entity }
       end
     end
   end
  def update # !!!!!!! hidden input type can be used to change profile parent
    @user_profile = UserProfile.find(params[:id])

    respond_to do |format|
        if params[:user_profile][:user_id].to_i.eql? @user_profile.user_id
        if @user_profile.update_attributes(params[:user_profile])
          format.html { redirect_to(@user_profile, :notice => 'User was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @user_profile.errors, :status => :unprocessable_entity }
        end
        else
          format.html { redirect_to(@user_profile, :notice => "Foreign key modification attempt.") }
          format.xml  { head :ok }
        end
    end
  end
 def destroy
    @user_profile = UserProfile.find(params[:id])
    @user_profile.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

end
