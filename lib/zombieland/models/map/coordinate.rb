module Zombieland
  module Models
    class Map
      class Coordinate
        attr_reader :x, :y, :map

        def initialize(x:, y:, map:)
          @x   = x
          @y   = y
          @map = map
        end

        def zombies
          objects.select(&:zombie?)
        end

        def creatures
          objects.select(&:creature?)
        end

        def zombies?
          zombies.any?
        end

        def creatures?
          creatures.any?
        end

        private

        def objects
          map.objects_at(x: x, y: y)
        end
      end
    end
  end
end
