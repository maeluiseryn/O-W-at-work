 class FilesController < ApplicationController


   def index

    @uploaded_files = UploadedFiles.all

    respond_to do |format|
      format.html # index.html.erb

    end
  end

  def post_upload
    if params[:post_upload]!=nil
    file = UploadedFiles.save(params[:post_upload])
    redirect_to files_path , :flash => { :success => "The file was successfully uploaded"  }
    else
    redirect_to files_path , :flash => { :error => "Sorry , The file upload failed because no files was selected" }
    end

  end
  def upload
      respond_to do |format|
      format.html # index.html.erb
      end

  end

end


