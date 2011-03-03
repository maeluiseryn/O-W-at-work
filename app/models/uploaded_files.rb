class UploadedFiles < ActiveRecord::Base

  def self.save(post_upload)

    @f= UploadedFiles.new
    name =  post_upload['datafile'].original_filename
    directory = "public/data"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(post_upload['datafile'].read) }
    @f.path=name
    @f.save
  end
end

