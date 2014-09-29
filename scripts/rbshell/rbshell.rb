#!/bin/ruby
require_relative 'shell_programs'

class RubyShell 

    def initialize
        @shell_programs = ShellPrograms.new 
        create_methods_for_programs(@shell_programs.programs)
        define_syntax
        run_shell
    end

    def run_shell
        print '>'
        cmd = gets.chomp
        if cmd.

        end
        begin
        rescue
            print 'invalid argument'
        end
        run
    end

    def create_methods_for_programs(programs)
        programs.each do |key, value|
            program = key.to_s
            define_singleton_method(key){ print "#{system(program)}" }
        end
    end

end

RubyShell.new
