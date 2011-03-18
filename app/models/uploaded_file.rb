class UploadedFile < ActiveRecord::Base

  validates :path , :uniqueness =>true

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

  def create_file_on_disk (datafile)
    if !file_exist_on_disk?
      File.open(path, "wb") { |f| f.write(datafile.read) }
      return true
    else
      return false
    end
  end

  def self.create_file_on_disk (path, datafile)
    if !file_exist_on_disk(path)
    File.open(path, "wb") { |f| f.write(datafile.read) }
    @f.path=path
    @f.filename=datafile.original_filename
    @f.content_type=datafile.content_type
    @f.file_size=datafile.size
    return true
    else
     new_path=change_path(path)
     create_file_on_disk(new_path,datafile)
    end
  end

  #def create_directory_on_disk
     #if !directory_exist_on_disk?
      # Dir.mkdir path
     #end
  #end
  def self.change_path(path)
     array=path.partition('.')
     array[0]<<'bis'
     @f.path=array.join
  end

  def self.create_directory_on_disk (path)
       if !directory_exist_on_disk path
         Dir.mkdir path
       end
    end

  def file_exist_on_disk?
    File.exist? path
  end

  def directory_exist_on_disk?
     File.directory? path
  end
  def self.file_exist_on_disk (path)
    File.exist?(path)
  end

  def self.directory_exist_on_disk (directory)
     File.directory? directory
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

      @f= UploadedFile.new

      name =  post_upload['datafile'].original_filename
      directory = "public/data/"
      # create the file path
      path = File.join(directory, name)
      # write the file
      create_directory_on_disk(directory)
      if create_file_on_disk(path,post_upload['datafile'])
        @f.save
      else
        @f.destroy
        return false
      end

  end
  def delete_file
    if file_exist_on_disk?
    File.delete(self.path)
    end
  end

end

