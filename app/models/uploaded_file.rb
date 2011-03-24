class UploadedFile < ActiveRecord::Base


  validates :path , :uniqueness =>true


  def disposition
    type=['application/pdf','text/html','text/plain','image/jpeg','image/gif','image/png']
    disposition='attachment'
    type.each do |t|
      if t==self.content_type
        disposition= 'inline'
      end
    end
    return disposition
  end

def self.save(post_upload,public_path)

      uploaded_file= UploadedFile.new


      directory = "/data/uploads/"#must come from object parent

      result_hash=UploadedFile.create_file_with_path(post_upload,public_path,directory,uploaded_file)
      if result_hash[:result]==true
        uploaded_file.save
      end
      return result_hash
  end

  def delete_file(public_path)
    UploadedFile.delete(self.path,public_path)
  end

  def self.create_file(post_upload,public_path)
    uploaded_file=UploadedFile.new
    return ServerFileOperation.create_file(post_upload,public_path)
  end
  def self.create_file_with_path(post_upload,public_path,path,uploaded_file)

    return ServerFileOperation.create_file_with_path(post_upload,public_path,path,uploaded_file)
  end
  def self.create_directory(new_dir,public_path)
   return ServerFileOperation.create_directory(new_dir,public_path)
  end
  def self.delete(file,public_path)
    return ServerFileOperation.delete(file,public_path)
  end
  def self.list(current_path,public_path,current_url)
     return ServerFileOperation.list(current_path,public_path,current_url)
  end
end

