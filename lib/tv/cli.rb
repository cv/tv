require 'cli'

module TV
  class Cli
    class << self
      def execute(args)
        new(args).execute!
      end
    end

    def initialize(args)
      @settings = CLI.new do
        description 'Watch live TV and see if it still looks like a rerun!  (Validate your VCR cassettes are up to date)'
        version TV::VERSION
        arguments :files, :cast => Pathname, :description => 'cassettes to validate'
      end.parse!
    end

    def execute!(existing_runtime = nil)
      @settings.files.each do | file |
        puts "Watching live TV looking for rerun: #{file}"
        TV.play(file)
      end
    end
  end
end
