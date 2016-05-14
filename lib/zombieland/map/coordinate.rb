module Zombieland
  class Map
    class Coordinate
      attr_reader :x, :y

      def initialize(x:, y:)
        @x = x
        @y = y
      end
    end
  end
end
