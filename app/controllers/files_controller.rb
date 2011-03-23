 class FilesController < ApplicationController
   before_filter :define_path

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

     if UploadedFile.save(params[:post_upload],@public_path)[:result]==true
        redirect_to files_path , :flash => { :success => "The file was successfully uploaded "  }
     else
        redirect_to files_path , :flash => { :error => "Sorry , The file wasn't saved properly  " }
     end

   end
    

  def upload
      respond_to do |format|
         format.html # index.html.erb
      end

  end
  def destroy
    @file = UploadedFile.find(params[:id])
    @file.delete_file(@public_path)
    @file.destroy

    respond_to do |format|
      format.html { redirect_to request.referer }
      format.xml  { head :ok }
   end
  end

end


