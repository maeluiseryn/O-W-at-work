class ServerFileOperation
    def initialize

    end
    def self.is_savable?(post_upload)
       if post_upload!=nil
      if !post_upload['datafile'].nil?
      if post_upload['datafile'].size != 0
       return true
       else
       return false

       end

       end
    else
    return false
    end

    end
    def self.create_file(post_upload,public_path)
    if is_savable?(post_upload)
    save_path=post_upload['path']
    name =post_upload['datafile'].original_filename
    path = File.join("#{public_path}#{save_path}", name)

    File.open(path, "wb") { |f| f.write(post_upload['datafile'].read) }
    if File.exist?("#{path}")
       notice='file uploaded'
    else
       notice='error'
    end
    else
       notice='no content'
    end
      return notice
  end
  def self.create_directory(new_dir,public_path)
    slugged_name = slugify new_dir[:name]
    path = File.join(public_path, new_dir[:path])
    create_path = File.join(path, slugged_name)

    if secured_path?(path,public_path) && !File.exist?(create_path) && FileUtils.mkdir(create_path)
      notice = 'Directory "%s" was successfully created' % slugged_name
    else
      notice = 'Directory "%s" could not be created' % slugged_name
    end
    return notice
  end

  def self.delete(file,public_path)
    file_path = File.join(public_path, file)
    if secured_path?(file_path,public_path) && FileUtils.rm_r(file_path)
      notice = '"%s" was successfully deleted' % File.basename(file)
    else
      notice = '"%s" could not be deleted' % File.basename(file)
    end
  end

  def self.slugify(value)
    return value.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s\
          .downcase\
          .gsub(/[']+/, '')\
          .gsub(/\W+/, ' ')\
          .strip\
          .gsub(' ', '-')
  end

  def self.secured_path?(file_path,public_path)
    return File.exist?(file_path) && ! File.dirname(file_path).index(public_path).nil?
  end
  def self.list(current_path,public_path,current_url)
     dirs = []
     files = []
    Dir.glob(current_path).sort.each do |file|
      file_obj = {
          :url => file.gsub(public_path, ''),
          :name => File.basename(file),
        }
      if File.directory?(file)
        dirs << file_obj
      else
        file_obj.merge!({
          :type => ['gif','jpg','jpeg','png'].index(File.extname(file)[1..-1]) ? :image : :file,
          :icon => '/images/file.png',
        })
        puts file_obj[:type]
        if file_obj[:type] == :image
          file_obj[:icon] = file_obj[:url]
        end
        files << file_obj
      end
    end

    breadcrumb = []
    curr_crumb = ''
    current_url.each_line(File::SEPARATOR) do |crumb|
      crumb.gsub!('/', '')
      if crumb != ''
        curr_crumb += File::SEPARATOR + crumb
        puts curr_crumb
        breadcrumb << {
          :name => crumb,
          :url => curr_crumb,
        }
      end
    end
  return{:dir=>dirs,:file=>files,:breadcrumb=>breadcrumb}
  end
end