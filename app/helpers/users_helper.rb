module UsersHelper
  def profile_show_or_create user
    if user.has_profile?
        link_to 'View Profile',user_user_profiles_path(user)
    else
        link_to 'Create Profile',new_user_user_profiles_path(user)
    end

  end
  def profile_create_or_edit
    
  end

end
