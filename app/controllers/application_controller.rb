
class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include ApplicationHelper
  def redirect_to_last_visited
   redirect_back_or(root_url)
  end
end
