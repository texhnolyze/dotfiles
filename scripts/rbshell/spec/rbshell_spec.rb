require 'spec_helper'

describe RubyShell do
    
    describe '#new' do
        let(:shell_programs){ spy('ShellPrograms') }

        it 'should return instance of RubyShell' do
            ruby_shell = RubyShell.new(shell_programs)
            expect(ruby_shell).to be_an_instance_of RubyShell
        end

        it 'should get the programs from ShellPrograms instance' do
            expect(shell_programs).to receive(:programs)
            RubyShell.new(shell_programs)
        end

    end
end
