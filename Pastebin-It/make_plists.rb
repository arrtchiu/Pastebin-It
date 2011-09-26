#
#  make_plists.rb
#  Pastebin-It
#
#  Created by Matthew Urquhart on 23/09/11.
#  Copyright 2011 XciteLogic Development. All rights reserved.
#

require 'Open3'

class PlistMaker
    def initialize( text_file, plist_file )
        @text_file = text_file
        @plist_file= plist_file
    end
    
    def do_plistbuddy_command( command )        
        _run_command( "/usr/libexec/PlistBuddy", [ "-c", command, @plist_file ] )
    end
    
    def make_plist( txtRegex, value_index, name_index )
        txtFile = File.open( @text_file, "r" )
        unless txtFile.nil?
            txtFile.each_line { |line|
                match = txtRegex.match line
                value = match[value_index]
                name  = match[name_index]
                do_plistbuddy_command( "add '#{name}' string '#{value}'" )
            }
        end
    end
    
    #private methods    
    def _run_command( command, args = [] )
        stdin, stdout, stderr = Open3.popen3( command, *args )
        #while( line = stdout.gets ) do
        #    puts line
        #end
        
        stdin.close
        stdout.close
        stderr.close
    end
end

class FormatPlistMaker < PlistMaker
    def make_plist
        regex = /^(.*) = (.*)$/
        super( regex, 1, 2 )
    end
end

class ExpiryPlistMaker < PlistMaker
    def make_plist
        regex = /^(.*) = (.*)$/
        super( regex, 1, 2 )
    end
end

project_dir = ENV["PROJECT_DIR"]
project_name= ENV["PROJECT_NAME"]
file_dir = "#{project_dir}/#{project_name}"

{   "Format" => "formats",
    "Expiry" => "expiries" }.each do |class_name_prefix, file_name_prefix|
        source_prefix = "#{file_dir}/#{file_name_prefix}"
        source = "#{source_prefix}.txt"
        dest   = "#{source_prefix}.plist"
        eval "#{class_name_prefix}PlistMaker.new( source, dest ).make_plist"
end
