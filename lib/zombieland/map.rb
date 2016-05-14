module Zombieland
  class Map
    ORIGIN = 0

    attr_reader :dimensions

    def initialize(dimensions:)
      @dimensions = dimensions
    end

    def coordinates
      @coordinates ||= (ORIGIN...dimensions).to_a.repeated_permutation(2).to_a.map do |x, y|
        Coordinate.new(x: x, y: y, map: self)
      end
    end

    def coordinate(x:, y:)
      coordinates.detect { |c| c.x == x && c.y == y }
    end

    def objects
      @objects ||= []
    end

    def objects_at(x:, y:)
      objects.select { |o| o.x == x && o.y == y }
    end

    def place(x:, y:, type:)
      objects << Object.new(x: x, y: y, type: type)
    end
  end
end
