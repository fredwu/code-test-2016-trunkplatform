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

          opts.on('-t', '--tunnelling_wall [NO]', TrueClass, 'Enable the tunnelling wall mode') do |opt|
            CLI.options[:tunnelling_wall] = opt
          end
        end.parse!
      end
    end
  end
end
