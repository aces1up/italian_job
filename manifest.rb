Dir.glob(File.expand_path(File.dirname(__FILE__) + "/**/*").gsub('%20', ' ')).each do |directory|
  # File.directory? is broken in current JRuby for dirs inside jars
  # http://jira.codehaus.org/browse/JRUBY-2289
  $LOAD_PATH << directory unless directory =~ /\.\w+$/
end
# Some JRuby $LOAD_PATH path bugs to check if you're having trouble:
# http://jira.codehaus.org/browse/JRUBY-2518 - Dir.glob and Dir[] doesn't work
#                                              for starting in a dir in a jar
#                                              (such as Active-Record migrations)
# http://jira.codehaus.org/browse/JRUBY-3247 - Compiled Ruby classes produce
#                                              word substitutes for characters
#                                              like - and . (to minus and dot).
#                                              This is problematic with gems
#                                              like ActiveSupport and Prawn

#===============================================================================
# Monkeybars requires, this pulls in the requisite libraries needed for
# Monkeybars to operate.

require 'resolver'

case Monkeybars::Resolver.run_location
when Monkeybars::Resolver::IN_FILE_SYSTEM
  add_to_classpath '../lib/java/monkeybars-1.0.4.jar'
end

require 'monkeybars'
require 'application_controller'
require 'application_view'

# End of Monkeybars requires
#===============================================================================
#
# Add your own application-wide libraries below.  To include jars, append to
# $CLASSPATH, or use add_to_classpath, for example:
# 
# $CLASSPATH << File.expand_path(File.dirname(__FILE__) + "/../lib/java/swing-layout-1.0.3.jar")
#
# is equivalent to
#
# add_to_classpath "../lib/java/swing-layout-1.0.3.jar"
#
# There is also a helper for adding to your load path and avoiding issues with file: being
# appended to the load path (useful for JRuby libs that need your jar directory on
# the load path).
#
# add_to_load_path "../lib/java"
#

case Monkeybars::Resolver.run_location
when Monkeybars::Resolver::IN_FILE_SYSTEM
  # Files to be added only when running from the file system go here

  #Watir WebDriver Load Paths
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\watir-webdriver-0.6.4\lib'
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\selenium-webdriver-2.33.0\lib'
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\childprocess-0.3.9\lib'
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\multi_json-1.3.6\lib'
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\multi_json-1.3.6\lib'
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\rubyzip-0.9.9\lib'


  #our Jruby-openssl Hopefully compatible with
  #latest jruby_complete Version
  #$LOAD_PATH << 'C:\jruby-gem-repository\gems\jruby-openssl-0.8.8\lib\shared'

  #MECHANIZE REQUIRES
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\nokogiri-1.5.0-java\lib'
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\net-http-persistent-2.8\lib'
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\domain_name\lib'
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\mechanize-2.5.1\lib'
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\multipart_body\lib'
  $LOAD_PATH << 'c:\jruby-gem-repository\gems\net-http-digest_auth-1.1.1\lib'
  $LOAD_PATH << 'c:\jruby-gem-repository\gems\addressable-2.2.6\lib'
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\mime-types-1.18\lib'
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\unf-0.0.5-java\lib'
  $LOAD_PATH << 'c:\jruby-gem-repository\gems\ntlm-http-0.1.1\lib'
  $LOAD_PATH << 'c:\jruby-gem-repository\gems\webrobots\lib'

  #easy Rider
  #$LOAD_PATH << 'C:\jruby-gem-repository\gems\easyrider-0.0.1\lib'
  $LOAD_PATH << 'C:\Ruby Code\easy_rider\lib'

  #bot framework load path
  $LOAD_PATH << 'C:/Ruby Code/bot_framework_gem/lib'

  #Thread Safe
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\thread_safe-0.0.3\lib'

  #our mail
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\mail-2.5.4\lib'
  $LOAD_PATH << 'C:\jruby-gem-repository\gems\treetop-1.4.12\lib'



when Monkeybars::Resolver::IN_JAR_FILE
  # Files to be added only when run from inside a jar file
end
