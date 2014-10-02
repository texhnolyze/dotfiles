#!/bin/ruby
require_relative 'shell_programs'
require 'shellwords'

class RubyShell 
    BUILTINS = { 
        'cd' => lambda { |dir| Dir.chdir(dir) },
        'quit' => lambda { exit },
        'exit' => lambda { exit }
    }

    def initialize(shell_programs)
        create_methods_for_shell_programs(shell_programs.programs)
    end

    def run_shell
        loop do
            print 'rbsh >>'
            evaluate_command(gets.chomp)
        end
    end

    def evaluate_command(input)
        if builtin_command?(input)
            execute_builtin_command(input)
        else
            execute_ruby_command(input)
        end
    end

    def execute_builtin_command(input)
        command, *arguments = Shellwords.shellsplit(input)
        BUILTINS[command].call(*arguments)
    end

    def execute_ruby_command(input)
        begin
            puts eval(input)
        rescue
            puts 'invalid argument'
        end
    end

    def create_methods_for_shell_programs(programs)
        programs.each do |key, value|
            define_singleton_method(key) do 
                run_shell_process(key.to_s) 
            end
        end
    end

    def run_shell_process(program)
        pid = fork { exec(program) }
        Process.wait pid
        return
    end

    def builtin_command?(input)
        BUILTINS.include?(input.split.first)
    end

    at_exit { puts 'Goodbye!' }
end
