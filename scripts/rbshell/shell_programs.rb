$path = ENV['PATH']

class ShellPrograms
    attr_reader :programs, :path

    def initialize(path = $path)
        @path = path.split(':')
        program_hash
        all_programs_hash
    end
    
    def all_programs_hash
        programs_in_path.each{ |program| @programs[program] }
        @programs
    end

    def program_hash
        @programs = Hash.new do |hash, key| 
            value = key
            key = program_name_from_path(key)
            hash[key] = value 
        end
    end

    def programs_in_path
        list_of_programs = []
        @path.each do |folder|
            add_programs_in_folder(list_of_programs, folder)
        end
        list_of_programs.flatten
    end
     
    def add_programs_in_folder(list, folder)
        programs = Dir.glob(folder + '/*')
        list.push(programs)
    end

    def program_name_from_path(path)
        path.split('/').last.to_sym
    end

end
