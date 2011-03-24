class FileBrowserController < ApplicationController
  
  before_filter :define_path

  def list
    list=UploadedFile.list(@current_path,@public_path,@current_url)
    @dirs=list[:dir]
    @files=list[:file]
    @breadcrumb=list[:breadcrumb]
  end

  def user_list
   define_root(current_user)
    list=UploadedFile.list(@current_path,@public_path,@current_url)
    @dirs=list[:dir]
    @files=list[:file]
    @breadcrumb=list[:breadcrumb]
   
  end
  def create_dir
    notice=UploadedFile.create_directory(params[:new_dir],@public_path)
    redirect_to request.referer, :notice => notice
  end


  def create_file
    notice=UploadedFile.create_file(params['post_upload'],@public_path,current_user)
    redirect_to request.referer, :notice => notice
  end

  def delete
    #file=UploadedFile.find_by_path(params[:file])
    file=UploadedFile.find_by_path(File.join(@public_path,params[:file]))
    if file!=nil
      file.destroy
      notice=file.path+" "
    else
      notice='if it is not a dir it is an error '
    end

    notice=notice+UploadedFile.delete(params[:file],@public_path)
    redirect_to request.referer, :notice => notice
  end
end
 