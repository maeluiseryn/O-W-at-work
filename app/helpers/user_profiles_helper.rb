module UserProfilesHelper
  def set_legend msg
     msg
  end
  def profile_owner user_profile
    user_profile.user
  end
end
