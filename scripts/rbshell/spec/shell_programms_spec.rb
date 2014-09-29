require 'spec_helper'
require 'fileutils'

describe ShellPrograms do
    before :all do
        @files = ['/tmp/spec/a', '/tmp/spec/b']
        FileUtils.mkdir('/tmp/spec')
        FileUtils.touch(@files)
    end

    let(:shell_programs){ create_shell_programs }

    def create_shell_programs(path = '/tmp/spec')
        ShellPrograms.new(path)
    end

    describe '#new' do
        it 'should create an instance variable @programs' do
            expect(shell_programs.programs).to be_an_instance_of Hash
        end

        context 'constructor arg path is passed' do
            it 'folders are split into array @path of folders' do
                expect(shell_programs.path).to eq(['/tmp/spec'])
            end
        end

        context 'no path argument is passed to constructor' do 
            it 'should take env variable PATH' do
                expect(ShellPrograms.new.path).to eq(ENV['PATH'].split(':'))
            end
        end
    end

    describe '#all_programs_hash' do
        let(:programs_hash){ shell_programs.all_programs_hash }

        it 'should return a hash' do 
            expect(programs_hash).to be_an_instance_of Hash
        end
        
        it 'should return all files in path as hash values in any order' do
            @files.each { |file| expect(programs_hash.values).to include file }
        end

        it 'should set the programs instance variable' do
            expect(programs_hash).to be shell_programs.programs
        end

        it 'should use file name symbol as hash key' do
            expect(programs_hash.keys).to include :a
            expect(programs_hash.keys).to include :b
        end

        context 'multiple folders passed when creating ShellPrograms' do
            subject{ create_shell_programs('/home:/tmp/spec') }
            it 'all files in all folders added' do
                hash_values = subject.all_programs_hash.values
                files = Dir.glob('/tmp/spec/*')
                files.each { |file| expect(hash_values).to include file }
            end
        end
    end

    after :all do 
        FileUtils.rm(['/tmp/spec/a', '/tmp/spec/b'])
        FileUtils.rmdir('/tmp/spec')
    end
end
