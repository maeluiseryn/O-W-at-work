 class FilesController < ApplicationController
  def download
    file= UploadedFile.find(params[:id])
    if file.file_exist_on_disk?
      send_file file.path , :type =>file.content_type , :filename => file.filename ,:disposition =>file.disposition
    else
      file.destroy
      redirect_to files_path , :flash => { :error => "Sorry , The file doesn't exist on disk  " }
    end
  end
  def index

    @uploaded_files = UploadedFile.all

    respond_to do |format|
      format.html # index.html.erb

    end
  end

  def post_upload
   if UploadedFile.is_savable?(params[:post_upload])
     if UploadedFile.save(params[:post_upload])
        redirect_to files_path , :flash => { :success => "The file was successfully uploaded "  }
     else
        redirect_to files_path , :flash => { :error => "Sorry , The file wasn't saved properly  " }
     end
   else
     redirect_to files_path , :flash => { :error => "Sorry , The file upload failed because there was no content " }
   end
    
  end
  def upload
      respond_to do |format|
         format.html # index.html.erb
      end

  end
  def destroy
    @file = UploadedFile.find(params[:id])
    @file.delete_file
    @file.destroy

    respond_to do |format|
      format.html { redirect_to(files_url) }
      format.xml  { head :ok }
   end
  end

end


