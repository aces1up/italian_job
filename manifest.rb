
puts "Processing Manifest"

require 'resolver'

module Kernel
#this Hooks our require to ignore requires from .jar
#as these should already be embedded in the jar if running
#from web_start or jar.exe

	alias_method :old_require_manifest, :require

	def require( path, *args )

		case Monkeybars::Resolver.run_location.to_s
			when 'in_web_start'
				if File.extname( path ) != '.jar'
					old_require_manifest( path, *args )
				end
 		else
      #puts "requiring path : #{path}"
			old_require_manifest( path, *args )
		end
	end

end

puts "Finished Resolver.. Run Location: #{Monkeybars::Resolver.run_location.inspect}"

case Monkeybars::Resolver.run_location
when Monkeybars::Resolver::IN_FILE_SYSTEM
	add_to_classpath '../lib/java/monkeybars-1.0.4.jar'
end

def do_monkeybars_require()
    require 'monkeybars'
    require 'application_controller'
    require 'application_view'
end

def gem_list()
	[
	    #monkeybars
	    'monkeybars-1.0.5',

      #watir webdriver
      'watir-webdriver-0.6.4',
      'selenium-webdriver-2.33.0',
      'childprocess-0.3.9',
      'multi_json-1.3.6',
      'rubyzip-0.9.9',


      #easy Rider
      'C:/Ruby Code/easy_rider-1.0.0/lib',

      #bot framework load path
      'C:/Ruby Code/bot_framework_gem/lib',

	    #mechanize gems
	    'net-http-digest_auth-1.4',
	    'net-http-persistent-2.9',
	    'mime-types-1.24',
	    'unf-0.1.2-java',
	    'domain_name-0.5.12',
	    'http-cookie-1.0.1',
	    'mini_portile-0.5.1',
	    'nokogiri-1.6.0-java',
	    'ntlm-http-0.1.1',
	    'webrobots-0.1.1',
	    'mechanize-2.7.2',
      #'multipart_body',
      'addressable-2.2.6',
         
      #Thread Safe
      'thread_safe-0.0.3',

      #our mail
      'mail-2.5.4',
      'treetop-1.4.12'
     
	 ]

end


def do_in_file_system()
    # Files to be added only when running from the file system go here
    #SET UP OUR LOAD PATHS

	  puts "Doing Load Path from File System..."

	  gem_home = 'c:/jruby-gem-repository/gems/'
	  gem_list.each do |gem_name|

      case
          when gem_name.include?('Ruby Code')
            $LOAD_PATH << gem_name
      else
     			$LOAD_PATH << "#{gem_home}#{gem_name}/lib"
      end

	  end

    #puts "[] -- Load Paths:"
    #$LOAD_PATH.each do |path| puts path end

end

case Monkeybars::Resolver.run_location
    when Monkeybars::Resolver::IN_FILE_SYSTEM
      do_monkeybars_require()
      do_in_file_system()

    when Monkeybars::Resolver::IN_RAKE_FILE
      do_in_file_system()

    when Monkeybars::Resolver::IN_JAR_FILE
      # Files to be added only when run from inside a jar file

    when Monkeybars::Resolver::IN_WEB_START
      # Files to be added only when run from inside java web_start
      puts "Processing WebStart Manifest Start"
      do_monkeybars_require

	    gem_list.each do |gem_name|
          if gem_name.include?('Ruby Code')
              $LOAD_PATH << gem_name.split('/')[-2]
          else
              $LOAD_PATH << gem_name 
          end
      end

	    puts "Processing Webstart Manifest Finished..."
end




