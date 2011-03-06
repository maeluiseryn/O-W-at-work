class UploadedFiles < ActiveRecord::Base
  def self.is_savable?(post_upload)
    if post_upload!=nil
       if post_upload['datafile'].size != 0
       return true
       else
       return false
       end
    else
    return false
    end
  end

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

  def self.save(post_upload)

    @f= UploadedFiles.new
    name =  post_upload['datafile'].original_filename
    directory = "public/data"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(post_upload['datafile'].read) }
    @f.content_type=post_upload['datafile'].content_type
    @f.filename=name
    @f.file_size=post_upload['datafile'].size
    @f.path=path
    @f.save

  
    end


end

