 class FilesController < ApplicationController
  def download
    file= UploadedFiles.find(params[:id])
    send_file file.path , :type =>file.content_type , :filename => file.filename ,:disposition =>file.disposition
  end

  def index

    @uploaded_files = UploadedFiles.all

    respond_to do |format|
      format.html # index.html.erb

    end
  end

  def post_upload
   if UploadedFiles.is_savable?(params[:post_upload])
     file = UploadedFiles.save(params[:post_upload])
     redirect_to files_path , :flash => { :success => "The file was successfully uploaded "  }
   else
     redirect_to files_path , :flash => { :error => "Sorry , The file upload failed because an error has occurred " }
   end
    
  end
  def upload
      respond_to do |format|
         format.html # index.html.erb
      end

  end
  def destroy
    @file = UploadedFiles.find(params[:id])
    @file.destroy

    respond_to do |format|
      format.html { redirect_to(files_url) }
      format.xml  { head :ok }
   end
  end

end


