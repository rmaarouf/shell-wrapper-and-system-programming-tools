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
      while(1)
        file_name_hash.each do |filename,count|
          if Dir.glob("/**/"+ filename).size>count
            timed_delayed_message(duration)
            message("File __ been created")
            yield
            file_name_hash.delete(filename)
            break
          end
        end
    end
  }
  end




  def alter(duration, list_filenames)

    timed_delayed_message(duration)
    message("File __ been altered")
    yield
  end

  def destroy(duration, list_filenames)

    timed_delayed_message(duration)
    message("File __ been destroyed")
    yield
  end
end
include FileWatcher
creation(5000,["test_created.dummy"]){puts "HEYYY"}
# puts File.new("/**/test.rb")
