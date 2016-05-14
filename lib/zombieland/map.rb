module Zombieland
  class Map
    ORIGIN = 0

    attr_reader :dimensions

    def initialize(dimensions:)
      @dimensions = dimensions
    end

    def coordinates
      @coordinates ||= (ORIGIN...dimensions).to_a.repeated_permutation(2).to_a.map do |x, y|
        Coordinate.new(x: x, y: y)
      end
    end
  end
end
