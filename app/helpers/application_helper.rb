module ApplicationHelper
  def date
    Time.now
  end
  def content_type_img(file)
  if file.content_type=='image/png'
    image_tag('file_png.png')

  elsif file.content_type=='image/jpeg'
    image_tag('file_jpg.png')
  elsif file.content_type=='image/gif'
    image_tag('file_gif.png')
  elsif file.content_type=='image/tiff'
    image_tag('file_tif.png')
  elsif file.content_type=='application/zip'
    image_tag('box_zip.png')
  elsif  file.content_type=='application/vnd.ms-excel'
     image_tag('file_xls.png')
  elsif  file.content_type=='application/pdf'
     image_tag('file_pdf.png')
  else
    file.content_type
  end

end
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

      ret=content_tag(:ul,top_nav_li,:class=>'topnav')
      ret.html_safe
  end
  def top_nav_li
    ret=''.html_safe
    if signed_in?
    @arr={:Utilisateurs=>{:user_list=>link_to('liste des utilisateurs',users_path),:profile=>
        (profile_show_or_create_link(current_user)),:edit_user=>link_to('Editer l utilisateur',edit_user_path(current_user))},
      :Clients=>{:clients=>link_to('Nouveau client',new_client_path),:client_list=>link_to('liste des clients',clients_path),
                 :current_user_client=>link_to("Clients de l'utilisateur",current_user_clients_path),
                 },
      :Projets=>{:user_projects=>link_to("Projets de l'utilisateur",current_user_projects_path),
                 :projects=>link_to(" tous les Projets ", projects_path)},
      :Gallerie=>{},
      :Fichiers=>{:file_browser=>link_to('Explorer les fichiers',file_browser_path),
                  :user_files=>link_to('Explorer les fichier de l utilisateur',user_files_path)},
      :Liens=>{}}

    @arr.each_pair do|key,value|
      ret=ret+content_tag(:li,"<a href='#'>#{key}</a>".html_safe+sub_nav_ul(value))
    end
    else
      return visitor_menu
    end
     ret.html_safe
  end
  def sub_nav_ul(value)
      ret=''.html_safe
      ret=content_tag(:ul,sub_nav_li(value),:class=>'subnav')
      ret.html_safe
  end

  def sub_nav_li(value)
      ret=''.html_safe
      value.each_value do |value2|
         ret=ret+content_tag(:li,value2)
      end
      ret.html_safe
  end

  def visitor_menu
    return "<li><a href='#'>visitor</a><ul class='subnav'><li><a href='#{root_path}'>root_path</a></li></ul></li>".html_safe
  end
def admin_links(user)
  if signed_in?
    
  return "<ul><li>#{link_to 'Show', user_path(user)} </li>
  <li><%= link_to 'Edit', edit_user_path(#{user}) %></li>
  <li><%= link_to 'Destroy', user_path(#{user}), :confirm => 'Are you
sure', :method => :delete %></ul>".html_safe
end


end
end
