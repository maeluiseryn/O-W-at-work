class FileBrowserController < ApplicationController
  before_filter :define_path


  def define_path
    @public_path = File.join(Rails.root.to_s, 'public')
    @uploads_url = '/data'
    @upload_path = File.join(@public_path, @uploads_url)
    @current_url = params[:dir] || @uploads_url
    @current_path = File.join(@public_path, @current_url)+ '/*'
  end


  def list
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
    notice=UploadedFile.create_file(params['post_upload'],@public_path)
    redirect_to request.referer, :notice => notice
  end

  def delete
    notice=UploadedFile.delete(params[:file],@public_path)
    redirect_to request.referer, :notice => notice
  end
end
 