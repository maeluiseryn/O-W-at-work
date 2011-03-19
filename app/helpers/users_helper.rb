module UsersHelper
  def profile_show_or_create_link user
    if user.has_profile?
        link_to 'View Profile',user_user_profiles_path(user)
    else
        link_to 'Create Profile',new_user_user_profiles_path(user)
    end

  end
  def profile_create_or_edit user
    if user.has_profile?
            link_to 'Edit Profile',edit_user_user_profiles_path(user)
        else
            link_to 'Create Profile',new_user_user_profiles_path(user)
        end

    
  end
  def has_clients? user
    if user.clients.empty?
      return false
    else
      return true
    end
  end
 def show_clients user
   if has_clients? user
      render :partial=> 'clients/client_list',:collection => @user.clients ,:as=>:client
   end
 end

end
