#!/bin/ruby
require_relative 'shell_programs'

class RubyShell 
    def initialize
        @shell_programs = ShellPrograms.new 
        create_methods_for_programs(@shell_programs.programs)
    end

    def create_methods_for_programs(programs)
        programs.each do |key, value|
            program_name = key.to_s
            define_singleton_method(key){ spawn(program_name) }
        end
    end
end

class TestClass < RubyShell
    ls
end

test = TestClass.new
ls
