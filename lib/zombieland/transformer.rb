module Zombieland
  class Transformer
    attr_reader :input_file

    def initialize(input_file)
      @input_file = input_file
    end

    def game_input_data
      rows = CSV.new(input_file).to_a

      {
        dimensions:            rows[0][0].to_i,
        zombies_coordinates:   rows[1].map(&:split).map { |c| c.map(&:to_i) },
        creatures_coordinates: rows[2].map(&:split).map { |c| c.map(&:to_i) },
        zombie_movements:      rows[3][0].split('')
      }
    end
  end
end
