require_relative 'TimedMessage'

module FileWatcher
  include TimedMessage
  def creation(duration, list_filenames)
    file_name_hash=Hash.new
    list_filenames.each do |filename|
      file_name_hash[filename]= Dir.glob("/**/"+ filename).size
    end
    # pre con
    fork {
      while(!file_name_hash.empty?)
        file_name_hash.each do |filename,count|
          if Dir.glob("/**/"+ filename).size>count
            timed_delayed_message(duration)
            message("File __ been created")
            yield
            file_name_hash.delete(filename)
          end
        end
    end
  }
  end




  def alter(duration, list_filenames)
    # HAVE TO CHECK THAT FILES DON"T EXIST
    time_check=Time.new
    # pre con
    fork {
      while(!list_filenames.empty?)
        list_filenames.each do |filename|

          # if Dir.glob("/**/"+ filename).size>count
          Dir.glob("/**/"+ filename).each do |filepath|
            if File.mtime(filepath)>time_check
              timed_delayed_message(duration)
              message("File __ been created")
              yield
              list_filenames.delete(filename)
            end
          end
        end
    end
  }

  end

  def destroy(duration, list_filenames)
    file_name_hash=Hash.new
    list_filenames.each do |filename|
      file_name_hash[filename]= Dir.glob("/**/"+ filename).size
    end
    # pre con
    fork {
      while(!file_name_hash.empty?)
        file_name_hash.each do |filename,count|
          if Dir.glob("/**/"+ filename).size<count
            timed_delayed_message(duration)
            message("File __ been created")
            yield
            file_name_hash.delete(filename)
          end
        end
    end
  }
  end
end

# puts File.new("/**/test.rb")
