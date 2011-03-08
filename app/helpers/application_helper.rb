module ApplicationHelper


 def title # Method definition
   base_title = "Only-Wood Web"
   if @title.nil?
     base_title
   else
     "#{base_title} | #{@title}"
   end
 end
 def show_flash
   render :partial => "shared/flash", :locals => {:flash => flash}

 end
  def show_sign_in_status
      if signed_in?
         render:partial => 'shared/signed'
      else
         render :partial => "shared/not_signed"
      end
  end
end
