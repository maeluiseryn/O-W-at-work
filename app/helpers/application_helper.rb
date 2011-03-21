module ApplicationHelper


  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render("shared/"+association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

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
#
# not sure of correct location
#
  def link_to_external url ,link_label
   link_to "#{link_label}" ,"#{url}" , :target=>'_blank'
  end
  def get_contact_type
    Contact.get_contact_type
  end
def authenticate # doublon avec users controller
     deny_access unless signed_in?
 end

  def populate_menu_ul
    ret=''.html_safe
    @arr=[link_to('1', users_path),link_to('2',root_path),link_to('3',user_path(current_user))]
      ret=content_tag(:ul,populate_menu_li(@arr),:class=>'subnav')
      ret.html_safe
  end
  def populate_menu_li(arr)
    ret=''.html_safe
     arr.each do |a|
       ret=ret+content_tag(:li,a)
     end
     ret.html_safe
  end

  def populate_menu
    ret=''.html_safe

      ret=content_tag(:ul,test,:class=>'topnav')
      ret.html_safe
  end
  def test
    @arr={:users=>{:user_list=>link_to('liste des utilisateurs',users_path),:user=>link_to('votre utilisateur',
      (user_path(current_user)))},:clients=>{:client=>link_to('liste des clients',users_path),:client_list=>'link_to_client_list'}}
     ret=''.html_safe
    @arr.each_pair do|key,value|
      ret=ret+content_tag(:li,"<a href='#'>#{key}</a>".html_safe+test2(value))

    end
     ret.html_safe
  end
  def test2(value)
      ret=''.html_safe
      ret=content_tag(:ul,test3(value),:class=>'subnav')
      ret.html_safe
  end

  def test3(value)
      ret=''.html_safe
      value.each_value do |value2|
         ret=ret+content_tag(:li,value2)
      end
      ret.html_safe
  end
end

