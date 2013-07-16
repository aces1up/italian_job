module Monkeybars
  class Resolver

    IN_FILE_SYSTEM = :in_file_system
    IN_JAR_FILE    = :in_jar_file
    IN_RAKE_FILE   = :in_rake_file
    IN_WEB_START   = :in_web_start

    # Returns a const value indicating if the currently executing code is being run from the file system or from within a jar file.
    def self.run_location

      if defined?(RAKE_RUN)
        return IN_RAKE_FILE
      end

      if File.expand_path(__FILE__) =~ /\.jar\!/
         return IN_WEB_START
      end

      if File.expand_path(__FILE__).to_s.include?('resolver.class') then
         return IN_WEB_START
      end

      IN_FILE_SYSTEM
    end
    
  end
end

class Object
  def add_to_classpath(path)
    $CLASSPATH << get_expanded_path(path)
  end
  
  def add_to_load_path(path)
    $LOAD_PATH << get_expanded_path(path)
  end
  
  private
  def get_expanded_path(path)
    resolved_path = File.expand_path(File.dirname(__FILE__) + "/" + path.gsub("\\", "/"))
    resolved_path.gsub!("file:", "") unless resolved_path.index(".jar!")
    resolved_path.gsub!("%20", ' ')
    resolved_path
  end
end
