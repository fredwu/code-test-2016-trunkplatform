require 'optparse'

module Zombieland
  class CLI
    class Parser
      def self.run
        OptionParser.new do |opts|
          opts.banner = 'Example usage:'

          opts.on('-i', '--input FILE', 'Path to the zombie game input file') do |opt|
            CLI.options[:input_file_path] = opt
          end
        end.parse!
      end
    end
  end
end
