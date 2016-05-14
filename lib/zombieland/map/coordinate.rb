module Zombieland
  class Map
    class Coordinate
      attr_reader :x, :y, :map

      def initialize(x:, y:, map:)
        @x   = x
        @y   = y
        @map = map
      end

      def has_zombies?
        objects.select(&:zombie?).any?
      end

      def has_creatures?
        objects.select(&:creature?).any?
      end

      private

      def objects
        map.objects_at(x: x, y: y)
      end
    end
  end
end
