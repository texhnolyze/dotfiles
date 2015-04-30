class Xresources_Accessor
    attr_reader :path

    def initialize
        @xresources = "#{ENV['HOME']}/.Xresources"
        @tmp_xresources = "/tmp/.Xresources"
        @path = @tmp_xresources if File.exists?(@tmp_xresources) || @xresources
    end

    def create_tmp_xresources(path, lines)
        File.open(@tmp_xresources, 'w') do |file|
            file.puts lines
        end
        load_tmp_xresources
    end

    def load_tmp_xresources
        spawn("xrdb #{@tmp_xresources}")
    end
end
